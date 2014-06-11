uniform float motionblur;
uniform float tick;
uniform sampler2D noisevol;
uniform vec2 texSize;
uniform sampler2D tex;
uniform vec2 mapCoord;

void main(void)
{
	gl_FragColor = texture2D(tex, gl_TexCoord[0].xy);

	int blursize = int(motionblur);
	vec2 offset = 0.8/texSize;

	float fTime0_X = tick / 20000.0;
	float coord = gl_TexCoord[0].x + gl_TexCoord[0].y * texSize[0];
	float noisy1 = texture2D(noisevol,vec2(coord,fTime0_X)).r;
	float noisy2 = texture2D(noisevol,vec2(coord/5.0,fTime0_X/1.5)).r;
	float noisy3 = texture2D(noisevol,vec2(coord/7.0,fTime0_X/2.0)).r;
	float noisy = (noisy1+noisy2+noisy3)/3.0;

	// Center Pixel
	vec4 sample = vec4(0.0,0.0,0.0,0.0);
	float factor = ((float(blursize)*2.0)+1.0);
	factor = factor*factor;

	if (noisy < 0.25)
	{
		for(int i = -blursize; i <= 0; i++)
		{
			for(int j = -blursize; j <= 0; j++)
			{
				sample += texture2D(tex, vec2(gl_TexCoord[0].xy+vec2(float(i)*offset.x, float(j)*offset.y)));
			}
		}
	}
	else if (noisy < 0.50)
	{
		for(int i = 0; i <= blursize; i++)
		{
			for(int j = 0; j <= blursize; j++)
			{
				sample += texture2D(tex, vec2(gl_TexCoord[0].xy+vec2(float(i)*offset.x, float(j)*offset.y)));
			}
		}
	}
	else if (noisy < 0.75)
	{
		for(int i = 0; i <= blursize; i++)
		{
			for(int j = -blursize; j <= 0; j++)
			{
				sample += texture2D(tex, vec2(gl_TexCoord[0].xy+vec2(float(i)*offset.x, float(j)*offset.y)));
			}
		}
	}
	else
	{
		for(int i = -blursize; i <= 0; i++)
		{
			for(int j = 0; j <= blursize; j++)
			{
				sample += texture2D(tex, vec2(gl_TexCoord[0].xy+vec2(float(i)*offset.x, float(j)*offset.y)));
			}
		}
	}
	sample /= float((motionblur*1.5) * (motionblur*0.5));
	gl_FragColor = sample;
}
