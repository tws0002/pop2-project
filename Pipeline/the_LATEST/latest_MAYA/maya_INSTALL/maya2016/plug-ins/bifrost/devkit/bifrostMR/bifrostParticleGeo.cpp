//*****************************************************************************
// Copyright 2014 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
//*****************************************************************************

#include "bifrostHelpers.h"
#include "bifrostMentalrayHelpers.h"
#include "bifrostObjectUserData.h"

#include <bifrostapi/bifrost_component.h>
#include <bifrostapi/bifrost_pointchannel.h>
#include <bifrostapi/bifrost_array.h>
#include <bifrostapi/bifrost_visitor.h>
#include <bifrostapi/bifrost_tiledataaccessor.h>

#include <geoshader.h>

#include <limits>

namespace
{

// This class initializes a map container for particles and fills the
// container with particle data.
class ParticleEmitter
{
public:
	// The map object declaration. Before creating map objects, we must have
	// a proper declaration for the map format.
	static std::string Declare(const Bifrost::API::RefArray& extraChannels)
	{
		// Determine the name of the map object declaration. The channel type and name are
		// encoded so that we have a unique declaration for every combination.
		std::stringstream nameMangling;

		for (size_t i = 0; i < extraChannels.count(); i++)
		{
			const Bifrost::API::PointChannel channel = extraChannels[i];
			nameMangling << "_" << GetMapFieldTypeName(channel) << "_" << GetChannelName(channel);
		}

		// Hash the name as mentalray does not allow long names
		std::stringstream nameOut;
		nameOut << "bifrost_particle_geo[md]_" << std::hex << (unsigned int)std::hash<std::string>()(nameMangling.str());

		// The final name of map declaration
		const std::string name = nameOut.str();

		if (mi_api_name_lookup(mi_mem_strdup(name.c_str())) != miNULLTAG)
			return name;	// already declared

		// Begin the declaration
		// Note that we don't need to declare the position field
		mi_api_map_decl_dim(3);

		// Global fields
		miParameter* radiusField	= mi_api_map_field_decl(miTYPE_SCALAR,	mi_mem_strdup("radius"),	0,	miTRUE);
		miParameter* colorField		= mi_api_map_field_decl(miTYPE_COLOR,	mi_mem_strdup("color"),		0,	miTRUE);
		miParameter* fieldsList		= mi_api_map_field_append(radiusField, colorField);

		// Motion field
		fieldsList = mi_api_map_field_append(fieldsList,
			mi_api_map_field_decl(miTYPE_VECTOR, mi_mem_strdup("motion"), 0, miFALSE)
		);

		// Velocity field
		fieldsList = mi_api_map_field_append(fieldsList,
			mi_api_map_field_decl(miTYPE_VECTOR, mi_mem_strdup("velocity"), 0, miFALSE)
		);

		// Other fields
		for (size_t i = 0; i < extraChannels.count(); i++)
		{
			// Declare a field and append to the fields list
			const Bifrost::API::PointChannel channel = extraChannels[i];
			fieldsList = mi_api_map_field_append(fieldsList,
				mi_api_map_field_decl(GetMapFieldType(channel), mi_mem_strdup(GetChannelName(channel).c_str()), 0, miFALSE)
			);
		}

		mi_api_map_decl_begin(mi_mem_strdup(name.c_str()), fieldsList);
		mi_api_map_decl_end();
		return name;
	}

	ParticleEmitter(const std::string& name, const miScalar& radius, const miColor& color)
		: m_particleCount(0)
	{
		// Start sphere particle map object
		mi_api_map_obj_type(mi_mem_strdup("spheres"));
		mi_api_map_begin(mi_mem_strdup(name.c_str()));

		// Globals: Radius
		mi_api_map_global_value(miTYPE_SCALAR, (void*)&radius);
		mi_api_map_field_end();

		// Globals: Color
		mi_api_map_global_value(miTYPE_SCALAR, (void*)&color.r);
		mi_api_map_global_value(miTYPE_SCALAR, (void*)&color.g);
		mi_api_map_global_value(miTYPE_SCALAR, (void*)&color.b);
		mi_api_map_global_value(miTYPE_SCALAR, (void*)&color.a);
		mi_api_map_field_end();

		mi_api_map_global_end();
	}

	~ParticleEmitter()
	{
		// End the map object
		mi_api_map_end(0);
	}

	// Begin to emit a single particle to the map object
	void emit(
		const amino::Math::vec3f&					position,
		const amino::Math::vec3f&					motion,
		const amino::Math::vec3f&					velocity,
		const std::vector<Bifrost::API::DataType>&	tileType,
		const std::vector<const void*>&				tileData
	)
	{
		// Position Field
		mi_api_map_value(miTYPE_SCALAR, (void*)&position[0]);
		mi_api_map_value(miTYPE_SCALAR, (void*)&position[1]);
		mi_api_map_value(miTYPE_SCALAR, (void*)&position[2]);
		mi_api_map_field_end();

		// Motion Field
		mi_api_map_value(miTYPE_SCALAR, (void*)&motion[0]);
		mi_api_map_value(miTYPE_SCALAR, (void*)&motion[1]);
		mi_api_map_value(miTYPE_SCALAR, (void*)&motion[2]);
		mi_api_map_field_end();

		// Velocity Field
		mi_api_map_value(miTYPE_SCALAR, (void*)&velocity[0]);
		mi_api_map_value(miTYPE_SCALAR, (void*)&velocity[1]);
		mi_api_map_value(miTYPE_SCALAR, (void*)&velocity[2]);
		mi_api_map_field_end();

		// Other fields
		for (size_t i = 0; i < tileType.size(); i++)
		{
			switch (tileType[i])
			{
			case Bifrost::API::FloatType:
				{
					const float fieldValue =
						tileData[i]
						? *reinterpret_cast<const float*>(tileData[i])
						: 0.0f;
					
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldValue);
					mi_api_map_field_end();
				}
				break;
			case Bifrost::API::FloatV2Type:
				{
					const amino::Math::vec2f fieldValue =
						tileData[i]
						? *reinterpret_cast<const amino::Math::vec2f*>(tileData[i])
						: amino::Math::vec2f();
					const float fieldZero = 0.0f;
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldValue[0]);
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldValue[1]);
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldZero);
					mi_api_map_field_end();
				}
				break;
			case Bifrost::API::FloatV3Type:
				{
					const amino::Math::vec3f fieldValue =
						tileData[i]
						? *reinterpret_cast<const amino::Math::vec3f*>(tileData[i])
						: amino::Math::vec3f();
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldValue[0]);
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldValue[1]);
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldValue[2]);
					mi_api_map_field_end();
				}
				break;
			default:
				{
					const float fieldZero = 0.0f;
					mi_api_map_value(miTYPE_SCALAR, (void*)&fieldZero);
					mi_api_map_field_end();
				}
				break;
			}
		}

		mi_api_map_element_end();
		m_particleCount++;
	}

	size_t count() const
	{
		return m_particleCount;
	}

private:
	// Helper function to return the channel name of a point channel
	static std::string GetChannelName(const Bifrost::API::PointChannel& channel)
	{
		Bifrost::API::String name = channel.name();
		size_t pos = name.rfind('/');
		if (pos != std::string::npos)
			name = name.substr(pos + 1);
		return name.c_str();
	}

	// Helper function to return the translated type name of a point channel
	static const char* GetMapFieldTypeName(const Bifrost::API::PointChannel& channel)
	{
		switch (channel.dataType())
		{
		case Bifrost::API::FloatType:
			return "miScalar";
		case Bifrost::API::FloatV2Type:
			return "miVector";
		case Bifrost::API::FloatV3Type:
			return "miVector";
		default:
			mi_warning("Unrecognized channel type. Forcing to miScalar");
			return "miScalar";
		}
	}

	// Helper function to return the translated type of a point channel
	static miParam_type GetMapFieldType(const Bifrost::API::PointChannel& channel)
	{
		switch (channel.dataType())
		{
		case Bifrost::API::FloatType:
			return miTYPE_SCALAR;
		case Bifrost::API::FloatV2Type:
			return miTYPE_VECTOR;
		case Bifrost::API::FloatV3Type:
			return miTYPE_VECTOR;
		default:
			mi_warning("Unrecognized channel type. Forcing to miTYPE_SCALAR");
			return miTYPE_SCALAR;
		}
	}

	size_t m_particleCount;
};

// Particle channels to be translated to mentalray
struct ParticleChannels
{
	std::string					declaration;
	miScalar					radius;		// Global
	miColor						color;		// Global
	Bifrost::API::PointChannel	positionChannel;
	Bifrost::API::PointChannel	velocityChannel;
	Bifrost::API::RefArray		extraChannels;

	// Motion blur related
	miScalar					frame;
	miScalar					fps;
	miBoolean					motionBlurEnable;
	miScalar					shutterOpen;
	miScalar					shutterClose;
};

// This is the placeholder for map container objects.
// On execute() callback, it creates a map container for the specified tiles.
class ParticleTilePlaceHolder
{
public:
	ParticleTilePlaceHolder(
		const std::vector<Bifrost::API::TreeIndex>&	tiles,
		const ParticleChannels&						channels)
		:	m_tiles(tiles),
			m_channels(channels)
	{}

	~ParticleTilePlaceHolder()
	{}

	miBoolean execute(miTag tag, miObject* object)
	{
		// Incremental change the placeholder to map container
		miObjectCall resultObject(tag);

		// Get world space conversion
		const Bifrost::API::Layout		layout		= m_channels.positionChannel.layout();
		const Bifrost::API::Component	component	= m_channels.positionChannel.component();
		const float						voxelScale	= layout.voxelScale();
		const Bifrost::Math::Similarity	similarity	= component.world();

		// Create the map container object
		ParticleEmitter emitter(m_channels.declaration, m_channels.radius, m_channels.color);

		// Get the tile data accessor
		const Bifrost::API::TileDataAccessor positionAccessor = m_channels.positionChannel.tileDataAccessor();
		const Bifrost::API::TileDataAccessor velocityAccessor = m_channels.velocityChannel.tileDataAccessor();

		// Stack other tile data together. We assume a continuous memory block here.
		std::vector<Bifrost::API::DataType>	tileType;
		std::vector<const void*>			tileBase;
		std::vector<const void*>			tileData;
		std::vector<size_t>					tileSize;

		for (size_t i = 0; i < m_channels.extraChannels.count(); i++)
		{
			const Bifrost::API::PointChannel channel = m_channels.extraChannels[i];
			tileType.push_back(channel.dataType());
			tileBase.push_back(NULL);
			tileData.push_back(NULL);
			tileSize.push_back(0);
		}

		// Iterate through tiles and emit particles
		typedef std::vector<Bifrost::API::TreeIndex>::const_iterator IteratorType;
		for (IteratorType it = m_tiles.begin(); it != m_tiles.end(); it++)
		{
			// Get tile data
			const Bifrost::API::TileData<amino::Math::vec3f> positionTile =
				positionAccessor.tileData<amino::Math::vec3f>(*it);
			const Bifrost::API::TileData<amino::Math::vec3f> velocityTile =
				velocityAccessor.tileData<amino::Math::vec3f>(*it);

			// Get other tile data
			for (size_t i = 0; i < m_channels.extraChannels.count(); i++)
			{
				const Bifrost::API::PointChannel channel = m_channels.extraChannels[i];
				tileBase[i] = channel.tileDataPtr(*it, tileSize[i]);
			}

			// Loop over particles and emit
			for (size_t i = 0; i < positionTile.count(); i++)
			{
				// Convert position to world space
				amino::Math::vec3f position = similarity.apply(voxelScale * positionTile[i]);
				amino::Math::vec3f motion = amino::Math::vec3f(0.0f, 0.0f, 0.0f);
				amino::Math::vec3f velocity = (i < velocityTile.count()) ? velocityTile[i] : amino::Math::vec3f();

				// Advance the pointers
				for (size_t ch = 0; ch < m_channels.extraChannels.count(); ch++)
				{
					if (i >= tileSize[ch] || !tileBase[ch])
						continue;

					switch (tileType[ch])
					{
					case Bifrost::API::FloatType:
						tileData[ch] = reinterpret_cast<const float*>(tileBase[ch]) + i;
						break;
					case Bifrost::API::FloatV2Type:
						tileData[ch] = reinterpret_cast<const amino::Math::vec2f*>(tileBase[ch]) + i;
						break;
					case Bifrost::API::FloatV3Type:
						tileData[ch] = reinterpret_cast<const amino::Math::vec3f*>(tileBase[ch]) + i;
						break;
					}
				}

				// Compute motion vector. Note that velocity is in world space
				if (m_channels.motionBlurEnable)
				{
					// Get the current time of Bifrost cache
					const miScalar currentFrame = std::floor(m_channels.frame);
					const miScalar shutterOpen  = m_channels.shutterOpen;
					const miScalar shutterClose = m_channels.shutterClose;
					const miScalar fps          = m_channels.fps;

					// Move position from current time to shuuter open time
					position = position - velocity / fps * (currentFrame - shutterOpen);
					motion   = velocity / fps * (shutterClose - shutterOpen);
				}

				// Emit
				emitter.emit(position, motion, velocity, tileType, tileData);
			}
		}

		return emitter.count() > 0 ? miTRUE : miFALSE;
	}

public:
	// Mentalray's placeholder execute callback
	static miBoolean exec(miTag tag, miObject* object, void* args)
	{
		return reinterpret_cast<ParticleTilePlaceHolder*>(args)->execute(tag, object);
	}

	// Mentalray's placeholder delete callback
	static miBoolean del(miTag tag, void* args)
	{
		delete reinterpret_cast<ParticleTilePlaceHolder*>(args);
		return miTRUE;
	}

private:
	const std::vector<Bifrost::API::TreeIndex>	m_tiles;
	const ParticleChannels						m_channels;
};

// This class generates placeholders and instances for the given tiles
class PlaceHolderGenerator
{
public:
	PlaceHolderGenerator(miTag* result, miState* state, const ParticleChannels&	channels)
		:	m_result(result), m_state(state), m_channels(channels), m_placeHolderCount(0)
	{ reset(); }

	~PlaceHolderGenerator() {}

	void addTile(
		const amino::Math::vec3f&		boundingBoxMin,
		const amino::Math::vec3f&		boundingBoxMax,
		const Bifrost::API::TreeIndex&	index)
	{
		// No particles, skip
		if (boundingBoxMin[0] >= boundingBoxMax[0] ||
			boundingBoxMin[1] >= boundingBoxMax[1] ||
			boundingBoxMin[2] >= boundingBoxMax[2]) return;

		// Expand the bounding box of the placeholder
		for (int i = 0; i < 3; i++)
		{
			m_boundingBoxMin[i] = std::min(m_boundingBoxMin[i], boundingBoxMin[i]);
			m_boundingBoxMax[i] = std::max(m_boundingBoxMax[i], boundingBoxMax[i]);
		}

		// Add the tile to the tile list
		m_tiles.push_back(index);
	}

	void createPlaceHolder()
	{
		// No particles, skip
		if (m_boundingBoxMin[0] >= m_boundingBoxMax[0] ||
			m_boundingBoxMin[1] >= m_boundingBoxMax[1] ||
			m_boundingBoxMin[2] >= m_boundingBoxMax[2] ||
			m_tiles.empty()) return;

		// Increment the placeholder id
		const size_t placeHolderID = m_placeHolderCount++;

		// Determine the placeholder and instance name
		std::string objectName;
		{
			std::stringstream ss;
			ss << "bifrost_particle_geo[o]_" << placeHolderID;
			objectName = ss.str();
		}
		std::string instName;
		{
			std::stringstream ss;
			ss << "bifrost_particle_geo[i]_" << placeHolderID;
			instName = ss.str();
		}
		std::string materialName;
		{
			std::stringstream ss;
			ss << "bifrost_particle_geo[m]_" << placeHolderID;
			materialName = ss.str();
		}

		// Create the placeholder object
		miTag tagObject = miNULLTAG;
		{
			miObjectCall object(objectName.c_str());

			// Set bounding box
			object->bbox_min.x = m_boundingBoxMin[0] - m_channels.radius;
			object->bbox_min.y = m_boundingBoxMin[1] - m_channels.radius;
			object->bbox_min.z = m_boundingBoxMin[2] - m_channels.radius;
			object->bbox_max.x = m_boundingBoxMax[0] + m_channels.radius;
			object->bbox_max.y = m_boundingBoxMax[1] + m_channels.radius;
			object->bbox_max.z = m_boundingBoxMax[2] + m_channels.radius;

			// Set flags
			object->visible			= miTRUE;
			object->shadow			=
			object->reflection		=
			object->refraction		=
			object->transparency	=
			object->caustic			=
			object->globillum		=
			object->finalgather		= 0x3;

			// Create the callback object
			mi_api_object_placeholder_callback_x(
				ParticleTilePlaceHolder::exec,
				NULL,
				ParticleTilePlaceHolder::del,
				static_cast<void*>(new ParticleTilePlaceHolder(m_tiles, m_channels))
			);
			object->geo.placeholder_list.type = miOBJECT_MAP;

			tagObject = object.end();
		}

		// The material used by instance
		miTag tagMaterial = miNULLTAG;
		{
			miObjectAccess<miInstance> stateInst(m_state->instance);

			// Use the current assigned material
			if (stateInst->mtl_array_size == 0)
			{
				tagMaterial = stateInst->material;
			}
			else if (stateInst->material)
			{
				miArrayAccess<miTag> materialList(stateInst->material);
				tagMaterial = materialList[0];
			}

			// If there is a volume material, we just use the volume material
			// to render the particles. Surface materials are dropped.
			if (tagMaterial)
			{
				miObjectAccess<miMaterial> instMaterial(tagMaterial);
				if (instMaterial->volume)
				{
					// Get a copy of the volume shader. The original volume shader will be
					// deallocated and cause a crash.
					miMaterialCall volumeMaterial(materialName.c_str());
					volumeMaterial->opaque = miFALSE;
					volumeMaterial->volume = mi_db_copy(instMaterial->volume);
					volumeMaterial->shadow = mi_db_copy(instMaterial->volume);
					tagMaterial = volumeMaterial.end();
				}
			}
		}

		// Create the instance
		miTag tagInst = miNULLTAG;
		{
			miInstanceCall instance(instName.c_str());

			{
				// Transfer flags from the parent instance
				miObjectAccess<miInstance> stateInst(m_state->instance);
				miTransferInstanceFlags(stateInst, instance);
			}

			instance->material = tagMaterial;

			tagInst = instance.end(objectName.c_str());
		}

		// Add to the result
		mi_geoshader_add_result(m_result, tagInst);

		// Reset the generator for the next placeholder
		reset();
	}

	void reset()
	{
		// Reset the generator for a new placeholder
		m_boundingBoxMin[0] = m_boundingBoxMin[1] = m_boundingBoxMin[2] =  std::numeric_limits<float>::max();
		m_boundingBoxMax[0] = m_boundingBoxMax[1] = m_boundingBoxMax[2] = -std::numeric_limits<float>::max();
		m_tiles.clear();
	}

private:
	miTag*		m_result;
	miState*	m_state;

	const ParticleChannels	m_channels;

	amino::Math::vec3f						m_boundingBoxMin;
	amino::Math::vec3f						m_boundingBoxMax;
	std::vector<Bifrost::API::TreeIndex>	m_tiles;

	size_t m_placeHolderCount;
};

// This class iterates the particle tiles and create placeholder objects.
struct ParticleTileIterator : Bifrost::API::Visitor
{
	const Bifrost::API::TileDataAccessor&	m_positionAccessor;
	const Bifrost::API::TileDataAccessor&	m_velocityAccessor;
	const float								m_voxelScale;
	const Bifrost::Math::Similarity&		m_similarity;
	const int								m_leafDepth;
	PlaceHolderGenerator&					m_generator;

	ParticleTileIterator(
		const Bifrost::API::TileDataAccessor&	positionAccessor,
		const Bifrost::API::TileDataAccessor&	velocityAccessor,
		const float								voxelScale,
		const Bifrost::Math::Similarity&		similarity,
		PlaceHolderGenerator&					generator)
		:	m_positionAccessor(positionAccessor),
			m_velocityAccessor(velocityAccessor),
			m_voxelScale(voxelScale),
			m_similarity(similarity),
			m_leafDepth(6),
			m_generator(generator)
	{}

	~ParticleTileIterator() {}

	void beginTile(const Bifrost::API::TileAccessor& accessor, const Bifrost::API::TreeIndex& index)
	{
		// World space bounding box of particles in this tile
		amino::Math::vec3f boundingBoxMin, boundingBoxMax;
		boundingBoxMin[0] = boundingBoxMin[1] = boundingBoxMin[2] =  std::numeric_limits<float>::max();
		boundingBoxMax[0] = boundingBoxMax[1] = boundingBoxMax[2] = -std::numeric_limits<float>::max();

		// Get position and velocity data in this tile
		Bifrost::API::TileData<amino::Math::vec3f> positionData =
			m_positionAccessor.tileData<amino::Math::vec3f>(index);

		Bifrost::API::TileData<amino::Math::vec3f> velocityData =
			m_velocityAccessor.tileData<amino::Math::vec3f>(index);

		assert(positionData.count() == velocityData.count());

		// Loop over particles in this tile and compute the bounding box
		for (size_t i = 0; i < positionData.count(); i++)
		{
			const amino::Math::vec3f&	position	= positionData[i];
			const amino::Math::vec3f&	velocity	= velocityData[i];

			// Convert to world space
			amino::Math::vec3f wsPosition = m_similarity.apply(m_voxelScale * position);

			// Expand the world space bounding box
			for (int i = 0; i < 3; i++)
			{
				boundingBoxMin[i] = std::min(boundingBoxMin[i], wsPosition[i]);
				boundingBoxMax[i] = std::max(boundingBoxMax[i], wsPosition[i]);
			}
		}

		// Add this tile to the placeholder generator
		m_generator.addTile(boundingBoxMin, boundingBoxMax, index);

		// Create a placeholder for the coarse tile. The placeholder just
		// contains particles in this tile.
		if (index.depth < m_leafDepth)
		{
			m_generator.createPlaceHolder();
		}
	}

	void endTile(const Bifrost::API::TileAccessor& accessor, const Bifrost::API::TreeIndex& index)
	{
		// Create a placeholder for the tile and descendant tiles if we reach
		// the depth requirement. We don't create placeholders for the finest
		// tiles because there are too many of them.
		if (index.depth == m_leafDepth)
		{
			m_generator.createPlaceHolder();
		}
	}
};

} // anonymous namespace

//==============================================================================
// bifrost_particle_geo
//==============================================================================

struct bifrost_particle_geo_params
{
	miTag		object;				// bifrost object name
	miTag		file;				// bifrost cache file. Will use it when a bifrost sim isnt in memory
	miScalar	frame;				// bifrost cache frame
	miScalar	size;				// particle size
	miColor		color;				// particle color
	miScalar	fps;				// frame per second
	miBoolean	motionBlurEnable;	// motion blur on/off
	miScalar	shutterOpen;		// shutter open time
	miScalar	shutterClose;		// shutter close time
};

extern "C" DLLEXPORT
miBoolean bifrost_particle_geo(miTag* result, miState* state, bifrost_particle_geo_params* paras)
{
	// Determine the location of Bifrost data
	std::string object	= miTag2String(*mi_eval_tag(&paras->object));
	std::string file	= miTag2String(*mi_eval_tag(&paras->file));

	// Check if we have hot data in the current state server
	BifrostObjectUserData objectRef(object, file);
	if (!objectRef.objectExists())
	{
		// The specified object doesn't exist in the current state server.
		// Try to load the object from the cache file.
		const float frame = *mi_eval_scalar(&paras->frame);
		const bool loaded = objectRef.loadFromFile(frame);

		if (!loaded || !objectRef.objectExists())
		{
			// Object not found
			mi_warning("Unable to resolve bifrost object: %s %s", file.c_str(), object.c_str());
			return miFALSE;
		}
	}

	// Get the particle channels
	ParticleChannels channels;
	{
		channels.radius				= *mi_call_scalar(&paras->size);	// Global
		channels.color				= *mi_call_color(&paras->color);	// Global
		channels.positionChannel	= objectRef.findPointChannel("position");
		channels.velocityChannel	= objectRef.findPointChannel("velocity");

		// The position and velocity channels are mandatory
		if (!channels.positionChannel || !channels.velocityChannel)
		{
			mi_warning("Unalbe to find position and velocity channel in %s", object.c_str());
			return miFALSE;
		}

		// Try to find other channels
		const Bifrost::API::Component component = channels.positionChannel.component();
		channels.extraChannels += component.findChannelsByType(Bifrost::API::FloatType);
		channels.extraChannels += component.findChannelsByType(Bifrost::API::FloatV2Type);
		channels.extraChannels += component.findChannelsByType(Bifrost::API::FloatV3Type);
		channels.extraChannels.remove(channels.positionChannel);
		channels.extraChannels.remove(channels.velocityChannel);

		// Grab motion blur settings
		channels.frame				= *mi_eval_scalar(&paras->frame);
		channels.fps				= *mi_eval_scalar(&paras->fps);
		channels.motionBlurEnable	= *mi_eval_boolean(&paras->motionBlurEnable);
		channels.shutterOpen		= *mi_eval_scalar(&paras->shutterOpen);
		channels.shutterClose		= *mi_eval_scalar(&paras->shutterClose);
	}

	// Declare a particle map container
	channels.declaration = ParticleEmitter::Declare(channels.extraChannels);

	// Iterate through particle tiles and generate placeholders
	{
		// Particle tile information
		Bifrost::API::Layout		layout		= channels.positionChannel.layout();
		Bifrost::API::Component		component	= channels.positionChannel.component();
		const float					voxelScale	= layout.voxelScale();
		Bifrost::Math::Similarity	similarity	= component.world();

		// Tile data accessors
		Bifrost::API::TileDataAccessor	positionAccessor	= channels.positionChannel.tileDataAccessor();
		Bifrost::API::TileDataAccessor	velocityAccessor	= channels.velocityChannel.tileDataAccessor();

		// Iterate tiles and generate
		PlaceHolderGenerator generator(result, state, channels);
		ParticleTileIterator iterator(
			positionAccessor, velocityAccessor,
			voxelScale, similarity, generator);
		layout.traverse(iterator, Bifrost::API::DepthFirst);
	}

	// Echo the output of this geometry shader for debugging
	miEchoGeoShaderResult(result);
	return miTRUE;
}

extern "C" DLLEXPORT
int bifrost_particle_geo_version(void)
{
	return 1;
}
