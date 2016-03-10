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

#ifndef _BIFROST_TYPES_H_
#define _BIFROST_TYPES_H_

#include <bifrostapi/bifrost_decl.h>
#include <stdint.h>
#include <stddef.h>

#ifdef Success
#undef Success
#endif

namespace Bifrost {
namespace API {

	/*! StateID is the identifier of a state server object in the current process. */
	typedef uint32_t StateID;
	/*! PointID is the type for point identifiers. */
	typedef uint64_t PointID;

	/*! Channel data types.*/
	enum DataType {
		NoneType=0,		/*!< Undefined data type. Uninitialized %Channel object are set to %NoneType. */
		FloatType,		/*!< Defines a channel of type float. */
		FloatV2Type,	/*!< Defines a channel of type amino::Math::vec2f. */
		FloatV3Type,	/*!< Defines a channel of type amino::Math::vec3f. */
		Int32Type,		/*!< Defines a channel of type int32_t. */
		Int64Type,		/*!< Defines a channel of type int64_t. */
		UInt32Type,		/*!< Defines a channel of type uint32_t. */
		UInt64Type,		/*!< Defines a channel of type uint64_t. */
		Int32V2Type,	/*!< Defines a channel of type amino::Math::vec2i. */
		Int32V3Type		/*!< Defines a channel of type amino::Math::vec3i. */
	};

	/*! Location within a voxel tile where samples are stored.*/
	enum VoxelOffsetType {
		Center=0,	/*!< Sample at (.5, .5, .5) */
		XFace=1,    /*!< Sample at ( 0, .5, .5) */
		YFace=2,    /*!< Sample at (.5,  0, .5) */
		ZFace=4,    /*!< Sample at (.5, .5,  0) */
		XEdge=6,    /*!< Sample at (.5,  0,  0) */
		YEdge=5,    /*!< Sample at ( 0, .5,  0) */
		ZEdge=3,    /*!< Sample at ( 0,  0, .5) */
		Corner=7	/*!< Sample at ( 0,  0,  0) */
	};

	/*! Tile tree traversal mode.*/
	enum TraversalMode
	{
		/*! Breadth-first traversal in serial (top-down ie coarse to fine level traversal) */
		BreadthFirst,
		/*! Breadth-first bottom-up traversal in serial (bottom-up ie fine to coarse level traversal) */
		BreadthFirstBottomUp,
		/*! Depth-first traversal in serial */
		DepthFirst,
		/*! Breadth-first traversal in parallel (top-down ie coarse to fine level traversal) */
        ParallelBreadthFirst,
		/*! Breadth-first traversal in parallel (bottom-up ie fine to coarse level traversal) */
        ParallelBreadthFirstBottomUp,
		/*! Depth-first traversal in parallel. Ensures that tiles are visited in depth-first order globally and allows
		information to be propagated properly up the tree. */
        ParallelDepthFirst,
		/*! Like ParallelDepthFirst, but also performs a reduction. */
        ParallelReduceDepthFirst,
		/*! Breadth-first reduction in parallel (top-down ie coarse to fine level traversal) */
        ParallelReduceBreadthFirst,
		/*! Breadth-first reduction in parallel (bottom-up ie fine to coarse level traversal) */
        ParallelReduceBreadthFirstBottomUp
	};

	/*! Space coordinate types for Samplers.*/
	enum SamplerSpace
	{
		TileSpace=1,	/*!< Tile space. */
		WorldSpace		/*!< World space. */
	};

	//*************************************************************************
	/*! \struct TileCoord bifrost_types.h
		\brief %TileCoord class. A 3 tuple coordinate used for indexing a tile in a tree.
	*/
	//*************************************************************************
	struct TileCoord {
		/*! tile 1st dimension component */
		int i;
		/*! tile 2nd dimension component */
		int j;
		/*! tile 3rd dimension component */
		int k;

		/*! Constructor */
		TileCoord() : i(0),j(0),k(0) {}
		/*! Constructor */
		TileCoord(int vi, int vj, int vk) : i(vi),j(vj),k(vk) {}

		/*! Returns true if coor equals this TileCoord.
		\param coord %TileCoord to compare.
		\return True if objects are equal.
		*/
		bool operator == ( const TileCoord& coord ) const
		{
			return this->i == coord.i && this->j == coord.j && this->j == coord.j;
		}

		/*! Returns true if coord doesn't equal this TileCoord.
		\param coord %TileCoord to compare.
		\return True if objects are not equal.
		*/
		bool operator != ( const TileCoord& coord ) const
		{
			return !(*this == coord);
		}

		/*! Multiplication assignment operator.
		\param n Multiplication value.
		\return Modified coordinate.
		*/
		TileCoord& operator *= ( int n )  
		{
			this->i *= n;
			this->j *= n;
			this->k *= n;
			return *this;
		}

		/*! Division assignment operator.
		\param n Division value.
		\return Modified coordinate.
		*/
		TileCoord& operator /= ( int n )  
		{
			if (n) {
				this->i /= n;
				this->j /= n;
				this->k /= n;
			}
			return *this;
		}

		/*! Addition assignment operator.
		\param other %TileCoord to add.
		\return Modified coordinate.
		*/
		TileCoord& operator += ( const TileCoord& other )  
		{
			this->i += other.i;
			this->j += other.j;
			this->k += other.k;
			return *this;
		}

		/*! Substraction assignment operator.
		\param other %TileCoord to substract.
		\return Modified coordinate.
		*/
		TileCoord& operator -= ( const TileCoord& other )  
		{
			this->i -= other.i;
			this->j -= other.j;
			this->k -= other.k;
			return *this;
		}

		/*! Addition operator.
		\param other %TileCoord to add.
		\return New coordinate.
		*/
		const TileCoord operator + ( const TileCoord& other ) const 
		{
			return TileCoord(*this) += other;
		}

		/*! Substraction operator.
		\param other %TileCoord to substract.
		\return New coordinate.
		*/
		const TileCoord operator - ( const TileCoord& other ) const 
		{
			return TileCoord(*this) -= other;
		}
	};

	//*************************************************************************
	/*! \class TreeIndex bifrost_types.h
		\brief %TreeIndex struct. Used for indexing a %Bifrost tile tree to
		get at a specific tile. A tile can be indexed with a location tree index (tile index)
		along with a depth position in the tree.
	*/
	//*************************************************************************
	struct TreeIndex {
		/*! Tile index type */
		typedef int Tile;
		/*! Depth index type */
		typedef int Depth;

		/*! Maximum depth level. */
		const static Depth maxDepth = -1;

		/*! tile index */
		Tile tile;
		/*! tree depth index */
		Depth depth;

		/*! Constructor */
		TreeIndex() : tile(0), depth(0) {}
		/*! Constructor */
		TreeIndex(Tile t, Depth d) : tile(t),depth(d) {}
		/*! Copy constructor */
		TreeIndex(const TreeIndex& tindex) : tile(tindex.tile),depth(tindex.depth) {}

		/* Returns true if this TreeIndex is valid */
		bool valid() const
		{
			return this->tile >= 0 && this->depth >= 0;
		}

		/* Returns true if index equals this TreeIndex.
		\param index %TreeIndex to compare.
		\return True if indices are equal.
		*/
		bool operator == ( const TreeIndex& index ) const
		{
			return this->tile == index.tile && this->depth == index.depth;
		}

		/* Returns true if index doesn't equal this TreeIndex.
		\param index %TreeIndex to compare.
		\return True if indices are not equal.
		*/
		bool operator != ( const TreeIndex& index ) const
		{
			return !(*this == index);
		}

	};

	//*************************************************************************
	/*! \class TileDimInfo bifrost_types.h
		\brief %TileDimInfo struct. Contains the meta data used for identifying the
		dimension values of a tile. In the current Bifrost architecture there are
		always 5x5x5 values in the tile (that's tileSize), the width of the tile (tileWidth)
		is the 5.

		However, a tile can correspond to a larger region of tile space. At the finest level a
		tile covers 5x5x5, but at depth 6 it covers (25*25*25) and so on. The 25 is the depthWidth.
		This means that each voxel in a tile at depth 6 covers 5 units in the tile space. So the 5
		is the voxelWidth.
	*/
	//*************************************************************************
	struct TileDimInfo {

		/*! The size of a tile. The size represents the number of children in a tile.
		<br><b>Note:</b> Avoid using this value to iterate over children, use TileIterator instead.*/
		int tileSize;

		/*! The width of a tile. This is typically used for accessing tiles with tile coordinates i,j,k. */
		int tileWidth;

		/*! The width of a tile in tilespace at a specific depth. */
		int depthWidth;

		/*! The width of a voxel in tilespace at a specific depth. */
		int voxelWidth;
	};

	//*************************************************************************
	/*! \class TileInfo bifrost_types.h
		\brief %TileInfo struct. Contains the meta data used for identifying a tile. This information
		is transient as tiles may move in a tree as a result of an operation performed on the tree itself
		Therefore, it is strongly suggested to not persist or cache this information.
	*/
	//*************************************************************************
	struct TileInfo {
		/*! Tile identifier */
		typedef uint64_t ID;

		/*! tile 1st dimension component */
		int i;
		/*! tile 2nd dimension component */
		int j;
		/*! tile 3rd dimension component */
		int k;

		/*! tile index in a tree. */
		TreeIndex::Tile tile;

		/*! depth index in a tree. */
		TreeIndex::Depth depth;

		/*! parent tile index. */
		TreeIndex::Tile parent;

		/*! tile unique identifier in a tree. The id can change if the Tile is moved. */
		ID id;

		/*! returns true if this tile has valid children. */
		bool hasChildren;

		/*! returns true if the tile is valid */
		bool valid;

		/*! Tile dimension values */
		TileDimInfo dimInfo;

		/* Returns true if info equals this TileInfo.
		\param info %TileInfo to compare.
		\return True if objects are equal.
		*/
		bool operator == ( const TileInfo& info ) const
		{
			return	this->i == info.i &&
					this->j == info.j &&
					this->k == info.k &&
					this->tile == info.tile &&
					this->depth == info.depth &&
					this->parent == info.parent &&
					this->id == info.id &&
					this->hasChildren == info.hasChildren &&
					this->valid == info.valid &&
					this->dimInfo.tileSize == info.dimInfo.tileSize &&
					this->dimInfo.tileWidth == info.dimInfo.tileWidth &&
					this->dimInfo.depthWidth == info.dimInfo.depthWidth &&
					this->dimInfo.voxelWidth == info.dimInfo.voxelWidth;
		}

		/* Returns true if info doesn't equal this TileInfo.
		\param info %TileInfo to compare.
		\return True if objects are not equal.
		*/
		bool operator != ( const TileInfo& info ) const
		{
			return !(*this == info);
		}

	};
} // API
} // Bifrost

#endif // _BIFROST_TYPES_H_
