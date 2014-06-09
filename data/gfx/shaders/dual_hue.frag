uniform sampler2D tex;
uniform float tick;
uniform vec4 color1;
uniform vec4 color2;

void main(void)
{
	float fTime0_X = tick / 1000.0;
	//gl_FragColor = mix(color1, color2, smoothstep(0.3,0.7,mod(fTime0_X/2.0,1.0)));
	//gl_FragColor = mix(color1, color2, sin(fTime0_X*2.0));
	gl_FragColor = mix(color1, color2, smoothstep(0.3,0.7,abs(mod(fTime0_X,2.0)-1.0)));
	gl_FragColor *= texture2D(tex, gl_TexCoord[0].xy);
}
