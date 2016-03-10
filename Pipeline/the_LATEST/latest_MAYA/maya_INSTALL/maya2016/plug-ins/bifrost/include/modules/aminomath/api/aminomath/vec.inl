

template<unsigned int N, typename S, typename T> inline vec<N,T>
operator*(S a, const vec<N,T>& w)
{
	vec<N,T> v(w);
	v*=a;
	return v;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline T
	mag2(const vec<N,T>& a)
{
	T l=sqr(a.v[0]);
	for(unsigned int i=1; i<N; ++i) l+=sqr(a.v[i]);
	return l;
}

template<typename T> inline T
	mag2(const T& a)
{
	return a*a;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline T
	mag(const vec<N,T>& a)
{ return (T)sqrtf((T)mag2(a)); }


template<typename T> inline T
	mag(const T& a)
{ return (T)sqrtf((T)mag2(a)); }

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline T
	dist2(const vec<N,T>& a, const vec<N,T>& b)
{
	T d=sqr(a.v[0]-b.v[0]);
	for(unsigned int i=1; i<N; ++i) d+=sqr(a.v[i]-b.v[i]);
	return d;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline T
	dist(const vec<N,T>& a, const vec<N,T>& b)
{ return std::sqrt(dist2(a,b)); }

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline void
	normalize(vec<N,T>& a)
{ a/=mag(a); }

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline vec<N,T>
normalized(const vec<N,T>& a)
{ return a/mag(a); }

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline void
	set_zero(vec<N,T>& a)
{
	for(unsigned int i=0; i<N; ++i)
		a.v[i] = 0;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline std::ostream&
	operator<<(std::ostream& out, const vec<N,T>& v)
{
	out<<v.v[0];
	for(unsigned int i=1; i<N; ++i)
		out<<' '<<v.v[i];
	return out;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline std::istream&
	operator>>(std::istream& in, vec<N,T>& v)
{
	in>>v.v[0];
	for(unsigned int i=1; i<N; ++i)
		in>>v.v[i];
	return in;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline bool
	operator==(const vec<N,T>& a, const vec<N,T>& b)
{
	bool t = (a.v[0] == b.v[0]);
	unsigned int i=1;
	while(i<N && t) {
		t = t && (a.v[i]==b.v[i]);
		++i;
	}
	return t;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline bool
	operator!=(const vec<N,T>& a, const vec<N,T>& b)
{
	bool t = (a.v[0] != b.v[0]);
	unsigned int i=1;
	while(i<N && !t) {
		t = t || (a.v[i]!=b.v[i]);
		++i;
	}
	return t;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline vec<N,T>
operator*(T a, const vec<N,T>& v)
{
	vec<N,T> w(v);
	w*=a;
	return w;
}

// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline T
	dot(const vec<N,T>& a, const vec<N,T>& b)
{
	T d=a.v[0]*b.v[0];
	for(unsigned int i=1; i<N; ++i) d+=a.v[i]*b.v[i];
	return d;
}

// -----------------------------------------------------------------------------

template<typename T> inline vec<2,T>
rotate(const vec<2,T>& a, float angle_in_radians)
{
	T c = cos(angle_in_radians);
	T s = sin(angle_in_radians);
	// counter-clockwise rotation
	return vec<2,T>(c*a[0] - s*a[1],s*a[0] + c*a[1]);
}

// -----------------------------------------------------------------------------

// counter-clockwise rotation by 90 degrees
template<typename T> inline vec<2,T>
perp(const vec<2,T>& a)
{ return vec<2,T>(-a.v[1], a.v[0]); }

// -----------------------------------------------------------------------------

template<typename T> inline T
	cross(const vec<2,T>& a, const vec<2,T>& b)
{ return a.v[0]*b.v[1]-a.v[1]*b.v[0]; }

// -----------------------------------------------------------------------------

template<typename T> inline vec<3,T>
cross(const vec<3,T>& a, const vec<3,T>& b)
{
	return vec<3,T>(a.v[1]*b.v[2]-a.v[2]*b.v[1],
		a.v[2]*b.v[0]-a.v[0]*b.v[2],
		a.v[0]*b.v[1]-a.v[1]*b.v[0]);
}

// -----------------------------------------------------------------------------

template<typename T> inline T
	triple(const vec<3,T>& a, const vec<3,T>& b, const vec<3,T>& c)
{
	return a.v[0]*(b.v[1]*c.v[2]-b.v[2]*c.v[1])
		+a.v[1]*(b.v[2]*c.v[0]-b.v[0]*c.v[2])
		+a.v[2]*(b.v[0]*c.v[1]-b.v[1]*c.v[0]);
}

// -----------------------------------------------------------------------------

template<typename T> inline void
	assign(const vec<2,T>& a, T& a0, T& a1)
{
	a0=a.v[0]; a1=a.v[1];
}

// -----------------------------------------------------------------------------

template<typename T> inline void
	assign(const vec<3,T>& a, T& a0, T& a1, T& a2)
{
	a0=a.v[0]; a1=a.v[1]; a2=a.v[2];
}

// -----------------------------------------------------------------------------

template<typename T> inline void
	assign(const vec<4,T>& a, T& a0, T& a1, T& a2, T& a3)
{
	a0=a.v[0]; a1=a.v[1]; a2=a.v[2]; a3=a.v[3];
}

// -----------------------------------------------------------------------------

template<typename T> inline void
	assign(const vec<6,T>& a, T& a0, T& a1, T& a2, T& a3, T& a4, T& a5)
{
	a0=a.v[0]; a1=a.v[1]; a2=a.v[2]; a3=a.v[3]; a4=a.v[4]; a5=a.v[5];
}


// -----------------------------------------------------------------------------

template<unsigned int N, typename T> inline unsigned int 
	hash(const vec<N,T>& a)
{
	unsigned int h=a.v[0];
	for(unsigned int i=1; i<N; ++i)
		h=(h ^ a.v[i]) * 2654435769u;
	return h;
}

// -----------------------------------------------------------------------------