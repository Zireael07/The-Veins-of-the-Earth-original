uniform sampler2D tex;
uniform float tick;
uniform float tick_start;
uniform vec3 color;
uniform float time_factor;

uniform float shockwaveSpeed;
uniform float shockwaveWidth;
uniform float flameIntensity;

uniform float noup;

uniform vec2 ellipsoidalFactor; //(1.0, 1.0) is perfect circle, (2.0, 1.0) is vertical ellipse, (1.0, 2.0) is horizontal ellipse

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
	
RingIntersection GetBladeRingColor(float currTime, vec2 pos, vec3 axis)
{
	RingIntersection result;
	
	vec3 rayOrigin = vec3(pos, -5.0);
	vec3 rayDir = vec3(0.0, 0.0, 1.0);
	
	vec3 planePoint = vec3(0.0, 0.0, 0.0);
	
	result.depth = 10.0;
	result.color = vec4(0.0, 0.0, 0.0, 0.0);
		

	
	float someDelta = GetFireDelta(currTime, vec2(0.5, 0.5), 1.0, 1.0, 0.0, 0.23);
	if(!(someDelta < 10 && someDelta > -10))
	{
		result.depth = -10;
		result.color = vec4(1, 0, 0, 1);
		return result;
	}

	vec3 baseIntersection = rayOrigin + rayDir * dot(planePoint - rayOrigin, axis) / dot(axis, rayDir);

	for(int i = 0; i < 10; i++)
	{
		vec3 localAxis = axis;
		localAxis.x += sin(someDelta * 1.5 + 100.0 * i) * 0.15;
		localAxis.y += sin(someDelta * 1.7 + 130.0 * i) * 0.15;
	/*	localAxis.x += GetFireDelta(currTime, vec2(0.2 * i, 0.5), 1.0, 1.0, 0.0, 0.23) * 0.1;
		localAxis.y += GetFireDelta(currTime, vec2(0.2 * i, 0.5), 1.0, 1.0, 0.0, 0.27) * 0.1;*/
		localAxis /= length(localAxis);

		vec3 intersection = rayOrigin + rayDir * dot(planePoint - rayOrigin, localAxis) / dot(localAxis, rayDir);

		vec3 tangent0 = cross(axis, vec3(0.0, 1.0, 0.0));
		if(length(tangent0) < 1e-1)
		{
			tangent0 = cross(axis, vec3(1.0, 0.0, 0.0));
		}else
		{
		}
		tangent0 /= length(tangent0);

		vec3 tangent1 = cross(tangent0, axis);

		vec2 planarPoint = vec2(dot(intersection - planePoint, tangent0), dot(intersection - planePoint, tangent1));	
		
		vec2 rotatedPoint;
		/*rotatedPoint.x = planarPoint.x * cos(ang) - planarPoint.y * sin(ang);
		rotatedPoint.y = planarPoint.x * sin(ang) + planarPoint.y * cos(ang);
		rotatedPoint *= 2.0;
		if(length(rotatedPoint) < 0.5 && rotatedPoint.x < 0.0)
		{
			result.color = texture2D(tex, rotatedPoint + vec2(0.5, 0.5));
			result.depth = intersection.z;
		}*/

		float fogPhase = currTime * 5.0 + sin(someDelta * 1.5 + 9.0 * i) * 0.5;// + GetFireDelta(currTime, vec2(0.1 * i, 0.5), 1.0, 1.0, 0.0, 0.2) * 0.5;
		fogPhase = clamp(fogPhase - floor(fogPhase), 0.0, 1.0);
		
		float ang = -currTime * 30.0 + (3.14 * 2.0) / 10.0 * i + sin(someDelta * 1.5 + 5.0 * i) * 0.5;// + GetFireDelta(currTime, vec2(0.1 * i, 0.5), 1.0, 1.0, 0.0, 0.2) * 0.5;
		rotatedPoint.x = planarPoint.x * cos(ang) - planarPoint.y * sin(ang);
		rotatedPoint.y = planarPoint.x * sin(ang) + planarPoint.y * cos(ang);
		//rotatedPoint *= 2.0 - fogPhase;
		if(length(rotatedPoint) < 0.5 && rotatedPoint.x < 0.0)
		{
			vec4 airColor = /*vec4(sin(10 * i), sin(20 * i), sin(30 * i), 1.0);*/texture2D(tex, rotatedPoint + vec2(0.5, 0.5));
			airColor.a *= (1.0 - pow(fogPhase, 3.0)) * (1.0 - pow((1.0 - fogPhase), 3.0));
			result.color = Uberblend(result.color, airColor);
			result.depth = intersection.z;
			if(intersection.z < result.depth)
			{
				result.depth = intersection.z;
			}
			//result.color.rgb = vec3(0.5, 0.5, 0.5);//max(result.color.rgb, airColor.rgb);
			//result.color.a = 1.0;//min(1.0, result.color.a + airColor.a);
		}
	}
	
	return result;
}



void main(void)
{
//	gl_FragColor = Uberblend(texture2D(tex, gl_TexCoord[0].xy), texture2D(tex, vec2(gl_TexCoord[0].x - 0.5, gl_TexCoord[0].y))); return;
//	gl_FragColor = texture2D(tex, - gl_TexCoord[0].xy); return;
	vec2 radius = gl_TexCoord[0].xy - vec2(0.5, 0.5);

	radius *= ellipsoidalFactor;
	
	float radiusLen = length(radius);

	vec3 axis = vec3(0.4, -0.5, -0.5);
	axis /= length(axis);
	RingIntersection int0 = GetBladeRingColor(tick / time_factor * 0.9 + 10.0, radius, axis);

	axis = vec3(-0.6, -0.3, -0.2);
	axis /= length(axis);
	RingIntersection int1 = GetBladeRingColor(tick / time_factor, radius, axis);

	if((int0.depth < 0.0 && noup == 2.0) || (int0.depth > 0.0 && noup == 1.0))
	{
		int0.color *= 0.0;
	}
	if((int1.depth < 0.0 && noup == 2.0) || (int1.depth > 0.0 && noup == 1.0))
	{
		int1.color *= 0.0;
	}
	int0.color.rgb *= max(0.0, min(1.0, (0.5 - int0.depth) * 2.0 - 0.5)) * 1.0;
	int1.color.rgb *= max(0.0, min(1.0, (0.5 - int1.depth) * 2.0 - 0.5)) * 1.0;
	
	vec4 resultColor;
	if(int0.depth < int1.depth)
	{
		resultColor = Uberblend(int1.color, int0.color);
	}
	else
	{
		resultColor = Uberblend(int0.color, int1.color);
//		resultColor.rgb = (1.0 - int0.color.a) * (int1.color.rgb) + int0.color.a * (int1.color.rgb * int1.color.a + int0.color.rgb * (1.0 - int1.color.a));
		//resultColor.a = int0.color.a + int1.color.a;
	}
	
	resultColor.a = min(1.0, resultColor.a);
	resultColor.a *= gl_Color.a;
	
		
	gl_FragColor = resultColor;
}