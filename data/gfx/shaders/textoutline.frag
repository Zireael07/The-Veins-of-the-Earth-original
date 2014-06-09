uniform sampler2D tex;
uniform vec2 textSize;
uniform float intensity; 
uniform vec2 outlineSize;
uniform vec4 outlineColor;

void main(void)
{
	float xOffset = outlineSize.x / textSize.x;
	float yOffset = outlineSize.y / textSize.y;

	gl_FragColor = texture2D(tex, gl_TexCoord[0].xy); //default text color

	//sobel distance to glyph base line approximation
	vec4 col02 = texture2D(tex, gl_TexCoord[0].xy + vec2(xOffset,  -yOffset));
	vec4 col12 = texture2D(tex, gl_TexCoord[0].xy + vec2(xOffset,   0.0     ));
	vec4 col22 = texture2D(tex, gl_TexCoord[0].xy + vec2(xOffset,   yOffset));
	vec4 col01 = texture2D(tex, gl_TexCoord[0].xy + vec2(0.0,        -yOffset));
	vec4 col21 = texture2D(tex, gl_TexCoord[0].xy + vec2(0.0,         yOffset));
	vec4 col00 = texture2D(tex, gl_TexCoord[0].xy + vec2(-xOffset, -yOffset));
	vec4 col10 = texture2D(tex, gl_TexCoord[0].xy + vec2(-xOffset,  0.0     ));
	vec4 col20 = texture2D(tex, gl_TexCoord[0].xy + vec2(-xOffset,  yOffset));
	
	
	float xDist = 0.0 - col00.a - col01.a * 2.0 - col02.a + col20.a + col21.a * 2.0 + col22.a;
	float yDist = 0.0 - col00.a + col02.a - col10.a * 2.0 + col12.a * 2.0 - col20.a + col22.a;
	
	//transperency of current outline pixel
	float alpha = min(1.0, sqrt(xDist * xDist + yDist * yDist) * intensity); 
	
	//outlineColor = vec4(0, 0, 0, 1);
	//blending character glyph over its outline
	gl_FragColor = (gl_FragColor * gl_FragColor.a + outlineColor * alpha * (1.0 - gl_FragColor.a)) * gl_Color;
}
