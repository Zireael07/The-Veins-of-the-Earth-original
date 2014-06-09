uniform vec2 texSize;
uniform sampler2D tex;
uniform sampler3D noisevol;
uniform vec4 color;
uniform float tick;

int blursize = 7;

void main(void)
{
	float fTime0_1 = tick / 5000.0;
	vec2 offset = 1.0/texSize;

	// Center Pixel
	vec4 sample = vec4(0.0,0.0,0.0,0.0);
	vec4 center = texture2D(tex, vec2(gl_TexCoord[0].st));
	float factor = ((float(blursize)*2.0)+1.0);
	factor = factor*factor;

	for(int i = -blursize; i <= blursize; i++)
	{
		for(int j = -blursize; j <= blursize; j++)
		{
			sample += texture2D(tex, vec2(gl_TexCoord[0].xy+vec2(float(i)*offset.x, float(j)*offset.y)));
		}
	}
	sample /= float((blursize*2.0) * (blursize*2.0));

	float a = 1.0-center.a;

	float delta = sample.a;
	// float delta = max(max(sample.r,sample.g),sample.b)/factor;
	float noise = texture3D(noisevol, vec3(gl_TexCoord[0].xy,fTime0_1)).r*2.0;
	gl_FragColor = mix(center,delta*color*noise,a);

	/*
	 float delta = sample.a;
	 // float delta = max(max(sample.r,sample.g),sample.b)/factor;
	 gl_FragColor = mix(center,delta*color,a);
	 */

	/*
	 gl_FragColor = mix(center,sample/factor,a);
	 */
}
