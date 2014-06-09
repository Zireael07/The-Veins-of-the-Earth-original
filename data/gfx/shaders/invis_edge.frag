uniform sampler2D tex;
uniform float tick;
uniform vec4 color1;
uniform vec4 color2;

float avg_intensity(vec4 pix) {
	return pix.a;
}

vec4 get_pixel(vec2 coords, float dx, float dy) {
	return texture2D(tex,coords + vec2(dx, dy));
}

// returns pixel color
float IsEdge(in vec2 coords){
	float dxtex = 0.5 /float(textureSize(tex,0)) ;
	float dytex = 0.5 /float(textureSize(tex,0));
	float pix[9];
	int k = -1;
	float delta;

	// read neighboring pixel intensities
	for (int i=-1; i<2; i++) {
		for(int j=-1; j<2; j++) {
			k++;
			pix[k] = avg_intensity(get_pixel(coords, float(i)*dxtex, float(j)*dytex));
		}
	}

	// average color differences around neighboring pixels
	delta = (abs(pix[1]-pix[7])+
		abs(pix[5]-pix[3]) +
		abs(pix[0]-pix[8])+
		abs(pix[2]-pix[6])
		)/4.;

	return clamp(5.5*delta,0.0,1.0);
}

void main(void)
{
	float edg = IsEdge(gl_TexCoord[0].xy);
	gl_FragColor = mix(color1, color2, sin(edg + tick/1000 + gl_TexCoord[0].y));
	gl_FragColor.a = edg;
}
