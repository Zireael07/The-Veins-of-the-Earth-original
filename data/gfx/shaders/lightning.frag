uniform sampler2D tex;
uniform vec3 color1;
uniform vec3 color2;

void main(void)
{
	gl_FragColor = texture2D(tex, gl_TexCoord[0].xy);
	gl_FragColor.rgb = mix(color1, color2, 1.0 - gl_FragColor.a);
	gl_FragColor *= gl_Color;
}
