uniform sampler2D tex;
uniform float tick;
uniform vec2 mapCoord;
uniform vec2 texSize;
uniform vec4 displayColor;

float rand(vec2 co){
	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void)
{
	vec2 uv = gl_TexCoord[0].xy;
	vec2 r = vec2(rand(mapCoord / texSize));

	int blursize = 1;
	vec2 offset = 1.0/texSize;

	if (r.x < 0.5) blursize = 2;
	else blursize = 3;

	// Center Pixel
	vec4 sample = vec4(0.0,0.0,0.0,0.0);
	float factor = ((float(blursize)*2.0)+1.0);
	factor = factor*factor;

	for(int i = -blursize; i <= blursize; i++)
	{
		for(int j = -blursize; j <= blursize; j++)
		{
			sample += texture2D(tex, vec2(gl_TexCoord[0].xy+vec2(float(i)*offset.x, float(j)*offset.y)));
		}
	}
	sample /= (float(blursize)*2.0) * (float(blursize)*2.0);

	sample *= displayColor;

	sample.a *= 0.3 + (((1 + r.x * sin(tick / 500 + mapCoord.y)) / 2) * ((1 + r.y * cos(tick / 500 + mapCoord.x)) / 2)) * 0.7;
	gl_FragColor = sample;
}
