uniform sampler2D tex;
uniform float tick;
uniform float tick_start;
uniform float aadjust;
uniform vec4 bubbleColor;
uniform vec4 auraColor;
uniform float time_factor;

uniform vec3 impact_color;
uniform vec2 impact;
uniform float impact_tick;
uniform float impact_time;
uniform float llpow;

uniform float ellipsoidalFactor; //1 is perfect circle, >1 is ellipsoidal
uniform float oscillationSpeed; //oscillation between ellipsoidal and spherical form
uniform float antialiasingRadius; //1.0 is no antialiasing, 0.0 - fully smoothed(looks worse)
uniform float shieldIntensity; //physically affects shield layer thickness

uniform float wobblingPower;
uniform float wobblingSpeed;

uniform float auraWidth;

uniform float scrollingSpeed;

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

struct RingIntersection
{
	vec4 color;
	float depth;
};


vec4 Uberblend(vec4 col0, vec4 col1)
{
//	return vec4((1.0 - col0.a) * (col1.rgb) + col0.a * (col1.rgb * col1.a + col0.rgb * (1.0 - col1.a)), min(1.0, col0.a + col1.a));
//	return vec4((1.0 - col1.a) * (col0.rgb) + col1.a * (col1.rgb * col1.a + col0.rgb * (1.0 - col1.a)), min(1.0, col0.a + col1.a));
	return vec4(
		(1.0 - col0.a) * (1.0 - col1.a) * (col0.rgb * col0.a + col1.rgb * col1.a) / (col0.a + col1.a + 1e-1) +
		(1.0 - col0.a) * (0.0 + col1.a) * (col1.rgb) +
		(0.0 + col0.a) * (1.0 - col1.a) * (col0.rgb * (1.0 - col1.a) + col1.rgb * col1.a) +
		(0.0 + col0.a) * (0.0 + col1.a) * (col1.rgb),
		min(1.0, col0.a + col1.a));
}

vec4 GetFireRingColor(float currTime, vec2 pos, float freqMult, float stretchMult, float ampMult, float power, float radius1, float radius2, float scrollSpeed, float paletteCoord)
{
	float pi = 3.141592;
	float ang = atan(pos.y, pos.x) + pi;
	
	vec2 planarPos = vec2(ang / (2.0 * pi), 1.0 - (length(pos) - radius1) / (radius2 - radius1));
	planarPos.y = pow(abs(planarPos.y), power);
	
	float delta =  
		GetFireDelta(currTime, planarPos + vec2(currTime * scrollSpeed, 0.0), freqMult, stretchMult, 2.5, 0.5) * (1.0 - planarPos.x)	+ 
		GetFireDelta(currTime, vec2(planarPos.x + currTime * scrollSpeed - 1.0, planarPos.y), freqMult, stretchMult, 2.5, 0.5) * planarPos.x;
		
	delta *= min(1.0, max(0.0, 1.0 * (1.0 - planarPos.y)));
	delta *= min(1.0, max(0.0, 1.0 * (0.0 + planarPos.y)));

	float verticalPos = planarPos.y + delta * ampMult;	
	verticalPos = min(0.99, verticalPos);
	verticalPos = max(0.01, verticalPos);
	
	vec4 result;
	result.rgb = vec3(1.0, 1.0, 1.0);
	result.a = verticalPos;
	return result;
}

void main(void)
{
	vec2 radius = vec2(0.5, 0.5) - gl_TexCoord[0].xy;
	//radius.x *= ellispoidalFactor; //for simple ellipsoid
	//comment next line for regular spherical shield
	radius.x *= (1.0 + ellipsoidalFactor) * 0.5 + (ellipsoidalFactor - 1.0) * 0.5 * pow(cos(tick / time_factor * oscillationSpeed), 2.0);
	
	//on-hit wobbling effect
	float impactColorAffection = 0.0;
	float impactDuration = tick - impact_tick;
	if (impactDuration < impact_time * 5.0) //after impact_time * 5.0 the wobble will reduce exp(5.0) times
	{
		float impactCosine = dot(impact / length(impact), radius / length(radius));
		if(impactCosine > 0.0)
		{
			radius *= 1.0 + 
				(1.0 + sin(impactDuration * wobblingSpeed)) * 0.5 * 
				exp(-impactDuration / impact_time) * 
				wobblingPower * pow(impactCosine, 5.0);

			impactColorAffection = pow(impactCosine, 2.0);
			impactColorAffection *= exp(-(1.0 - length(radius) * 2.0) * 2.0);
			impactColorAffection *= exp(-impactDuration / impact_time);
		}
	}	
	
	float radiusLen = length(radius);
	
	float antialiasingCoef = 1.0;

	float shieldRadius = 0.5 - auraWidth;
	float innerRadius = 0.5 - auraWidth - 0.05;
	float outerRadius = 0.5;

	float sinAlpha = radiusLen / (shieldRadius);
	float alpha = 0.0;
	vec4 shieldColorSample = vec4(0.0, 0.0, 0.0, 0.0);
	if(sinAlpha < 1.0)
	{
		if(sinAlpha > antialiasingRadius)
		{
			antialiasingCoef = (1.0 - sinAlpha) / (1.0 - antialiasingRadius);
		}
		alpha = asin(sinAlpha);

		vec2 sphericalProjectedCoord = vec2(0.5, 0.5) + radius * (alpha / (3.141592 / 2.0)) / radiusLen;

		shieldColorSample = texture2D(tex, (sphericalProjectedCoord * 0.3 + vec2(scrollingSpeed * (tick - tick_start) / time_factor, 0.0)));
		shieldColorSample.a = 1.0 - exp(-shieldColorSample.a * shieldIntensity / cos(alpha));
		//impact adjusts resulting transperency
		shieldColorSample.a *= aadjust;
		shieldColorSample *= bubbleColor;
	}


	vec4 auraColorSample = vec4(0.0, 0.0, 0.0, 0.0);
	if(length(radius) > innerRadius && length(radius) < outerRadius)
	{
		auraColorSample = GetFireRingColor((tick - tick_start) / time_factor, radius, 5.0, 50.0, 1.0, 2.0, innerRadius, outerRadius, 0.1, 0.25) * auraColor;
	}

	float ratio = (radiusLen - innerRadius) / (shieldRadius - innerRadius);
	ratio = clamp(ratio, 0.0, 1.0);

	vec4 resultColor = shieldColorSample * (1.0 - ratio) + auraColorSample * ratio;
	//applying shield color
	resultColor.rgb *= vec3(1.0, 1.0, 1.0) * (1.0 - impactColorAffection) + impact_color * impactColorAffection;
	

	gl_FragColor = resultColor;
}
