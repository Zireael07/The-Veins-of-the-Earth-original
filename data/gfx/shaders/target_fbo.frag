//#version 150
uniform sampler2D fboTex;
uniform sampler2D targetSkin;
uniform vec2 mapCoord;
uniform vec2 tileSize;
uniform vec2 scrollOffset;

void main(void)
{
	vec2 offset = vec2(1.0, 1.0) / mapCoord * tileSize * 0.5;
	
	/*vec4 colorm0 = texture2D( fboTex, gl_TexCoord[0].xy + vec2(-offset.x, 0.0));
	vec4 colorp0 = texture2D( fboTex, gl_TexCoord[0].xy + vec2( offset.x, 0.0));

	vec4 color0m = texture2D( fboTex, gl_TexCoord[0].xy + vec2(0.0, -offset.y));
	vec4 color0p = texture2D( fboTex, gl_TexCoord[0].xy + vec2(0.0,  offset.y));*/
	
	vec4 colormm = texture2D( fboTex, gl_TexCoord[0].xy + vec2(-offset.x,-offset.y));
	vec4 colormp = texture2D( fboTex, gl_TexCoord[0].xy + vec2(-offset.x, offset.y));
	vec4 colorpm = texture2D( fboTex, gl_TexCoord[0].xy + vec2( offset.x,-offset.y));	
	vec4 colorpp = texture2D( fboTex, gl_TexCoord[0].xy + vec2( offset.x, offset.y));	

	vec4 color00 = texture2D( fboTex, gl_TexCoord[0].xy);
	
	vec4 resultColor = color00;
		
	bool loc1 = false;
	bool loc2 = false;
	bool loc3 = false;
	bool loc4 = false;
	bool loc5 = false;
	bool loc6 = false;
	bool loc7 = false;
	bool loc8 = false;
	bool loc9 = false;
	
	if(colormm.a > 0.1)
		loc1 = true;
	if(colormp.a > 0.1)
		loc7 = true;
	if(colorpm.a > 0.1)
		loc3 = true;
	if(colorpp.a > 0.1)
		loc9 = true;
	if(color00.a > 0.1)
		loc5 = true;
		
	if(gl_TexCoord[0].x + offset.x > 1.0)
	{
		loc9 = false; 
		loc3 = false;
	}

	if(gl_TexCoord[0].x - offset.x < 0.0)
	{
		loc1 = false; 
		loc7 = false;
	}

	if(gl_TexCoord[0].y + offset.y > 1.0)
	{
		loc7 = false; 
		loc9 = false;
	}

	if(gl_TexCoord[0].y - offset.y < 0.0)
	{
		loc1 = false; 
		loc3 = false;
	}
			

	vec2 fboCoord = gl_TexCoord[0].xy;
	fboCoord.y = 1.0 - fboCoord.y;
	vec2 texCoord = (fboCoord * mapCoord + scrollOffset) / tileSize + vec2(0.5, 0.5);
	texCoord.x = mod(texCoord.x, 1.0);
	texCoord.y = mod(texCoord.y, 1.0);

	vec4 borderColor = vec4(0.0, 0.0, 0.0, 0.0);
	
	if(loc1 && loc7 && loc3 && !loc9) //1 internal
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 0.0, 1.0 / 4.0 * 3.0));
		
	if(loc9 && !loc7 && !loc3 && !loc1) //1 external
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 0.0, 1.0 / 4.0 * 1.0));
			
	if(loc7 && !loc3 && loc9 && !loc1) //2
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 2.0, 1.0 / 4.0 * 1.0));

	if(loc3 && loc1 && loc9 && !loc7) //3 internal
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 1.0, 1.0 / 4.0 * 3.0));
		
	if(loc7 && !loc1 && !loc9 && !loc3) //3 external
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 1.0, 1.0 / 4.0 * 1.0));
		
	if(loc1 && !loc9 && loc7 && !loc3) //8
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 3.0, 1.0 / 4.0 * 0.0));
			
	if(loc9 && loc7 && loc3 && !loc1)
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 1.0, 1.0 / 4.0 * 2.0));

	if(loc1 && !loc7 && !loc3 && !loc9) //9 external
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 1.0, 1.0 / 4.0 * 0.0));

	if(loc1 && !loc9  && loc3 && !loc7)
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 2.0, 1.0 / 4.0 * 0.0));

	if(loc7 && loc1 && loc9 && !loc3) //7 internal
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 0.0, 1.0 / 4.0 * 2.0));
		
	if(loc3 && !loc1 && !loc9 && !loc7) //7 external
		borderColor += texture2D( targetSkin, texCoord / 4.0 + vec2(1.0 / 4.0 * 0.0, 1.0 / 4.0 * 0.0));

	if(loc3 && !loc7 && loc9 && !loc1) //4
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 3.0, 1.0 / 4.0 * 1.0));

	if(loc3 && loc7 && !loc9 && !loc1) //3-7 diag
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 2.0, 1.0 / 4.0 * 2.0));

	if(!loc3 && !loc7 && loc9 && loc1) //1-9 diag
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 3.0, 1.0 / 4.0 * 2.0));

	if(loc3 && loc7 && loc9 && loc1) //internal quad
		borderColor += texture2D( targetSkin, texCoord / vec2(4.0, 4.0) + vec2(1.0 / 4.0 * 2.0, 1.0 / 4.0 * 3.0));
		
	if(!loc5 && borderColor.a > 0.0)
	{
		vec4 avgColor = 
			(colormm * colormm.a + colormp * colormp.a + colorpm * colorpm.a + colorpp * colorpp.a)
			/ (colormm.a + colormp.a + colorpm.a + colorpp.a + 1e-5);
		resultColor += avgColor;
		resultColor.rgb += borderColor.rgb * borderColor.a;
		resultColor.a = borderColor.a;
	}else
	{
		borderColor.rgb *= borderColor.a;
		resultColor += borderColor;
	}

	gl_FragColor = resultColor;
}
