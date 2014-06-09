// Most source from http://www.geeks3d.com/20100831/shader-library-noise-and-pseudo-random-number-generator-in-glsl/
// With some changes to make it affect an existing texture

#extension GL_EXT_gpu_shader4: enable

uniform sampler2D tex;
uniform vec3 color;
uniform float tick;
uniform float speed;
uniform vec2 p2;
uniform float a;
uniform float amp;

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

#define ty(x,y) (pow(.5+sin((x)*y*6.2831)/2.0,2.0)-.5)
#define t2(x,y) \
	ty(y + 2.0*ty(x+2.0*noise3f(vec3(cos((x)/3.0)+x,y+tick/speed,(x)*.1)),.3),.7)
#define tx(x,y,a,d) \
	((t2(x, y) * (a - x) * (d - y) + \
	t2(x - a, y) * x * (d - y) + t2(x, y - d) * (a - x) * y + \
	t2(x - a, y - d) * x * y) / (a * d))

float fx(vec2 x)
{
	float a=0.0,d=32.0;
	// Modified FBM functions to generate a blob texture
	for(;d>=1.0;d/=2.0)
		a += abs(tx(x.x*2.0*d, x.y*2.0*d, 2.0*d, 2.0*d)/(2.0*d));
	return a*2.0;
}

void main(void)
{
	vec2 uv = gl_TexCoord[0].xy * p2;
	float t = uv.x;
	uv.x = uv.y;
	uv.y = -t;
	uv -= floor(uv);
	gl_FragColor.a = texture2D(tex, gl_TexCoord[0].xy).a * a;
	gl_FragColor.rgb = color * ((1.0 - amp) + fx(uv) * amp);
}
