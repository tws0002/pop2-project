

// more for human eyes than a good machine-readable format
template<unsigned int M, unsigned int N, class T>
std::ostream &operator<<(std::ostream &out, const mat<M,N,T> &a)
{
	for(unsigned int i=0; i<M; ++i){
		out<<(i==0 ? '[' : ' ');
		for(unsigned int j=0; j<N-1; ++j)
			out<<a(i,j)<<',';
		out<<a(i,N-1);
		if(i<M-1) out<<';'<<std::endl;
		else out<<']';
	}
	return out;
}

template<unsigned int M, unsigned int N, class T>
inline mat<M,N,T> operator*(const T& scalar, const mat<M,N,T> &a)
{
	mat<M,N,T> b(a);
	b*=scalar;
	return b;
}

// outer product of two vectors...
template<unsigned int M, unsigned int N, class T>
inline mat<M,N,T> outer(const amino::Math::vec<M,T> &x, const amino::Math::vec<N,T> &y)
{
	mat<M,N,T> r;
	T *pr=r.a;
	for(unsigned int j=0; j<N; ++j)
		for(unsigned int i=0; i<M; ++i, ++pr)
			*pr=x[i]*y[j];
	return r;
}

template<unsigned int N, class T>
inline void make_identity(mat<N,N,T>& mat)
{
	std::memset(mat.a, 0, N*N*sizeof(T));
	for(unsigned int i=0; i<N; ++i)
		mat.a[(N+1)*i]=1;
}

template<unsigned int N, class T>
inline T trace(mat<N,N,T>& mat)
{
	T t=T(0);
	for(unsigned int i=0; i<N; ++i)
		t+=mat(i,i);
	return t;
}

template<class T>
inline mat<3,3,T> star_matrix(const amino::Math::vec<3,T> &w)
{
	return mat<3,3,T>(0, -w.v[2], w.v[1],
		w.v[2], 0, -w.v[0],
		-w.v[1], w.v[0], 0);
}



template<class T>
mat<4,4,T>
	inline make_rotation_xyz(const amino::Math::vec<3,T>& rotate_deg)
{
	static const T deg2rad(static_cast<T>(M_PI)/180);

	const T s0(sin(deg2rad*rotate_deg[0]));
	const T s1(sin(deg2rad*rotate_deg[1]));
	const T s2(sin(deg2rad*rotate_deg[2]));

	const T c0(cos(deg2rad*rotate_deg[0]));
	const T c1(cos(deg2rad*rotate_deg[1]));
	const T c2(cos(deg2rad*rotate_deg[2]));

	return mat<4,4,T>(
		c1*c2,           -c1*s2,             s1,    0,
		s0*s1*c2 + c0*s2, c0*c2 - s0*s1*s2, -s0*c1, 0,
		s0*s2 - c0*s1*c2, c0*s1*s2 + s0*c2,  c0*c1, 0,
		0,                0,                 0,     1);
}


template<class T>
mat<4,4,T>
	inline make_translation(const amino::Math::vec<3,T>& translate)
{
	return mat<4,4,T>(
		1, 0, 0, translate[0],
		0, 1, 0, translate[1],
		0, 0, 1, translate[2],
		0, 0, 0, 1);
}

template<class T>
mat<4,4,T>
	inline make_scale(const amino::Math::vec<3,T>& scale)
{
	return mat<4,4,T>(
		scale[0], 0,        0,        0,
		0,        scale[1], 0,        0,
		0,        0,        scale[2], 0,
		0,        0,        0,        1);
}


template<class T>
mat<4,4,T>
	inline make_transform(const amino::Math::vec<3,T>& translate,
	const amino::Math::vec<3,T>& rotate,
	const amino::Math::vec<3,T>& scale)
{
	return (make_translation(translate)*
		make_rotation_xyz(rotate)*
		make_scale(scale));
}
