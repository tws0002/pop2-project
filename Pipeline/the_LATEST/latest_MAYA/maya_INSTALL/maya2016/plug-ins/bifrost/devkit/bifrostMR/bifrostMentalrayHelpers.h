//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#ifndef _bifrostMentalrayHelpers_h_
#define _bifrostMentalrayHelpers_h_

#include "bifrostObjectUserData.h"

#include <geoshader.h>
#include <shader.h>

#include <stdlib.h>

#include <map>
#include <string>
#include <vector>

#define MAYA_EPS 1.0E-05f

//==============================================================================
// miVariableGuard
//==============================================================================

template<typename T>
class miVariableGuard
{
public:
	miVariableGuard(T& variable)
		: m_reference(variable), m_oldValue(variable)
	{}

	~miVariableGuard()
	{
		m_reference = m_oldValue;
	}

private:
	T&	m_reference;
	T	m_oldValue;
};

//==============================================================================
// miObjectAccess
//==============================================================================

template<typename T>
class miObjectAccess
{
public:
	miObjectAccess(const miTag& tag)
		: m_tag(tag), m_ptr(NULL)
	{
		m_ptr = (T*)mi_db_access(m_tag);
	}

	~miObjectAccess()
	{
		mi_db_unpin(m_tag);
	}

	const T* operator->() const
	{
		return m_ptr;
	}

	T* operator->()
	{
		return m_ptr;
	}

	operator T*()
	{
		return m_ptr;
	}

private:
	miTag	m_tag;
	T*		m_ptr;
};

//==============================================================================
// miArrayAccess
//==============================================================================

template<typename T>
class miArrayAccess
{
public:
	miArrayAccess(const miTag& tag)
		: m_tag(tag), m_ptr(NULL)
	{
		m_ptr = (T*)mi_db_access(m_tag);
	}

	~miArrayAccess()
	{
		mi_db_unpin(m_tag);
	}

	const T& operator[](size_t i) const
	{
		return m_ptr[i];
	}

	T& operator[](size_t i)
	{
		return m_ptr[i];
	}

private:
	miTag	m_tag;
	T*		m_ptr;
};

//==============================================================================
// miTag2String
//==============================================================================

inline std::string miTag2String(const miTag& tag)
{
	if (tag == miNULLTAG) return std::string();
	std::string str((const char*)mi_db_access(tag));
	mi_db_unpin(tag);
	return str;
}

//==============================================================================
// miObjectEdit
//==============================================================================

template<typename T>
class miObjectEdit
{
public:
	miObjectEdit(const miTag& tag)
		: m_tag(tag), m_ptr(NULL)
	{
		m_ptr = (T*)mi_scene_edit(m_tag);
	}

	~miObjectEdit()
	{
		mi_scene_edit_end(m_tag);
	}

	const T* operator->() const
	{
		return m_ptr;
	}

	T* operator->()
	{
		return m_ptr;
	}

	operator T*()
	{
		return m_ptr;
	}

private:
	miTag	m_tag;
	T*		m_ptr;
};

//==============================================================================
// miTransferInstanceFlags
//==============================================================================

inline void miTransferInstanceFlags(const miInstance* src, miInstance* dst)
{
	// Transfer flags from the parent instance
	dst->visible			= src->visible;
	dst->shadow				= src->shadow;
	dst->reflection			= src->reflection;
	dst->refraction			= src->refraction;
	dst->transparency		= src->transparency;
	dst->caustic			= src->caustic;
	dst->globillum			= src->globillum;
	dst->finalgather		= src->finalgather;
	dst->globillum			= src->globillum;
	dst->shadowmap			= src->shadowmap;
	dst->exclusive			= src->exclusive;
	dst->shadowmap			= src->shadowmap;
	dst->light_list			= src->light_list;
	dst->finalgather_force	= src->finalgather_force;
	dst->shadow_list		= src->shadow_list;
	dst->shading_samples	= src->shading_samples;
	dst->finalgather_force	= src->finalgather_force;
	dst->label				= src->label;

	// Important to append the user data instead of overwritting it since setFOSC sets it.
	if (src->userdata != 0)
		dst->userdata = mi_api_data_append(dst->userdata, src->userdata);
}

//=============================================================================
// miBBox2CubeMatrix
//=============================================================================

// Compute a transform matrix to move the bounding cube around
// based on a world oriented bounding box
inline void miBBox2CubeMatrix(const double bboxMin[3], const double bboxMax[3], miMatrix& cubeMatrix)
{
	miVector scale, translate;
	scale.x = fabs(float(bboxMax[0] - bboxMin[0]));
	scale.y = fabs(float(bboxMax[1] - bboxMin[1]));
	scale.z = fabs(float(bboxMax[2] - bboxMin[2]));
	translate.x = 0.5f*scale.x + float(bboxMin[0]);
	translate.y = 0.5f*scale.y + float(bboxMin[1]);
	translate.z = 0.5f*scale.z + float(bboxMin[2]);

	mi_matrix_ident(cubeMatrix);
	cubeMatrix[0] = scale.x;
	cubeMatrix[5] = scale.y;
	cubeMatrix[10] = scale.z;
	cubeMatrix[12] = translate.x;
	cubeMatrix[13] = translate.y;
	cubeMatrix[14] = translate.z;
}

//=============================================================================
// miAttachBifrostObjectUserData
//=============================================================================

inline void miAttachBifrostObjectUserData(const BifrostObjectUserData& objectRef, miInstance* inst, const char* name)
{
	// Attach the user data to the mentalray instance
	std::string userdata;
	userdata += objectRef.file() + "\n";
	userdata += objectRef.object() + "\n";

	// Allocate memory and copy opaque string to it
	const size_t count = userdata.size() + 1;
	miUchar* buffer = (miUchar*)mi_mem_allocate((miUint)count);
	strcpy((char*)buffer, userdata.c_str());
	buffer[count-1] = '\0';

	// Create the user data block and attach it to the instance
	miUserdata* datablock = mi_api_data_begin(mi_mem_strdup(name), 0, (void*)count);
	datablock->label = 'BFUD';
	mi_api_data_byte_copy((int)count, buffer);
	miTag tagDataBlock = mi_api_data_end();
	inst->userdata = mi_api_data_append(inst->userdata, tagDataBlock);
};

//=============================================================================
// miGetBifrostObjectUserData
//=============================================================================

inline bool miGetBifrostObjectUserData(const miTag& tagInst, BifrostObjectUserData& objectRef)
{
	if (mi_db_type(tagInst) != miSCENE_INSTANCE)
		return false;

	miObjectAccess<miInstance> inst(tagInst);

	miTag tagUserData = inst->userdata;
	while (tagUserData != miNULLTAG)
	{
		miObjectAccess<miUserdata> userdata(tagUserData);
		if (userdata->label == 'BFUD')
		{
			// User data created from the geoshader
			std::string file, object;
			std::stringstream ss(std::string(userdata->parameters));
			std::getline(ss, file);
			std::getline(ss, object);
			objectRef = BifrostObjectUserData(object, file);
			return true;
		}
		else if (userdata->data_decl != miNULLTAG)
		{
			// User data attached to the maya mesh transform
			const char* declName = mi_api_tag_lookup(userdata->data_decl);
			if (declName && std::string(declName) == "mib_data_string")
			{
				std::string strName = miTag2String(((miTag*)userdata->parameters)[0]);
				if (strName == "bifrostMeshObject")
				{
					std::string strValue = miTag2String(((miTag*)userdata->parameters)[1]);
					objectRef = BifrostObjectUserData(strValue, std::string());
					return true;
				}
			}
		}
		tagUserData = userdata->next_data;
	}

	return false;
};

//=============================================================================
// miFindBifrostObjectUserData
//=============================================================================

// Find the Bifrost object from the user data installed on the instance
inline bool miFindBifrostObjectUserData(miState* state, BifrostObjectUserData& objectRef)
{
	miTag tagInst = state->instance;

	// Must have an instance, check the parent ray for the first instance we find
	if (tagInst == miNULLTAG)
	{
		for (const miState* s = state->parent; s; s = s->parent)
		{
			if (s->instance)
			{
				tagInst = s->instance;
				break;
			}
		}
	}

	// Can't find a valid instance
	if (tagInst == miNULLTAG)
		return false;

	// Check the instance
	if (miGetBifrostObjectUserData(tagInst, objectRef))
		return true;

	// or the instance's parents if we failed
	miObjectAccess<miInstance> leafInst(tagInst);
	miTag* leafHistory = miLEAFHISTORY(leafInst);
	for (miUint l = 0; l < leafInst->history_size; l++)
	{
		if (miGetBifrostObjectUserData(leafHistory[l], objectRef))
			return true;
	}

	return false;
}

//==============================================================================
// miUpdateStateAfterHit
//==============================================================================

// Update the mi state When the isosurface is hit based on new position and normal.
inline void miUpdateStateAfterHit(miState* state, const miVector& p, const miVector& n, bool flipNormal)
{
	// Move the position on the ray
	state->point = p;

	// Update the state normal
	state->normal = n;

	//state->normal = state->point; // HACK for sphere intersection
	mi_vector_normalize(&state->normal);

	// Update dot_nd
	state->dot_nd = mi_vector_dot(&state->normal, &state->dir);
	if (flipNormal)
	{
		if (state->dot_nd > 0.0f)
		{
			state->dot_nd = -state->dot_nd;
			mi_vector_neg(&state->normal);
			state->inv_normal = miTRUE;
		}
		else
		{
			state->inv_normal = miFALSE;
		}
	}
	state->normal_geom = state->normal;

	// Update ray length
	miVector distVec;
	mi_vector_sub(&distVec, &state->point, &state->org);
	state->dist = mi_vector_norm(&distVec);

	// No real geometry on hit. This must be set to zero.
	state->pri = 0;

	// Must set the instance
	if (state->instance == 0)
	{
		for (const miState *s=state->parent; s; s=s->parent)
		{
			if (s->instance)
			{
				state->instance = s->instance;
				break;
			}
		}
	}
};

inline void miUpdateStateAfterHit(miState* state, const amino::Math::vec3f& p, const amino::Math::vec3f& n, bool flipNormal)
{
	miUpdateStateAfterHit(state, *((const miVector*)&p), *((const miVector*)&n), flipNormal);
}

//==============================================================================
// miShaderState
//==============================================================================

// This class manages shader states and wraps set/get functions.
// Note that only POD types are supported. Key must be string constant.
template<typename T>
class miShaderState
{
public:
	miShaderState(miState* state, const char* key, const T defaultValue)
		: m_state(state), m_key(key), m_defaultValue(defaultValue)
	{
		// Set to default value if there isn't a shader state.
		int size = 0;
		void* prev = mi_shaderstate_get(m_state, m_key, &size);
		if (!prev || size != sizeof(T))
		{
			set(m_defaultValue);
		}
	}

	~miShaderState()
	{}

	T get() const
	{
		int size = 0;
		T* value = (T*)mi_shaderstate_get(m_state, m_key, &size);
		return (value && size == sizeof(T)) ? *value : m_defaultValue;
	}

	void set(const T value)
	{
		mi_shaderstate_set(m_state, m_key, (void*)&value, (int)sizeof(T), miSS_LIFETIME_RECT);
	}

private:
	miState*	m_state;
	const char*	m_key;
	const T		m_defaultValue;
};

//==============================================================================
// miScopedShaderState
//==============================================================================

// This class provides a stack-like shader state.
// When entering the scope, the constructor will backup the previous shader state.
// Callers are free to change the shader state within the scope.
// When exiting the scope, the destructor will restore the previous shader state.
template<typename T>
class miScopedShaderState
{
public:
	miScopedShaderState(miShaderState<T>& shaderstate)
		: m_shaderstate(shaderstate), m_prev(shaderstate.get())
	{}

	~miScopedShaderState()
	{
		// Restore the previous value
		m_shaderstate.set(m_prev);
	}

private:
	miShaderState<T>&	m_shaderstate;
	const T				m_prev;
};

//==============================================================================
// miShaderUserInit
//==============================================================================

// This function creates a shader object and call its init() method.
template<typename SHADER>
void miShaderUserInit(miState* state, void* paras, miBoolean* inst_req)
{
	if (!paras) /* main shader init */
	{
		*inst_req = miTRUE; /* want inst inits too */
	}
	else /* shader instance init */
	{
		SHADER* ptr = new SHADER();
		if (!ptr->init(state, reinterpret_cast<typename SHADER::Params*>(paras)))
		{
			delete ptr;
			ptr = NULL;
		}
		void** user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		*user = ptr;
	}
}

//==============================================================================
// miShaderUserExit
//==============================================================================

// This function deletes a shader object and call its exit() method.
template<typename SHADER>
void miShaderUserExit(miState* state, void* paras)
{
	if (!paras) /* main shader exit */
	{
		/* no further inst exits will occur */
	}
	else /* shader instance exit */
	{
		void** user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		if (*user)
		{
			SHADER* ptr = reinterpret_cast<SHADER*>(*user);
			ptr->exit(state, reinterpret_cast<typename SHADER::Params*>(paras));
			delete ptr;
		}
		*user = NULL;
	}
}

//==============================================================================
// miShaderUserExecute
//==============================================================================

// This function calls a shader object's execute method.
template<typename SHADER, typename RESULT>
miBoolean miShaderUserExecute(RESULT* result, miState* state, void* paras)
{
	void** user;
	mi_query(miQ_FUNC_USERPTR, state, 0, &user);
	if (*user)
	{
		SHADER* ptr = reinterpret_cast<SHADER*>(*user);
		return ptr->execute(result, state, reinterpret_cast<typename SHADER::Params*>(paras));
	}
	return miFALSE;
}

//==============================================================================
// miShaderUserPerInstanceInit
//==============================================================================

// This function actually does nothing. The per-instance shader is initialized on
// its first execution with an instance.
template<typename SHADER>
void miShaderUserPerInstanceInit(miState* state, void* paras, miBoolean* inst_req)
{
	*inst_req = miTRUE;
}

//==============================================================================
// miShaderUserPerInstanceExit
//==============================================================================

// This function deletes per-instance shader objects and call their exit() methods.
template<typename SHADER>
void miShaderUserPerInstanceExit(miState* state, void* paras)
{
	typedef std::map<miTag,SHADER*> ShaderPerInstanceMap;

	// main shader exit
	if (!paras)
		return;

	ShaderPerInstanceMap** perInstMaps = NULL;
	int perInstMapCount = 0;
	mi_query(miQ_FUNC_TLS_GETALL, state, miNULLTAG, &perInstMaps, &perInstMapCount);

	// Iterate through all per-instance shaders and call exit() method.
	for (int i = 0; i < perInstMapCount; i++)
	{
		if (!perInstMaps[i])
			continue;

		for (typename ShaderPerInstanceMap::iterator it = perInstMaps[i]->begin();
			it != perInstMaps[i]->end();
			it++)
		{
			SHADER* ptr = it->second;
			if (ptr)
			{
				ptr->exit(state, reinterpret_cast<typename SHADER::Params*>(paras));
				delete ptr;
			}
		}

		delete perInstMaps[i];
	}
}

//==============================================================================
// miShaderUserPerInstanceExecute
//==============================================================================

// This function calls a per-instance shader object's execute method based on the tag of the miInstances seen on the miState.
// A new shader is created and initialized per miInstane to ensure a different shader is used per instance.
// This allows the same shader instance to be applied on multiple bifrost objects.
// The per-instance shader is created per-thread to avoid locking.
template<typename SHADER, typename RESULT>
miBoolean miShaderUserPerInstanceExecute(RESULT* result, miState* state, void* paras)
{
	typedef std::map<miTag,SHADER*> ShaderPerInstanceMap;

	// Retrieve the ShaderPerInstanceMap from thread-local storage. Create it if it doesn't exist.
	ShaderPerInstanceMap* perInstMap = NULL;
	mi_query(miQ_FUNC_TLS_GET, state, miNULLTAG, &perInstMap);
	if (!perInstMap)
	{
		perInstMap = new ShaderPerInstanceMap();
		mi_query(miQ_FUNC_TLS_SET, state, miNULLTAG, &perInstMap);
	}

	if (!perInstMap)
		return miFALSE;

	// Must have an instance, check the parent ray for the first instance we find
	miTag tagInst = state->instance;
	if (tagInst == miNULLTAG)
	{
		for (const miState* s = state->parent; s; s = s->parent)
		{
			if (s->instance)
			{
				tagInst = s->instance;
				break;
			}
		}
	}

	typename ShaderPerInstanceMap::iterator it = perInstMap->find(tagInst);

	// Shader not found, create a new shader instance.
	SHADER* ptr = NULL;
	if (it == perInstMap->end())
	{
		ptr = new SHADER();
		if (!ptr->init(state, reinterpret_cast<typename SHADER::Params*>(paras)))
		{
			// Init didn't work, delete the shader
			// An entry with a null pShader is added to the map to ensure
			// invalid instances are skipped.
			delete ptr;
			ptr = NULL;
		}
		(*perInstMap)[tagInst] = ptr;
	}
	else
	{
		ptr = it->second;
	}

	if (ptr)
	{
		return ptr->execute(result, state, reinterpret_cast<typename SHADER::Params*>(paras));
	}

	return miFALSE;
}

//==============================================================================
// miFunctionCall
//==============================================================================

class miFunctionCall
{
public:
	miFunctionCall(const char* name)
		: m_tag(miNULLTAG), m_end(false)
	{
		// Begin a function call with the specified name.
		mi_api_function_call(mi_mem_strdup(name));
	}

	~miFunctionCall()
	{
		if (!m_end) end();
	}

	bool setScalarParameter(const char* name, const miScalar* value)
	{
		return mi_api_parameter_name(mi_mem_strdup(name)) &&
			mi_api_parameter_value(miTYPE_SCALAR, (void*)value, NULL, NULL);
	}

	bool setVectorParameter(const char* name, const miVector* value)
	{
		return mi_api_parameter_name(mi_mem_strdup(name)) &&
			mi_api_parameter_value(miTYPE_VECTOR, (void*)value, NULL, NULL);
	}

	bool setIntegerParameter(const char* name, const miInteger* value)
	{
		return mi_api_parameter_name(mi_mem_strdup(name)) &&
			mi_api_parameter_value(miTYPE_INTEGER, (void*)value, NULL, NULL);
	}

	bool setBoolParameter(const char* name, const miBoolean* value)
	{
		return mi_api_parameter_name(mi_mem_strdup(name)) &&
			mi_api_parameter_value(miTYPE_BOOLEAN, (void*)value, NULL, NULL);
	}

	bool setStringParameter(const char* name, const char* value)
	{
		return mi_api_parameter_name(mi_mem_strdup(name)) &&
			mi_api_parameter_value(miTYPE_STRING,  mi_mem_strdup(value), NULL, NULL);
	}

	bool setTagParameter(const char* name, const miTag* value)
	{
		return mi_api_parameter_name(mi_mem_strdup(name)) &&
			mi_api_parameter_value(miTYPE_INTEGER, (void*)value, NULL, NULL);
	}

	bool setArrayTagParameter(const char* name, const std::vector<miTag>& value)
	{
		mi_api_parameter_name(mi_mem_strdup(name));
		mi_api_parameter_push(miTRUE /*array*/);
		for (size_t i = 0; i < value.size(); i++)
		{
			mi_api_new_array_element();
			mi_api_parameter_value(miTYPE_INTEGER, (void*)&value[i], NULL, NULL);
		}
		mi_api_parameter_pop();
		return true;
	}

	miTag end()
	{
		// End the function call and return the tag.
		if (!m_end)
		{
			m_tag = mi_api_function_call_end(miNULLTAG);
			m_end = true;
		}
		return m_tag;
	}

	miTag end(const miTag& old)
	{
		// End the incremental function call
		if (!m_end)
		{
			m_tag = mi_api_function_call_end(old);
			m_end = true;
		}
		return m_tag;
	}

private:
	miTag	m_tag;
	bool	m_end;
};

//==============================================================================
// miFunctionEdit
//==============================================================================

class miFunctionEdit
{
public:
	miFunctionEdit(const miTag& tag)
		: m_tag(tag), m_end(false), m_ptr(NULL)
	{
		// Begin a function edit with the specified tag.
		m_ptr = (miFunction*)mi_scene_edit(tag);
	}

	~miFunctionEdit()
	{
		if (!m_end) end();
	}

	template<typename T>
	bool setParameter(const char* name, const miParam_type type, const T& value)
	{
		if (!m_ptr) return false;

		int				paramOffset = -1;
		miParam_type	paramType;
		miBoolean ret = mi_api_parameter_lookup(&paramType, 0, &paramOffset,
			m_ptr->function_decl, miFALSE, mi_mem_strdup(name));

		if (ret && paramType == type)
		{
			T* param = (T*)(m_ptr->parameters + paramOffset);
			*param = value;
			return true;
		}

		return false;
	}

	void end()
	{
		// End the function edit.
		if (!m_end)
		{
			mi_scene_edit_end(m_tag);
			m_end = true;
		}
	}

private:
	miTag		m_tag;
	bool		m_end;
	miFunction*	m_ptr;
};

//==============================================================================
// miMaterialCall
//==============================================================================

class miMaterialCall
{
public:
	miMaterialCall(const char* name)
		: m_tag(miNULLTAG), m_end(false), m_ptr(NULL)
	{
		// Begin a material call with the specified name.
		m_ptr = mi_api_material_begin(mi_mem_strdup(name));
	}

	~miMaterialCall()
	{
		if (!m_end) end();
	}

	const miMaterial* operator->() const
	{
		return m_ptr;
	}

	miMaterial* operator->()
	{
		return m_ptr;
	}

	operator miMaterial*()
	{
		return m_ptr;
	}

	miTag end()
	{
		// End the material call and return the tag.
		if (!m_end)
		{
			m_tag = mi_api_material_end();
			m_end = true;
		}
		return m_tag;
	}

private:
	miTag		m_tag;
	bool		m_end;
	miMaterial*	m_ptr;
};

//==============================================================================
// miInstanceCall
//==============================================================================

class miInstanceCall
{
public:
	miInstanceCall(const char* name)
		: m_tag(miNULLTAG), m_end(false), m_ptr(NULL)
	{
		// Begin an instance call with the specified name.
		m_ptr = mi_api_instance_begin(mi_mem_strdup(name));
	}

	~miInstanceCall()
	{
		if (!m_end) end(miNULLTAG);
	}

	const miInstance* operator->() const
	{
		return m_ptr;
	}

	miInstance* operator->()
	{
		return m_ptr;
	}

	operator miInstance*()
	{
		return m_ptr;
	}

	miTag end(const miTag& tagGeo)
	{
		// End the instance call and return the tag.
		if (!m_end)
		{
			m_tag = mi_api_instance_end(NULL, tagGeo, miNULLTAG);
			m_end = true;
		}
		return m_tag;
	}

	miTag end(const char* name)
	{
		// End the instance call and return the tag.
		if (!m_end)
		{
			m_tag = mi_api_instance_end(mi_mem_strdup(name), miNULLTAG, miNULLTAG);
			m_end = true;
		}
		return m_tag;
	}

private:
	miTag		m_tag;
	bool		m_end;
	miInstance*	m_ptr;
};

//==============================================================================
// miObjectCall
//==============================================================================

class miObjectCall
{
public:
	miObjectCall(const char* name)
		: m_tag(miNULLTAG), m_end(false), m_ptr(NULL)
	{
		// Begin an object call with the specified name.
		m_ptr = mi_api_object_begin(mi_mem_strdup(name));
	}

	miObjectCall(const miTag& tag)
		: m_tag(miNULLTAG), m_end(false), m_ptr(NULL)
	{
		// Begin an incremental object change with the specified tag.
		const char* name = mi_api_tag_lookup(tag);
		mi_api_incremental(miTRUE);
		m_ptr = mi_api_object_begin(mi_mem_strdup(name));
	}

	~miObjectCall()
	{
		if (!m_end) end();
		mi_api_incremental(miFALSE);
	}

	const miObject* operator->() const
	{
		return m_ptr;
	}

	miObject* operator->()
	{
		return m_ptr;
	}

	operator miObject*()
	{
		return m_ptr;
	}

	miTag end()
	{
		// End the object call and return the tag.
		if (!m_end)
		{
			m_tag = mi_api_object_end();
			m_end = true;
		}
		return m_tag;
	}

private:
	miTag		m_tag;
	bool		m_end;
	miObject*	m_ptr;
};

//==============================================================================
// miDataCall
//==============================================================================

class miDataCall
{
public:
	miDataCall(const char* name, const miTag& function)
		: m_tag(miNULLTAG), m_end(false), m_ptr(NULL)
	{
		// Create a user data with the function
		m_ptr = mi_api_data_begin(mi_mem_strdup(name), 2, (void*)function);
	}

	~miDataCall()
	{
		if (!m_end) end();
	}

	const miUserdata* operator->() const
	{
		return m_ptr;
	}

	miUserdata* operator->()
	{
		return m_ptr;
	}

	operator miUserdata*()
	{
		return m_ptr;
	}

	miTag end()
	{
		// End the user data call and return the tag.
		if (!m_end)
		{
			m_tag = mi_api_data_end();
			m_end = true;
		}
		return m_tag;
	}

private:
	miTag		m_tag;
	bool		m_end;
	miUserdata*	m_ptr;
};

//==============================================================================
// miEchoGeoShader
//==============================================================================

inline void miEchoGeoShader(const miTag& tag)
{
	const char* fileName = getenv("BIFROST_ECHO_GEOSHADER");
	if (fileName)
	{
		miEchoOptions opts;
		memset(&opts, 0, sizeof(opts));
		opts.ascii_output = miTRUE;

		FILE* file = fopen(fileName, "wt");
		if (!file)
		{
			mi_warning("Can't open echo file for writing: %s", fileName);
			return;
		}
		mi_geoshader_echo_tag(file, tag, &opts);
		fclose(file);
	}
}

inline void miEchoGeoShaderResult(miTag* result)
{
	const char* fileName = getenv("BIFROST_ECHO_GEOSHADER");
	if (fileName)
	{
		miEchoOptions opts;
		memset(&opts, 0, sizeof(opts));
		opts.ascii_output = miTRUE;

		miBoolean ret = mi_geoshader_echo_tag_file(fileName, false, NULL, *result, &opts);

		if (!ret)
			mi_warning("Can't open echo file for writing: %s", fileName);
	}
}


#endif // _bifrostMentalrayHelpers_h_
