uniform sampler2D tex;
uniform float tick;
uniform vec4 color1;
uniform vec4 color2;
uniform vec4 color3;
uniform vec4 color4;

const float PI = 3.14159265;

void main()
{
	float fTime0_X = tick / 1000.0;
	float count = fTime0_X/2.0;
	vec4 col1;
	vec4 col2;
	if(mod(count,4.0)<2.0)
	{
		if(mod(count,2.0)<1.0)
		{
			col1 = color1;
			col2 = color2;
		}
		else
		{
			col1 = color2;
			col2 = color3;
		}
	}
	else
	{
		if(mod(count,2.0)<1.0)
		{
			col1 = color3;
			col2 = color4;
		}
		else
		{
			col1 = color4;
			col2 = color1;
		}

	}

	gl_FragColor = mix(col1, col2, smoothstep(0.3,0.7,mod(fTime0_X/2.0,1.0)));
	gl_FragColor *= texture2D(tex, gl_TexCoord[0].xy);
}
