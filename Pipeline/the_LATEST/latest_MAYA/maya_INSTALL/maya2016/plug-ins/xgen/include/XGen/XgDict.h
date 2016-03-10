// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgDict.h
 * @brief Contains XgDict, and efficient string keyed hash table.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Brent Burley
 * @author Joe Longson
 *
 * @version Created 01/28/09  (from corelibs)
 */

#ifndef XgDict_h
#define XgDict_h

#include <cstdlib>
#include <string.h>

/**
 * @class XgDict 
 * @brief An efficient string dictionary template, using a hash table.
 *
 * An efficient string dictionary template.  A hash table is used
 * that automatically doubles in size when it is more than 50%
 * full.  It is hard-coded to use string keys for efficiency.
 */
template<class T>
class XgDict
{
    class Entry; ///< forward declared private class

public: // Public Types used in XgDict

    typedef const char*    key_type;       ///< This is the lookup type
    typedef T              mapped_type;    ///< The data type stored

    /**
     * @struct DGDict::value_type
     * @brief Internal class used to provide a return value for the value type
     *
     * All data members and member functions are declared public by design
     * Default Copy and Assignment operators are sufficient..
     */
    struct value_type {
    public:
        /// Default constructor references default_value, with a 0 for first
        value_type(): first(0), second() {}
        /// Creation constructor
        value_type(key_type f, const T& s): first(f), second(s) {}

        const key_type first;  ///< Reference to the key type
        T second;              ///< Reference to the data 
    };

    // forward declarations
    class const_iterator;

    /**
     * @class XgDict::iterator
     * @brief Internal class used to provide iteration through the dictionary
     *
     * This works on non-const types providing type safe modification access
     */
    class iterator {
    public:
        /// Default Constructor
        iterator() : _d(0), _e(0), _b(0) {}

        /// Proper copy constructor implementation
        iterator(const iterator& iter) :
            _d(iter._d), _e(iter._e), _b(iter._b) {}
        /// Proper assignment operator
        inline iterator& operator=(const iterator& iter)
            { _e = iter._e; _d = iter._d; _b = iter._b; return *this; }   

        /// Operator for obtaining the value that the iterator references
        inline value_type& operator*() const { return getValue(); }
        /// Pointer reference operator
        inline value_type* operator->() const { return &getValue(); }

        /// For determining whether or not an iterator is valid
        inline operator bool() const { return _e != 0; }

        /// For comparing equality of iterators
        inline bool operator==(const iterator& iter) const
            { return iter._e == _e; }
        /// For comparing inequality of iterators
        inline bool operator!=(const iterator& iter) const
            { return iter._e != _e; }
        /// For comparing equality of iterators
        inline bool operator==(const const_iterator& iter) const
            { return iter._e == _e; }
        /// For comparing inequality of iterators
        inline bool operator!=(const const_iterator& iter) const
            { return iter._e != _e; }
        /// For advancing the iterator to the next element
        iterator& operator++();
        iterator operator++(int);

    private:  // Private interface

        /// Constructor Helper for inline creation.
        iterator( Entry** e, const XgDict* d, int b): _d(d), _e(e), _b(b) {}

        /// simple helper function for retrieving the value from the Entry
        inline value_type& getValue() const{
            if (_e) return (*_e)->_val;
            else   return _defaultVal;
        }
        
        friend class XgDict<T>;
        friend class const_iterator; 
        const XgDict<T>* _d; ///< dictionary back reference
        Entry** _e;          ///< pointer to entry in table this iterator refs
        int _b;              ///< bucket number this references

        static value_type _defaultVal; ///< Default value
    };


    /**
     * @class XgDict::const_iterator
     * @brief Internal class used to provide iteration through the dictionary
     *
     * This works on const data types, and provides const safe access.
     * This class can also be created from a XgDict::iterator class instance.
     */
    class const_iterator {
    public:
        /// Default Constructor
        const_iterator() : _d(0), _e(0), _b(0) {}

        /// Proper copy constructor implementation for const_iterator
        const_iterator(const const_iterator& iter) :
            _d(iter._d), _e(iter._e), _b(iter._b) {}
        /// Conversion constructor for iterator
        const_iterator(const iterator& iter) :
            _d(iter._d), _e(iter._e), _b(iter._b) {}
        /// Proper assignment operator for const_iterator
        inline const_iterator& operator=(const const_iterator& iter)
            { _e = iter._e; _d = iter._d; _b = iter._b; return *this; }
        /// Proper assignment operator for iterator
        inline const_iterator& operator=(iterator& iter)
            { _e = iter._e; _d = iter._d; _b = iter._b; return *this; }

        /// Operator for obtaining the value that the const_iterator references
        inline const value_type& operator*() const { return getValue(); }
        /// Pointer reference operator
        inline const value_type* operator->() const { return &getValue(); }

        /// For determining whether or not an iterator is valid
        inline operator bool() const { return _e != 0; }

        /// For comparing equality of iterators
        inline bool operator==(const iterator& iter) const
            { return iter._e == _e; }
        /// For comparing inequality of iterators
        inline bool operator!=(const iterator& iter) const
            { return iter._e != _e; }
        /// For comparing equality of const_iterators
        inline bool operator==(const const_iterator& iter) const
            { return iter._e == _e; }
        /// For comparing inequality of iterators
        inline bool operator!=(const const_iterator& iter) const
            { return iter._e != _e; }
        /// For advancing the iterator to the next element
        const_iterator& operator++();
        const_iterator operator++(int);

    private:  // Private interface

        /// Constructor Helper for inline creation.
        const_iterator( Entry** e, const XgDict* d, int b):
            _d(d),_e(e),_b(b) {}

        /// simple helper function for retrieving the value from the Entry
        inline const value_type& getValue() const{
            if (_e) return (*_e)->_val;
            else   return _defaultVal;
        }

        friend class XgDict<T>;
        friend class iterator;
        const XgDict<T>* _d;  ///< dictionary back reference
        Entry** _e;      ///< pointer to entry in table this iterator refs
        int _b;          ///< bucket number this references

        static value_type _defaultVal; ///< Default value
    };

public:  // Public Member Interfce

    /// Default contructor initializes the dictionary to be empty
    XgDict() :  _numEntries(0), _numBuckets(0), _bucketMask(0), _buckets(0) {}
    
    /// Copy constructor copies the contents of the dictionary
    XgDict(const XgDict<T>& dict):  
        _numEntries(0), _numBuckets(0), _bucketMask(0), _buckets(0)
    {
        // allocate enough space for the number of buckets being copied
        if (dict._numBuckets)  grow( dict._numBuckets );
        else                   grow(); // use our default size
        
        const_iterator iter = dict.begin();
        for(; iter != dict.end(); ++iter)
            (*this)[ iter->first ] = iter->second;
    }    /// clears the entries in the dictionary
    
    /// Non-Virtual destructor by design, clears the entries in the hash table
    ~XgDict() { clear(); }

    /// Assignment operator for copying the dictionary
    XgDict<T>& operator=(const XgDict<T>& dict )
    {
        // protect against self assignment
        if (dict._buckets == this->_buckets ) return *this;

        // clear any previously initialized entries
        clear();

        // allocate enough space for the number of buckets being copied
        if (dict._numBuckets)  grow( dict._numBuckets );
        else                   grow(); // use our default size

        const_iterator iter = dict.begin();
        for(; iter != dict.end(); ++iter)
            (*this)[ iter->first ] = iter->second;

        return *this;
    }
    
    /// Locates an entry, creating a new one if necessary.
    /** operator[] will look up an entry and return the value.  A new entry
     *  will be created (using the default ctor for T) if one doesn't exist.
     */
    T& operator[](key_type key);

	/// Locates an entry, creating a new one if necessary.
    /** operator[] will look up an entry and return the value.  A new entry
     *  will be created (using the default ctor for T) if one doesn't exist.
     */
    T* operator[](key_type key) const;

    /// Returns an iterator referencing the beginning of the table
    iterator begin()
    {
        iterator iter;
        iter._d = this;
        for (iter._b = 0; iter._b < _numBuckets; ++iter._b) {
            iter._e = &_buckets[iter._b];
            if (*iter._e) return iter;
        }
        iter._e = 0;
        return iter;
    }
        
    /// Const access to the beginning of the list
    const_iterator begin() const
    {
        const_iterator iter;
        iter._d = this;
        for (iter._b = 0; iter._b < _numBuckets; ++iter._b) {
            iter._e = &_buckets[iter._b];
            if (*iter._e) return iter;
        }
        iter._e = 0;
        return iter;
    }

    /// Const access to the beginning of the list
    const_iterator cbegin() const { return begin(); }
    
    /// Returns an iterator referencing the end of the table.
    inline iterator end() { return iterator( 0, this, 0 ); }
    
    /// Const access to the end of the list
    inline const_iterator end() const { return const_iterator( 0, this, 0 ); }
    
    /// Const access to the end of the list
    inline const_iterator cend() const { return const_iterator( 0, this, 0 ); }

    /// Locates an entry, without creating a new one.
    /**
     * find will locate an entry, but won't create a new one.  The result is
     * returned as a pair of key and value.  The returned key points to the
     * internal key string and will remain valid until the entry is deleted. 
     * If the key is not found, the returned iterator will be equal to the
     * value returned by end(), and the iterator will be equal to false. O(1)
     */
    iterator find(key_type key);
    /// works the same as find above, but returns a constant iterator.
    const_iterator find(key_type key) const;

    /// Will remove an entry.  It will return TRUE if an entry was found.
    bool erase(key_type key);
    /// Removes the entry referenced by the iterator, from the dictionary.
    /** It will return a iterator to the next element, or will equal the
     *  return value of end() if there is nothing else to erase.  O(1)
     */
    iterator erase(iterator iter);

    /// clear will remove all entries from the dictionary. O(n)
    void clear();

    /// Returns the number of entries in the dictionary. O(1) time to call.
    int size() const { return _numEntries; }

    /// Returns true if the dictionary is empty O(1) time to call
    bool empty() const { return (_numEntries == 0); }
    
private: // Private Member Interface
       
    /// @brief This internal structure is used to store the dictionary elements
    class Entry {
    public: // Public Member Interface
        /// Default constructor initiaizes val with the defaul value
        Entry() : _next(0), _hashval(0), _keylen(0),
                  _val(_key,T()) {}
        ~Entry() {}
    private: // Private Member Interface
        /// Copy constructor prohibited by design.
        Entry(const Entry&);
        /// Assignment operator prohibited by design.
        Entry& operator=(const Entry&);

    public:
        Entry*     _next;    ///< Pointer to the next element in the chain
        int        _hashval; ///< cached hashval of key
        int        _keylen;  ///< cached length of key
        value_type _val;     ///< The stored value of the hash table
#if defined(__x86_64__) || defined(_M_AMD64) 
        char _key[1];
#else
        union {
            int  _pad;   ///< for integer align of _key, for fast compares
            char _key[1];///< 1 is dummy length - actual size will be allocated
        };
#endif
    };

    /// Returns the integer hash index for the key and length of the key.
    int hash(const char* key, int& keylen) const
    {
        // this is similar to perl's hash function
        int hashval = 0;
        const char* cp = key;
        char c;
        while ( (c = *cp++) )
            hashval = hashval * 33 + (int)c;
        keylen = (int)(cp-key-1);
        return hashval;
    }

    /// Returns a pointer to the desired entry, based on the key. 
    Entry** locate(const char* key, int& keylen, int& hashval) const
    {
        hashval = hash(key, keylen);
        if (!_buckets) return 0;
        for (Entry** e = &_buckets[hashval & _bucketMask]; *e; e=&(*e)->_next)
            if ((*e)->_hashval == hashval && (*e)->_keylen == keylen &&
                streq(key, (*e)->_key, keylen)) 
                return e;
        return 0;
    }
    
    /// Used for string compares, much faster then strcmp
    /** This is MUCH faster than strcmp and even memcmp, partly because
     *  it is inline and partly because it can do 4 chars at a time
     */
    static inline bool streq(const char* s1, const char* s2, int len)
    {
        
#if !defined(__x86_64__) && !defined(_M_AMD64) 
        /*
          is this 64-bit safe?
          I'm assuming no.
          Please adjust accordingly if I'm wrong --daa
        */
        
        // first make sure s1 is quad-aligned (s2 is always aligned)
        if (((int)s1 & 3) == 0) {  
            int len4 = len >> 2;
            while (len4--) {
                if (*s1 != *s2) return 0;
                s1 += 4;
                s2 += 4;
            }
            len &= 3;
        }
#endif /* end non-x86_64 area */
        
        while (len--) if (*s1++ != *s2++) return 0;
        return 1;
    }
    
    /// Used to increase the size of the table if necessary
    /** You can give this routine a new default bucket size if needed,
     *  though this is typically only useful when copying.
     */
    void grow(int newDefaultBucketSize=16);

private:  // Private Member data

    int _numEntries;  ///< The number of entries in the dictionary
    int _numBuckets;  ///< The number of buckets in use
    int _bucketMask;  ///< The mask for the buckets
    Entry** _buckets; ///< The pointer to the bucket structure
};



// define the static type for the iterator
template<class T> typename XgDict<T>::value_type XgDict<T>::iterator::_defaultVal;

// define the static type for the iterator
template<class T> typename XgDict<T>::value_type XgDict<T>::const_iterator::_defaultVal;

template<class T>
inline typename XgDict<T>::iterator& XgDict<T>::iterator::operator++()
{
    if (_e) {
        // move to next entry
        _e = &(*_e)->_next;
        if (!*_e) {
            // move to next non-empty bucket
            for (++_b; _b < _d->_numBuckets; ++_b) {
                _e = &_d->_buckets[_b];
                if (*_e) return *this;
            }
            _e = 0;
        }
    }
    return *this;
}

template<class T>
inline typename XgDict<T>::const_iterator& XgDict<T>::const_iterator::operator++()
{
    if (_e) {
        // move to next entry
        _e = &(*_e)->_next;
        if (!*_e) {
            // move to next non-empty bucket
            for (++_b; _b < _d->_numBuckets; ++_b) {
                _e = &_d->_buckets[_b];
                if (*_e) return *this;
            }
            _e = 0;
        }
    }
    return *this;
}

// NOTE: Prefer to implement post-increment in terms of pre-increment.
template<class T>
inline typename XgDict<T>::iterator XgDict<T>::iterator::operator++(int)
{
    iterator old( *this );
    ++*this;
    return old;
}

template<class T>
inline typename XgDict<T>::const_iterator XgDict<T>::const_iterator::operator++(int)
{
    const_iterator old( *this );
    ++*this;
    return old;
}

template<class T>
typename XgDict<T>::iterator XgDict<T>::find(typename XgDict::key_type key)
{
    int keylen, hashval;
    Entry** e = locate(key, keylen, hashval);

    // return a valid iterator if we found an entry, else return end()
    if (e) return iterator( e, this, hashval & _bucketMask );
    else   return end(); 
}

template<class T>
typename XgDict<T>::const_iterator XgDict<T>::find(typename XgDict::key_type key) const
{
    int keylen, hashval;
    Entry** e = locate(key, keylen, hashval);

    // return a valid iterator if we found an entry, else return end()
    if (e) return const_iterator( e, this, hashval & _bucketMask );
    else   return end(); 
}

template<class T>
T& XgDict<T>::operator[](typename XgDict::key_type key)
{
    int keylen, hashval;
    Entry** e = locate(key, keylen, hashval);
    if (e) return (*e)->_val.second;

    // create a new entry
    ++_numEntries;
    if (_numEntries*2 >= _numBuckets) grow();

    // allocate a buffer big enough to hold Entry + (the key length )
    // Note: the NULL character is already accounted for by Entry::_key's size
    void* ebuf = malloc( sizeof(Entry) + (size_t)(keylen) * sizeof(char) ); 
    Entry* ne = new(ebuf) Entry; // note: placement new 

    // Store the values in the Entry structure
    Entry** slot = &_buckets[hashval & _bucketMask];
    ne->_next = *slot; *slot = ne;
    ne->_hashval = hashval;
    ne->_keylen = keylen;

    // copy the string given into the new location
    strcpy(ne->_key, key); 
    return ne->_val.second;
}

template<class T>
T* XgDict<T>::operator[](typename XgDict::key_type key) const
{
	int keylen, hashval;
	Entry** e = locate(key, keylen, hashval);
	if (e) return &(*e)->_val.second;
	return NULL;
}


template<class T>
void XgDict<T>::grow(int newDefaultBucketSize)
{
    if (!_buckets) {
        _numBuckets = newDefaultBucketSize;
        _bucketMask = _numBuckets - 1;
        _buckets = (Entry**) calloc((size_t)_numBuckets, sizeof(Entry*));
    } else {
        int newsize = _numBuckets * 2;
        _bucketMask = newsize - 1;
        Entry** newbuckets = (Entry**) calloc((size_t)newsize, sizeof(Entry*));
        for (int i = 0; i < _numBuckets; ++i) {
            for (Entry* e = _buckets[i]; e;) {
                Entry* _next = e->_next;
                Entry** slot = &newbuckets[e->_hashval & _bucketMask];
                e->_next = *slot; *slot = e;
                e = _next;
            }
        }
        free(_buckets);
        _buckets = newbuckets;
        _numBuckets = newsize;
    }
}


template<class T>
bool XgDict<T>::erase(typename XgDict::key_type key)
{
    iterator iter = find(key);
    if (!iter) return false;

    erase(iter);
    return true;  // valid entry to remove
}


template<class T>
typename XgDict<T>::iterator XgDict<T>::erase(iterator iter)
{
    Entry** eptr = iter._e;
    if (!eptr) return iter;

    // patch around deleted entry
    Entry* e = *eptr;
    Entry* next = e->_next;
    if (!next) ++iter;  // advance iterator if at end of chain
    *eptr = next;

    // destroy entry.  This is a strange destroy but is necessary because of
    // the way Entry() is allocated by using malloc above.
    e->~Entry(); // note: explicit dtor call
    free(e);     // free memory allocated.
    _numEntries--;

    return iter;
}


template<class T>
void XgDict<T>::clear()
{
    for (iterator i=begin(); i != end(); i = erase(i));
    free(_buckets);
    _buckets = 0;
    _numEntries = 0;
    _numBuckets = 0;
}

#endif
