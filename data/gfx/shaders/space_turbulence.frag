uniform float tick;
uniform sampler3D noisevol;
uniform vec2 mapCoord;
uniform vec4 displayColor;
uniform vec4 color1;
uniform vec4 color2;

void main(void)
{
	float fTime0_X = tick / 30000.0;
	vec2 coord = mapCoord+gl_TexCoord[0].xy;
	float noisy = texture3D(noisevol,vec3(coord,fTime0_X)).r;
	float noisy2 = texture3D(noisevol,vec3(coord/5.0,fTime0_X)).r;
	float noisy3 = texture3D(noisevol,vec3(coord/7.0,fTime0_X)).r;
	float noise = (noisy+noisy2+noisy3)/3.0;

	float bump = 1.0-abs((2.0 * noise)-1.0);
	bump *= bump - 0.3;
	gl_FragColor = mix(color1, color2, bump) * displayColor;
	gl_FragColor.a = 0.4;
}
