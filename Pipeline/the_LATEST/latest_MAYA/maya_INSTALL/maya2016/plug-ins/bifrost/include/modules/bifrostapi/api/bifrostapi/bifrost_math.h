//*****************************************************************************
/*!
   \file bifrost_types.h
   \brief Types declaration used in the Bifrost API classes.

	Copyright 2014 Autodesk, Inc. All rights reserved.

	Use of this software is subject to the terms of the Autodesk
	license agreement provided at the time of installation or download,
	or which otherwise accompanies this software in either electronic
	or hard copy form.
*/
//*****************************************************************************

#ifndef _BIFROST_MATH_H_
#define _BIFROST_MATH_H_

#include <aminomath/vec.h>
#include <aminomath/mat.h>

namespace Bifrost {

/*! \namespace Math
	\brief The %Math namespace defines a region where all math classes and types are declared in %Bifrost.
*/
namespace Math {

	//*************************************************************************
	/*! \class Similarity bifrost_math.h
		\brief %Similarity class represents a similarity transformation matrix. 
	*/
	//*************************************************************************
	class Similarity
	{
		public:
		amino::Math::mat44f sim;
		amino::Math::mat44f inv;

		/*! Default constructor. */
		Similarity()
			: sim(1.f),inv(1.f)
		{}

		/*! Default destructor. */
		~Similarity()
		{
		}

		/*! Multiply a vec3f with this matrix.
		\param vec vec3f operand.
		\return Resulting vec3f. 
		*/
		amino::Math::vec3f apply(const amino::Math::vec3f& vec) const
		{
			return amino::Math::vec3f(
					sim.a[0]*vec.v[0]+sim.a[4]*vec.v[1]+sim.a[8]*vec.v[2]+sim.a[12],
					sim.a[1]*vec.v[0]+sim.a[5]*vec.v[1]+sim.a[9]*vec.v[2]+sim.a[13],
					sim.a[2]*vec.v[0]+sim.a[6]*vec.v[1]+sim.a[10]*vec.v[2]+sim.a[14]);
		}

		/*! Invert a vec3f and multiply with this matrix.
		\param vec vec3f operand.
		\return Resulting vec3f. 
		*/
		amino::Math::vec3f inverseApply(const amino::Math::vec3f& vec) const
		{
			return amino::Math::vec3f(
					inv.a[0]*vec.v[0]+inv.a[4]*vec.v[1]+inv.a[8]*vec.v[2]+inv.a[12],
					inv.a[1]*vec.v[0]+inv.a[5]*vec.v[1]+inv.a[9]*vec.v[2]+inv.a[13],
					inv.a[2]*vec.v[0]+inv.a[6]*vec.v[1]+inv.a[10]*vec.v[2]+inv.a[14]);
		}

		/*! Linear multiplication of a vec3f with this matrix.
		\param vec vec3f operand.
		\return Resulting vec3f. 
		*/
		amino::Math::vec3f applyLinear(const amino::Math::vec3f& vec) const
		{
			return amino::Math::vec3f(
					sim.a[0]*vec.v[0]+sim.a[4]*vec.v[1]+sim.a[8]*vec.v[2],
					sim.a[1]*vec.v[0]+sim.a[5]*vec.v[1]+sim.a[9]*vec.v[2],
					sim.a[2]*vec.v[0]+sim.a[6]*vec.v[1]+sim.a[10]*vec.v[2]);
		}

		/*! Invert a vec3f and performs a linear multiplication with this matrix.
		\param vec vec3f operand.
		\return Resulting vec3f. 
		*/
		amino::Math::vec3f inverseApplyLinear(const amino::Math::vec3f& vec) const
		{
			return amino::Math::vec3f(
					inv.a[0]*vec.v[0]+inv.a[4]*vec.v[1]+inv.a[8]*vec.v[2],
					inv.a[1]*vec.v[0]+inv.a[5]*vec.v[1]+inv.a[9]*vec.v[2],
					inv.a[2]*vec.v[0]+inv.a[6]*vec.v[1]+inv.a[10]*vec.v[2]);
		}

		/*! Performs scaling on this matrix.
		\return Resulting float value. 
		*/
		float scale() const
		{
			return std::sqrt(amino::Math::sqr(sim.a[0])+amino::Math::sqr(sim.a[1])+amino::Math::sqr(sim.a[2]));
		}

		/*! Equality operator.
		\param other Similarity object to compare.
		\return true if both matrix are equal, false otherwise. 
		*/
		bool operator==(const Similarity& other) const 
		{
			for (int i=0; i<4; ++i) {
				for (int j=0; j<4; ++j) {
					if (sim(i,j) != other.sim(i,j) || inv(i,j) != other.inv(i,j)) {
						return false;
					}
				}
			}
			return true;
		}
	};

} // Math
} // Bifrost
#endif // _BIFROST_MATH_H_