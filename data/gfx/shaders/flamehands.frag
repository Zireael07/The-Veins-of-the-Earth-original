uniform sampler2D tex;
uniform float tick;
uniform float time_factor;

	
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
	float delta = GetFireDelta(currTime, pos, freqMult, stretchMult, 3.0, 0.5);
	delta *= min(1.0, max(0.0, 1.0 * (1.0 - pos.y)));
	delta *= min(1.0, max(0.0, 1.0 * (0.0 + pos.y)));
	vec2 displacedPoint = pos + vec2(0, delta * ampMult);
	displacedPoint.y = min(0.99, displacedPoint.y);
	displacedPoint.y = max(0.01, displacedPoint.y);
	
	return texture2D(tex, displacedPoint);
}

vec4 GetCheckboardColor(vec2 pos)
{
	vec4 col = vec4(0.0, 0.0, 0.0, 0.0);
	if(pos.x > 0.0 && pos.x < 1.0 && pos.y > 0.0 && pos.y < 1.0)
	{
		if(mod(pos.x, 0.1) < 0.05 ^^ mod(pos.y, 0.1) < 0.05)
			col = vec4(pos.x, pos.y, 0.0, 1.0);
		else
			col = vec4(0.0, 0.0, 0.0, 1.0);
	}
	return col;
}

vec4 GetFireCandleColor(float currTime, vec2 pos, float freqMult, float stretchMult, float ampMult, float power, float radius, float flameHeight, float paletteCoord)
{
	float pi = 3.141593;
		
	vec4 fireballColor = vec4(0.0, 0.0, 0.0, 0.0);
	if(length(pos) < radius)
	{		
		float ang = atan(pos.x, pos.y);
		
		float sinAlpha = length(pos) / radius;
		float alpha = 0.0;
		alpha = asin(sinAlpha);
		
		vec2 sphericalProjectedCoord = vec2(0.5, 0.5) + pos * (alpha / (3.141592 / 2.0)) / length(pos);
		//fireballColor = GetCheckboardColor(sphericalProjectedCoord);
		float delta = GetFireDelta(currTime, sphericalProjectedCoord, freqMult * 0.3, 1.0, 0.0, 1.5) * (1.0 - pow(length(pos) / radius, 3.0)) * 0.5;
		
		float verticalPos = 0.99 - delta * delta;	
		verticalPos = min(0.99, verticalPos);
		verticalPos = max(0.01, verticalPos);
		
		fireballColor = texture2D(tex, vec2(0.75, verticalPos));
		fireballColor.a = 1.0;
	}else
	{
		float bottomPos = 0.0;
		
		pos.x += cos(pos.y * 20.0 + currTime * 20.0) * 0.05 * (1.0 - pow(1.0 - max(0.0, min((-radius - pos.y) * 2.0, 1.0)), 2.0));
		if(abs(pos.x) < radius)
		{
			bottomPos = -sqrt(radius * radius - pos.x * pos.x);
//			float ratio = (pos.y - bottomPos) / (bottomPos * (flameHeight / radius) - bottomPos);
			float ratio = (pos.y - bottomPos) / (bottomPos - flameHeight - radius - bottomPos) * (1.0 + 0.5 * pow(abs(pos.x) / radius, 4.0));
			
			vec2 planarPos = vec2(pos.x / radius, 1.0 - ratio);
			planarPos.x *= 1.0 + (1.0 - planarPos.y) * 2.5;
			planarPos.x = planarPos.x / 2.0 + 0.5;

			if(planarPos.x > 0.0 && planarPos.x < 1.0 && planarPos.y > 0.0 && planarPos.y < 1.0)
			{
				float delta = GetFireDelta(currTime, planarPos, freqMult * 0.2, 0.6, 1.0, 0.2);
				delta *= min(1.0, max(0.0, 1.0 * (1.0 - planarPos.y)));
				delta *= min(1.0, max(0.0, 1.0 * (0.0 + planarPos.y)));	
				
				float verticalPos = pow(planarPos.y, 0.7) + delta * 1.0;	
				verticalPos = min(0.99, verticalPos);
				verticalPos = max(0.01, verticalPos);
				
				//fireballColor = GetCheckboardColor(planarPos);
				fireballColor = texture2D(tex, vec2(0.25, verticalPos));
			}
		}
	}
	return fireballColor;
}

void main(void)
{
	vec2 radius = gl_TexCoord[0].xy - vec2(0.5, 0.8);
	
	//on-hit wobbling effect
	float radiusLen = length(radius);
		
	
	float ballRadius = 0.1;
	float flameHeight = 0.6;
	
	vec4 c;
	c = GetFireCandleColor(tick / time_factor +  0.0 , radius, 2.0, 3.0, 1.0, 2.0, ballRadius, flameHeight, 0.75);
	c.a *= gl_Color.a;
	//c.a += 0.5;
	
	gl_FragColor = c;
}
