uniform sampler2D tex;
uniform float tick;

void main(void)
{
	float fTime0_X = tick / 4000.0;
	vec4 color1 = vec4(1,1,1,1);
	vec4 color2 = vec4(1,0.8,1,1);
	gl_FragColor = mix(color1, color2, smoothstep(0.3,0.7,abs(mod(fTime0_X,2.0)-1.0)));
	gl_FragColor *= texture2D(tex, gl_TexCoord[0].xy);
}
