uniform float blur;
uniform float tick;
uniform vec2 texSize;
uniform sampler2D tex;

void main(void)
{
	int blursize = int(blur);
	vec2 offset = 1.0/texSize;

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
	sample /= (blur*2.0) * (blur*2.0);
	gl_FragColor = sample;
}
