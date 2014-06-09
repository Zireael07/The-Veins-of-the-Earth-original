uniform sampler2D tex;
uniform float tick;
uniform float aadjust;
uniform vec3 color;
uniform float time_factor;
uniform float tick_start;
uniform float deploy_factor;
uniform float flap;

uniform float ellipsoidalFactor; //1 is perfect circle, >1 is ellipsoidal
uniform float oscillationSpeed; //oscillation between ellipsoidal and spherical form

vec4 permute( vec4 x ) {
	return mod( ( ( x * 34.0 ) + 1.0 ) * x, 289.0 );
} 

vec4 taylorInvSqrt( vec4 r ) {

	return 1.79284291400159 - 0.85373472095314 * r;

}

float snoise( vec3 v ) {

	const vec2 C = vec2( 1.0 / 6.0, 1.0 / 3.0 );
	const vec4 D = vec4( 0.0, 0.5, 1.0, 2.0 );

	// First corner

	vec3 i  = floor( v + dot( v, C.yyy ) );
	vec3 x0 = v - i + dot( i, C.xxx );

	// Other corners

	vec3 g = step( x0.yzx, x0.xyz );
	vec3 l = 1.0 - g;
	vec3 i1 = min( g.xyz, l.zxy );
	vec3 i2 = max( g.xyz, l.zxy );

	vec3 x1 = x0 - i1 + 1.0 * C.xxx;
	vec3 x2 = x0 - i2 + 2.0 * C.xxx;
	vec3 x3 = x0 - 1. + 3.0 * C.xxx;

	// Permutations

	i = mod( i, 289.0 );
	vec4 p = permute( permute( permute(
		i.z + vec4( 0.0, i1.z, i2.z, 1.0 ) )
		+ i.y + vec4( 0.0, i1.y, i2.y, 1.0 ) )
		+ i.x + vec4( 0.0, i1.x, i2.x, 1.0 ) );

	// Gradients
	// ( N*N points uniformly over a square, mapped onto an octahedron.)

	float n_ = 1.0 / 7.0; // N=7

	vec3 ns = n_ * D.wyz - D.xzx;

	vec4 j = p - 49.0 * floor( p * ns.z *ns.z );  //  mod(p,N*N)

	vec4 x_ = floor( j * ns.z );
	vec4 y_ = floor( j - 7.0 * x_ );    // mod(j,N)

	vec4 x = x_ *ns.x + ns.yyyy;
	vec4 y = y_ *ns.x + ns.yyyy;
	vec4 h = 1.0 - abs( x ) - abs( y );

	vec4 b0 = vec4( x.xy, y.xy );
	vec4 b1 = vec4( x.zw, y.zw );


	vec4 s0 = floor( b0 ) * 2.0 + 1.0;
	vec4 s1 = floor( b1 ) * 2.0 + 1.0;
	vec4 sh = -step( h, vec4( 0.0 ) );

	vec4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
	vec4 a1 = b1.xzyw + s1.xzyw * sh.zzww;

	vec3 p0 = vec3( a0.xy, h.x );
	vec3 p1 = vec3( a0.zw, h.y );
	vec3 p2 = vec3( a1.xy, h.z );
	vec3 p3 = vec3( a1.zw, h.w );

	// Normalise gradients

	vec4 norm = taylorInvSqrt( vec4( dot( p0, p0 ), dot( p1, p1 ), dot( p2, p2 ), dot( p3, p3 ) ) );
	p0 *= norm.x;
	p1 *= norm.y;
	p2 *= norm.z;
	p3 *= norm.w;

	// Mix final noise value

	vec4 m = max( 0.6 - vec4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
	m = m * m;
	return 42.0 * dot( m*m, vec4( dot( p0, x0 ), dot( p1, x1 ),
		dot( p2, x2 ), dot( p3, x3 ) ) );

}  

vec2 snoise2(vec3 pos)
{
	return vec2(snoise(pos), snoise(pos + vec3(0.0, 0.0, 1.0)));
}

float GetFireDelta(float currTime, vec2 pos, float freqMult, float stretchMult, float scrollSpeed, float evolutionSpeed)
{
	//firewall
	float delta = 0.0;
//	pos.y += (1.0 - pos.y) * 0.5;
	//pos.y += 0.5;
	pos.y /= stretchMult;
	pos *= freqMult;
	pos.y += currTime * scrollSpeed;

//	pos.y -= currTime * 3.0;
	delta += snoise(vec3(pos * 1.0, currTime * 1.0 * evolutionSpeed)) * 1.5;
	delta += snoise(vec3(pos * 2.0, currTime * 2.0 * evolutionSpeed)) * 1.5;
	delta += snoise(vec3(pos * 4.0, currTime * 4.0 * evolutionSpeed)) * 1.5;	
	delta += snoise(vec3(pos * 8.0, currTime * 8.0 * evolutionSpeed)) * 1.5;
	delta += snoise(vec3(pos * 16.0, currTime * 16.0 * evolutionSpeed)) * 0.5;

	return delta;
}

vec4 GetFireColor(float currTime, vec2 pos, float freqMult, float stretchMult, float ampMult)
{
	vec4 fireColor = vec4(0.0, 0.0, 0.0, 0.0);
	if(pos.x > 0.0 && pos.x < 1.0 && pos.y > 0.0 && pos.y < 1.0)
	{
		/*if(mod(pos.x, 0.1) < 0.05 ^ mod(pos.y, 0.1) < 0.05)
			return vec4(pos.x, pos.y, 0, 1);
		else
			return vec4(0, 0, 0, 1);*/
		float delta = GetFireDelta(currTime, pos, freqMult, stretchMult, 3.0, 0.1);
		delta *= min(1.0, max(0.0, 1.0 * (1.0 - pos.y)));
		delta *= min(1.0, max(0.0, 1.0 * (0.0 + pos.y)));
		vec2 displacedPoint = pos + vec2(0, delta * ampMult);
		displacedPoint.y = min(0.99, displacedPoint.y);
		displacedPoint.y = max(0.01, displacedPoint.y);
		
		fireColor = texture2D(tex, displacedPoint);
	}
	return fireColor;
}

void main(void)
{
	vec2 pos = gl_TexCoord[0].xy;
	pos.x = 0.5 + (pos.x - 0.5) * ellipsoidalFactor;
	pos = vec2(0.5, 0.5) + (pos - vec2(0.5, 0.5)) * 1.1;
	
	float foldRatio = max(0.0, min(1.0, (tick - tick_start) / time_factor * deploy_factor));
	if (flap > 0.0) foldRatio = (1.0 + sin(tick / time_factor * flap)) * 0.5;
	foldRatio *= 0.95 + 0.05 * sin(tick / time_factor * 15.0);
	
	float radius = 0.25 * (foldRatio * 0.5 + 0.5);
	vec2 center = vec2(0.5, 0.85 - radius);
	float timeShift = 0.0;
	if(pos.x > 0.5)
		timeShift = 100.0;
		
	
	if(length(pos - center) < radius)
	{
		vec2 delta = pos - center;
		float pi = 3.141592;
		float ang = atan(delta.x, delta.y);

		vec2 polarPoint = vec2(abs(ang) / pi, radius - length(delta));
		vec2 planarPoint = vec2((polarPoint.x - 0.07) / (0.70 - (1.0 - foldRatio) * 0.3), polarPoint.y * 24.0);
		planarPoint.x -= (0.0 + planarPoint.x) * planarPoint.y * 0.2;
		planarPoint.y += pow((0.0 + planarPoint.x), 10.0) * planarPoint.y * 10.0;

		planarPoint.y = 1.0 - planarPoint.y;
		gl_FragColor = GetFireColor(timeShift + tick / time_factor, planarPoint, 4.0, 8.0, 1.0);	
	}else
	{
		
		vec2 delta = pos - center;
		float pi = 3.141592;
		float ang = atan(delta.x, delta.y);

		vec2 polarPoint = vec2(abs(ang) / pi, length(delta) - radius);
		
		vec2 planarPoint = vec2((polarPoint.x - 0.07) / (0.70 - (1.0 - foldRatio) * 0.3), polarPoint.y * 2.5);
	/*	planarPoint.x -= (1.0 - planarPoint.x) * planarPoint.y * 0.7;
		planarPoint.x -= (0.0 + planarPoint.x) * planarPoint.y * 0.2;
		planarPoint.y += pow((0.0 + planarPoint.x) * planarPoint.y, 3.0) * 7.9;*/
		planarPoint.x -= (1.0 - planarPoint.x) * planarPoint.y * 0.8;
		planarPoint.x -= (0.0 + planarPoint.x) * planarPoint.y * 0.3 * (foldRatio * 3.0 - 2.0);
		planarPoint.y += pow((1.0 - planarPoint.x), 7.0) * planarPoint.y * 2.7;
		
		planarPoint.y = 1.0 - planarPoint.y;
			
		gl_FragColor = GetFireColor(timeShift + tick / time_factor, planarPoint, 2.0, 4.0, 1.0);	

		float antialiasingCoef = 40.0;
		gl_FragColor.a *= min(1.0, max(0.0, planarPoint.x * antialiasingCoef));
		//gl_FragColor.a *= min(1.0, max(0.0, planarPoint.y * antialiasingCoef));
		gl_FragColor.a *= min(1.0, max(0.0, (1.0 - planarPoint.x) * antialiasingCoef));
		//gl_FragColor.a *= min(1.0, max(0.0, (1.0 - planarPoint.y) * antialiasingCoef));
	}
	gl_FragColor.a *= (1.0 - pow(1.0 - foldRatio, 3.0)) * gl_Color.a;
}
