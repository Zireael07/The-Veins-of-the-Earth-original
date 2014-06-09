uniform sampler2D tex;
uniform float tick;
uniform float tick_start;
uniform float aadjust;
uniform vec3 color;
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

uniform float horizontalScrollingSpeed;
uniform float verticalScrollingSpeed;

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
	
	float sinAlpha = radiusLen * 2.0;
	float alpha = 0.0;
	if(sinAlpha > 1.0)
	{
		gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
		return;
	}else
	{
		if(sinAlpha > antialiasingRadius)
		{
			antialiasingCoef = (1.0 - sinAlpha) / (1.0 - antialiasingRadius);
		}
		alpha = asin(sinAlpha);
	}
	vec2 sphericalProjectedCoord = vec2(0.5, 0.5) + radius * (alpha / (3.141592 / 2.0)) / radiusLen;
	
	//two scrolling textures
	vec4 c1 = texture2D(tex, (sphericalProjectedCoord + vec2(horizontalScrollingSpeed * (tick - tick_start) / time_factor, 0.0)));
	vec4 c2 = texture2D(tex, (sphericalProjectedCoord + vec2(0.0, verticalScrollingSpeed * (tick - tick_start) / time_factor)));
	vec4 c = c1 * c2;

	//exponential thin layer absorbtion under angle alpha
	//layer thickness is c.a * shieldIntensity
	c.a = 1.0 - exp(-c.a * shieldIntensity / cos(alpha));

	//impact adjusts resulting transperency
	c.a *= aadjust;
	
	//applying shield color
	c.rgb *= color * (1.0 - impactColorAffection) + impact_color * impactColorAffection;
	
	//c.rgb += impact_color * impactColorAffection;

	//thin layer of gradient transperency to make antialiasing
	c.a *= min(1.0, c.a) * antialiasingCoef;

	gl_FragColor = c;
}
