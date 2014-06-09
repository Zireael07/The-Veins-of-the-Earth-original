uniform sampler2D tex;
uniform float tick;
uniform float tick_start;
uniform float time_factor;
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

/*float GetFireDelta(float currTime, vec2 pos, float freqMult, float stretchMult, float scrollSpeed, float evolutionSpeed)
{
	//firewall
	float delta = 0;
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
}*/

float GetLavaDelta(float currTime, vec2 pos, float freqMult, float evolutionSpeed)
{
	float delta = 0.0;
	pos *= freqMult;
	
	delta += snoise(vec3(pos * 1.0, currTime * 1.0 * evolutionSpeed)) * 1.5;
	delta += snoise(vec3(pos * 2.0, currTime * 2.0 * evolutionSpeed)) * 1.5;
	delta += snoise(vec3(pos * 4.0, currTime * 4.0 * evolutionSpeed)) * 1.5;	
	delta += snoise(vec3(pos * 8.0, currTime * 8.0 * evolutionSpeed)) * 0.2;
	delta += snoise(vec3(pos * 16.0, currTime * 16.0 * evolutionSpeed)) * 0.1;

	return delta;
}

vec4 GetCheckboardColor(vec2 pos)
{
	vec4 col = vec4(0.0, 0.0, 0.0, 0.0);
	/*if(pos.x > 0.0 && pos.x < 1.0 && pos.y > 0.0 && pos.y < 1.0)
	{
		if(mod(pos.x, 0.1) < 0.05 ^ mod(pos.y, 0.1) < 0.05)
//			col = vec4(pos.x, pos.y, 0.0, 1.0);
			col = vec4(1.0, 1.0, 1.0, 1.0);
		else
			col = vec4(0.0, 0.0, 0.0, 1.0);
	}*/
	return col;
}

vec4 GetShockwaveColor(float currTime, vec2 pos, float radius1, float radius2)
{
	vec4 shockwaveColor = vec4(0.0, 0.0, 0.0, 0.0);
	
	float ratio = (length(pos) - radius1) / (radius2 - radius1);
	if(ratio > 0.0 && ratio < 1.0)
	{
		shockwaveColor = vec4(.7, .6, .5, pow(ratio, 5.0) * (1.0 - ratio) * 10.0);
	}
	return shockwaveColor;
}

vec4 GetExplosionColor(float currTime, vec2 pos, float radius1, float radius2, float density, float stage, float paletteCoord)
{
	vec4 fireballColor = vec4(0.0, 0.0, 0.0, 0.0);
	float pi = 3.141592;
	
	vec2 sphericalProjectedCoord = vec2(0.0, 0.0);
	float currRadius = radius2;
	float delta;
	float alpha = 0.0;
	float ratio = 0.0;
	
	int i = 0;
	for(i = 0; i < 10; i++)
	{
		float sinAlpha = length(pos) / currRadius;
		if(abs(sinAlpha) < 1.0)
		{
			alpha = asin(sinAlpha);
			
			sphericalProjectedCoord = vec2(0.5, 0.5) + pos * (alpha / (pi / 2.0)) / length(pos) * 0.1;
			//fireballColor = GetCheckboardColor(sphericalProjectedCoord);
			delta = GetLavaDelta(currTime, sphericalProjectedCoord, 9.0, 2.0);
			
			ratio = 1.0 / (1.0 + exp(delta * 3.0 + 0.5));
			//ratio = exp(-pow(delta, 1.0) * 10.0);
			float newRadius = radius2 + (radius1 - radius2) * ratio;
			if(abs(newRadius - currRadius) < 0.001)
			{
				break;
			}else
			{
				currRadius = currRadius + 0.2 * (newRadius - currRadius);
			}
		}else
		{
			return vec4(0.0, 0.0, 0.0, 0.0);
		}
	}
	float antialiasingMult = max(0.0, min(1.0, (1.0 - alpha / (pi / 2.0)) * 10.0));
	/*fireballColor = GetCheckboardColor(sphericalProjectedCoord);
	fireballColor.r = 1.0 / 30.0 * i;*/
	vec3 normalVector = vec3(pos.x, pos.y, 0);
	normalVector.z = -sqrt(radius2 * radius2 - dot(pos, pos));
	normalVector = normalize(normalVector);

	vec3 lightVector = normalize(vec3(-1, 1, 1));	
	float light = 0.2; //ambient
	light += max(0.0, -0.8 * dot(normalVector, lightVector));
	//light += max(0, reflect(lightVector, normalVector) * vec3(0, 0, 1));	

				
	float verticalPos = 0.01 + (1.0 - stage) * 0.7 + ratio;	
	verticalPos = min(0.99, verticalPos);
	verticalPos = max(0.01, verticalPos);
	
	fireballColor = texture2D(tex, vec2(0.75, verticalPos));
	fireballColor.rgb *= light;
	fireballColor.a = 1.0 - exp(-cos(alpha) * density);
	//fireballColor.a = min(1.0, fireballColor.a * antialiasingMult);
	return fireballColor;
}

void main(void)
{
	/*float delta = GetLavaDelta(tick / time_factor, gl_TexCoord[0].xy, 2.0, 1.0);
	float ratio = 1.0 - exp(-delta * delta * 20.0);
	gl_FragColor = vec4(1, 1, 1, ratio);
	return;*/
	vec2 radius = gl_TexCoord[0].xy - vec2(0.5, 0.5);

	radius.x *= (1.0 + ellipsoidalFactor) * 0.5 + (ellipsoidalFactor - 1.0) * 0.5 * pow(cos(tick / time_factor * oscillationSpeed), 2.0);
	
	//on-hit wobbling effect
	float radiusLen = length(radius);
		
	float explosionStage = (1.0 + sin(tick / time_factor * 20.0)) * 0.5;
	
	float ballRadius = 0.3 * ((tick - tick_start) / ((30.0 - 19.0) / 30.0 * 1000.0));
	float reliefDepth = 0.05;
	vec4 explosionColor = GetExplosionColor(tick / time_factor +  0.0 , radius, ballRadius - reliefDepth, ballRadius, 4.0, explosionStage, 0.75);
	 
	float shockwaveRadius = 0.25;
	float shockwaveWidth = mix(0.05, 0.25, min(1.0, ((tick - tick_start) / ((30.0 - 19.0) / 30.0 * 1000.0))));
	vec4 shockwaveColor = GetShockwaveColor(tick / time_factor, radius, shockwaveRadius, shockwaveRadius + shockwaveWidth);
	 
	gl_FragColor = shockwaveColor * shockwaveColor.a + explosionColor * (1.0 - shockwaveColor.a);
}
