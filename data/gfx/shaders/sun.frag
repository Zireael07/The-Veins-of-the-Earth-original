#extension GL_EXT_gpu_shader4: enable
uniform sampler2D tex;
vec3 Color1 = vec3(0.9, 0.8, 0.0);
vec3 Color2 = vec3(0.6, 0.4, 0.0);
uniform float tick;

int LFSR_Rand_Gen(in int n)
{
	// <<, ^ and & require GL_EXT_gpu_shader4.
	n = (n << 13) ^ n;
	return (n * (n*n*15731+789221) + 1376312589) & 0x7fffffff;
}

float LFSR_Rand_Gen_f( in int n )
{
	return float(LFSR_Rand_Gen(n));
}

float noise3f(in vec3 p)
{
	ivec3 ip = ivec3(floor(p));
	vec3 u = fract(p);
	u = u*u*(3.0-2.0*u);

	int n = ip.x + ip.y*57 + ip.z*113;

	float res = mix(mix(mix(LFSR_Rand_Gen_f(n+(0+57*0+113*0)),
		LFSR_Rand_Gen_f(n+(1+57*0+113*0)),u.x),
		mix(LFSR_Rand_Gen_f(n+(0+57*1+113*0)),
			LFSR_Rand_Gen_f(n+(1+57*1+113*0)),u.x),u.y),
		mix(mix(LFSR_Rand_Gen_f(n+(0+57*0+113*1)),
			LFSR_Rand_Gen_f(n+(1+57*0+113*1)),u.x),
			mix(LFSR_Rand_Gen_f(n+(0+57*1+113*1)),
				LFSR_Rand_Gen_f(n+(1+57*1+113*1)),u.x),u.y),u.z);

	return 1.0 - res*(1.0/1073741824.0);
}

void main()
{
	float intensity =
		abs(noise3f(vec3(gl_TexCoord[0].xy*100.0 + vec2(30.0,0.0), tick/3000.0)) - 0.25) +
		abs(noise3f(vec3(gl_TexCoord[0].xy*100.0 + vec2(40.0,0.0), tick/3000.0)) - 0.125) +
		abs(noise3f(vec3(gl_TexCoord[0].xy*100.0 + vec2(50.0,0.0), tick/3000.0)) - 0.0625);
//	vec3 color = mix(Color1, Color2, intensity);
	vec4 base = texture2D(tex, gl_TexCoord[0].xy);
	gl_FragColor = vec4(base.rgb * 0.7 + base.rgb * intensity * 0.3, 1.0);
}
