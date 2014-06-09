uniform float hp_warning;
uniform float air_warning;
uniform float death_warning;
uniform float solipsism_warning;
uniform float tick;
uniform sampler2D noisevol;
uniform vec2 texSize;
uniform sampler2D tex;
uniform vec4 colorize;
uniform vec4 intensify;

void main(void)
{
	gl_FragColor = texture2D(tex, gl_TexCoord[0].xy);

	if (colorize.r > 0.0 || colorize.g > 0.0 || colorize.b > 0.0)
	{
		float grey = (gl_FragColor.r*0.3+gl_FragColor.g*0.59+gl_FragColor.b*0.11) * colorize.a;
		gl_FragColor = gl_FragColor * (1.0 - colorize.a) + (vec4(colorize.r, colorize.g, colorize.b, 1.0) * grey);
	}

	if (intensify.r > 0.0 || intensify.g > 0.0 || intensify.b > 0.0)
	{
/*
		float grey = gl_FragColor.r*0.3+gl_FragColor.g*0.59+gl_FragColor.b*0.11;
		vec4 vgrey = vec4(grey, grey, grey, gl_FragColor.a);
		gl_FragColor = max(gl_FragColor * intensify, vgrey);
*/
		float grey = gl_FragColor.r*0.3+gl_FragColor.g*0.59+gl_FragColor.b*0.11;
		vec4 vgrey = vec4(grey, grey, grey, gl_FragColor.a);
		gl_FragColor = gl_FragColor * intensify;
	}

	if (hp_warning > 0.0)
	{
		vec4 hp_warning_color = vec4(hp_warning / 1.9, 0.0, 0.0, hp_warning / 1.5);
		float dist = length(gl_TexCoord[0].xy - vec2(0.5)) / 2.0;
		gl_FragColor = mix(gl_FragColor, hp_warning_color, dist);
	}

	if (air_warning > 0.0)
	{
		vec4 air_warning_color = vec4(0.0, air_warning / 3.0, air_warning / 1.0, air_warning / 1.3);
		float dist = length(gl_TexCoord[0].xy - vec2(0.5)) / 2.0;
		gl_FragColor = mix(gl_FragColor, air_warning_color, dist);
	}
	
	if (solipsism_warning > 0.0)
	{
		vec4 solipsism_warning_color = vec4(solipsism_warning / 2.0, 0.0, solipsism_warning / 2.0, solipsism_warning / 1.3);
		float dist = length(gl_TexCoord[0].xy - vec2(0.5)) / 2.0;
		gl_FragColor = mix(gl_FragColor, solipsism_warning_color, dist);
	}
}
