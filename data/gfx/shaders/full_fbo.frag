uniform sampler2D sceneBuffer;
uniform float gamma;

void main(void)
{
	vec2 uv = gl_TexCoord[0].xy;
	vec3 color = texture2D(sceneBuffer, uv).rgb;
	gl_FragColor.rgb = pow(color, vec3(1.0 / gamma));
}


/* Blurry vision
uniform sampler2D sceneTex; // 0
void main ()
{
  vec2 uv = gl_TexCoord[0].xy;
  vec4 c = texture2D(sceneTex, uv);

  c += texture2D(sceneTex, uv+0.001);
  c += texture2D(sceneTex, uv+0.003);
  c += texture2D(sceneTex, uv+0.005);
  c += texture2D(sceneTex, uv+0.007);
  c += texture2D(sceneTex, uv+0.009);
  c += texture2D(sceneTex, uv+0.011);

  c += texture2D(sceneTex, uv-0.001);
  c += texture2D(sceneTex, uv-0.003);
  c += texture2D(sceneTex, uv-0.005);
  c += texture2D(sceneTex, uv-0.007);
  c += texture2D(sceneTex, uv-0.009);
  c += texture2D(sceneTex, uv-0.011);

  c.rgb = vec3((c.r+c.g+c.b)/3.0);
  c = c / 9.5;
  gl_FragColor = c;
}
*/

/* Nightvision
uniform sampler2D sceneBuffer;
//uniform sampler2D noiseTex;
//uniform sampler2D maskTex;
//uniform float elapsedTime; // seconds
//uniform float luminanceThreshold; // 0.2
//uniform float colorAmplification; // 4.0
//uniform float effectCoverage; // 0.5
void main ()
{
float elapsedTime=1.0; // seconds
float luminanceThreshold=0.2; // 0.2
float colorAmplification=4.0; // 4.0
float effectCoverage=0.5; // 0.5

  vec4 finalColor;
  // Set effectCoverage to 1.0 for normal use.
  if (gl_TexCoord[0].x < effectCoverage)
  {
    vec2 uv;
    uv.x = 0.4*sin(elapsedTime*50.0);
    uv.y = 0.4*cos(elapsedTime*50.0);
//    float m = texture2D(maskTex, gl_TexCoord[0].st).r;
    float m = 1.0;
//    vec3 n = texture2D(noiseTex,(gl_TexCoord[0].st*3.5) + uv).rgb;
    vec3 n = vec3(1.0, 1.0, 1.0);
    vec3 c = texture2D(sceneBuffer, gl_TexCoord[0].st
                               + (n.xy*0.005)).rgb;

    float lum = dot(vec3(0.30, 0.59, 0.11), c);
    if (lum < luminanceThreshold)
      c *= colorAmplification;

    vec3 visionColor = vec3(0.1, 0.95, 0.2);
    finalColor.rgb = (c + (n*0.2)) * visionColor * m;
   }
   else
   {
    finalColor = texture2D(sceneBuffer,
                   gl_TexCoord[0].st);
   }
  gl_FragColor.rgb = finalColor.rgb;
  gl_FragColor.a = 1.0;
}
*/

/* Pixelation
uniform sampler2D sceneTex; // 0
//uniform float vx_offset;
//uniform float rt_w; // GeeXLab built-in
//uniform float rt_h; // GeeXLab built-in
//uniform float pixel_w; // 15.0
//uniform float pixel_h; // 10.0
void main()
{
	float vx_offset=0.5;
	float rt_w=1530.0; // GeeXLab built-in
	float rt_h=984.0; // GeeXLab built-in
	float pixel_w=5.0; // 15.0
	float pixel_h=5.0; // 10.0

	vec2 uv = gl_TexCoord[0].xy;

	vec3 tc = vec3(1.0, 0.0, 0.0);
	if (uv.x < (vx_offset-0.001))
	{
		float dx = pixel_w*(1./rt_w);
		float dy = pixel_h*(1./rt_h);
		vec2 coord = vec2(dx*floor(uv.x/dx),
			dy*floor(uv.y/dy));
		tc = texture2D(sceneTex, coord).rgb;
	}
	else if (uv.x>=(vx_offset+0.001))
	{
		tc = texture2D(sceneTex, uv).rgb;
	}
	gl_FragColor = vec4(tc, 1.0);
}
*/

/* Thermal vision
uniform sampler2D sceneTex; // 0
//uniform float vx_offset;
void main()
{
	float vx_offset = 0.5;
	vec2 uv = gl_TexCoord[0].xy;

	vec3 tc = vec3(1.0, 0.0, 0.0);
	if (uv.x < (vx_offset-0.001))
	{
		vec3 pixcol = texture2D(sceneTex, uv).rgb;
		vec3 colors[3];
		colors[0] = vec3(0.,0.,1.);
		colors[1] = vec3(1.,1.,0.);
		colors[2] = vec3(1.,0.,0.);
		float lum = (pixcol.r+pixcol.g+pixcol.b)/3.;
		int ix = (lum < 0.5)? 0:1;
		tc = mix(colors[ix],colors[ix+1],(lum-float(ix)*0.5)/0.5);
	}
	else if (uv.x>=(vx_offset+0.001))
	{
		tc = texture2D(sceneTex, uv).rgb;
	}
	gl_FragColor = vec4(tc, 1.0);
}
*/

/* Toonshader

//#version 150
uniform sampler2D Texture0;
//varying vec2 texCoord;

#define HueLevCount 6
#define SatLevCount 7
#define ValLevCount 4
float[HueLevCount] HueLevels = float[] (0.0,80.0,160.0,240.0,320.0,360.0);
float[SatLevCount] SatLevels = float[] (0.0,0.15,0.3,0.45,0.6,0.8,1.0);
float[ValLevCount] ValLevels = float[] (0.0,0.3,0.6,1.0);

vec3 RGBtoHSV( float r, float g, float b) {
	float minv, maxv, delta;
	vec3 res;

	minv = min(min(r, g), b);
	maxv = max(max(r, g), b);
	res.z = maxv;            // v

	delta = maxv - minv;

	if( maxv != 0.0 )
		res.y = delta / maxv;      // s
	else {
		// r = g = b = 0      // s = 0, v is undefined
		res.y = 0.0;
		res.x = -1.0;
		return res;
	}

	if( r == maxv )
		res.x = ( g - b ) / delta;      // between yellow & magenta
	else if( g == maxv )
		res.x = 2.0 + ( b - r ) / delta;   // between cyan & yellow
	else
		res.x = 4.0 + ( r - g ) / delta;   // between magenta & cyan

	res.x = res.x * 60.0;            // degrees
	if( res.x < 0.0 )
		res.x = res.x + 360.0;

	return res;
}

vec3 HSVtoRGB(float h, float s, float v ) {
	int i;
	float f, p, q, t;
	vec3 res;

	if( s == 0.0 ) {
		// achromatic (grey)
		res.x = v;
		res.y = v;
		res.z = v;
		return res;
	}

	h /= 60.0;         // sector 0 to 5
	i = int(floor( h ));
	f = h - float(i);         // factorial part of h
	p = v * ( 1.0 - s );
	q = v * ( 1.0 - s * f );
	t = v * ( 1.0 - s * ( 1.0 - f ) );

	switch( i ) {
	case 0:
		res.x = v;
		res.y = t;
		res.z = p;
		break;
	case 1:
		res.x = q;
		res.y = v;
		res.z = p;
		break;
	case 2:
		res.x = p;
		res.y = v;
		res.z = t;
		break;
	case 3:
		res.x = p;
		res.y = q;
		res.z = v;
		break;
	case 4:
		res.x = t;
		res.y = p;
		res.z = v;
		break;
	default:      // case 5:
		res.x = v;
		res.y = p;
		res.z = q;
		break;
	}

	return res;
}

float nearestLevel(float col, int mode) {
	int levCount;
	if (mode==0) levCount = HueLevCount;
	if (mode==1) levCount = SatLevCount;
	if (mode==2) levCount = ValLevCount;

	for (int i =0; i<levCount-1; i++ ) {
		if (mode==0) {
			if (col >= HueLevels[i] && col <= HueLevels[i+1]) {
				return HueLevels[i+1];
			}
		}
		if (mode==1) {
			if (col >= SatLevels[i] && col <= SatLevels[i+1]) {
				return SatLevels[i+1];
			}
		}
		if (mode==2) {
			if (col >= ValLevels[i] && col <= ValLevels[i+1]) {
				return ValLevels[i+1];
			}
		}
	}
}

// averaged pixel intensity from 3 color channels
float avg_intensity(vec4 pix) {
	return (pix.r + pix.g + pix.b)/3.;
}

vec4 get_pixel(vec2 coords, float dx, float dy) {
	return texture2D(Texture0,coords + vec2(dx, dy));
}

// returns pixel color
float IsEdge(in vec2 coords){
	float dxtex = 1.0 /float(textureSize(Texture0,0)) ;
	float dytex = 1.0 /float(textureSize(Texture0,0));
	float pix[9];
	int k = -1;
	float delta;

	// read neighboring pixel intensities
	for (int i=-1; i<2; i++) {
		for(int j=-1; j<2; j++) {
			k++;
			pix[k] = avg_intensity(get_pixel(coords,float(i)*dxtex,
				float(j)*dytex));
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
	vec4 colorOrg = texture2D( Texture0, gl_TexCoord[0].st );
	vec3 vHSV =  RGBtoHSV(colorOrg.r,colorOrg.g,colorOrg.b);
	vHSV.x = nearestLevel(vHSV.x, 0);
	vHSV.y = nearestLevel(vHSV.y, 1);
	vHSV.z = nearestLevel(vHSV.z, 2);
	float edg = IsEdge(gl_TexCoord[0].st);
	vec3 vRGB = (edg >= 0.3)? vec3(0.0,0.0,0.0):HSVtoRGB(vHSV.x,vHSV.y,vHSV.z);
	gl_FragColor = vec4(vRGB.x,vRGB.y,vRGB.z,1.0);
}
*/

/*
//#version 150

uniform sampler2D Texture0;

vec4 get_pixel(in vec2 coords, in float dx, in float dy) {
   return texture2D(Texture0,coords + vec2(dx, dy));
}

float Convolve(in float[9] kernel, in float[9] matrix,
               in float denom, in float offset) {
   float res = 0.0;
   for (int i=0; i<9; i++) {
      res += kernel[i]*matrix[i];
   }
   return clamp(res/denom + offset,0.0,1.0);
}

float[9] GetData(in int channel) {
   float dxtex = 1.0 / float(textureSize(Texture0,0));
   float dytex = 1.0 / float(textureSize(Texture0,0));
   float[9] mat;
   int k = -1;
   for (int i=-1; i<2; i++) {
      for(int j=-1; j<2; j++) {
         k++;
         mat[k] = get_pixel(gl_TexCoord[0].xy,float(i)*dxtex,
                            float(j)*dytex)[channel];
      }
   }
   return mat;
}

float[9] GetMean(in float[9] matr, in float[9] matg, in float[9] matb) {
   float[9] mat;
   for (int i=0; i<9; i++) {
      mat[i] = (matr[i]+matg[i]+matb[i])/3.;
   }
   return mat;
}

void main(void)
{
   float[9] kerEmboss = float[] (2.,0.,0.,
                                 0., -1., 0.,
                                 0., 0., -1.);

   float[9] kerSharpness = float[] (-1.,-1.,-1.,
                                    -1., 9., -1.,
                                    -1., -1., -1.);

   float[9] kerGausBlur = float[]  (1.,2.,1.,
                                    2., 4., 2.,
                                    1., 2., 1.);

   float[9] kerEdgeDetect = float[] (-1./8.,-1./8.,-1./8.,
                                     -1./8., 1., -1./8.,
                                     -1./8., -1./8., -1./8.);

   float matr[9] = GetData(0);
   float matg[9] = GetData(1);
   float matb[9] = GetData(2);
   float mata[9] = GetMean(matr,matg,matb);

   // Sharpness kernel
   gl_FragColor = vec4(Convolve(kerSharpness,matr,1.,0.),
                       Convolve(kerSharpness,matg,1.,0.),
                       Convolve(kerSharpness,matb,1.,0.),1.0);

   // Gaussian blur kernel
   //gl_FragColor = vec4(Convolve(kerGausBlur,matr,16.,0.),
   //                    Convolve(kerGausBlur,matg,16.,0.),
   //                    Convolve(kerGausBlur,matb,16.,0.),1.0);

   // Edge Detection kernel
   //gl_FragColor = vec4(Convolve(kerEdgeDetect,mata,0.1,0.),
   //                    Convolve(kerEdgeDetect,mata,0.1,0.),
   //                    Convolve(kerEdgeDetect,mata,0.1,0.),1.0);

   // Emboss kernel
   //gl_FragColor = vec4(Convolve(kerEmboss,mata,1.,1./2.),
   //                    Convolve(kerEmboss,mata,1.,1./2.),
   //                    Convolve(kerEmboss,mata,1.,1./2.),1.0);

}
*/


/* Implosion
uniform sampler2D tex;

void main()
{
 vec2 cen = vec2(0.5,0.5) - gl_TexCoord[0].xy;
 vec2 mcen = - // delete minus for implosion effect
      0.07*log(length(cen))*normalize(cen);
 gl_FragColor = texture2D(tex, gl_TexCoord[0].xy+mcen);
 }
 */
/*   Ripple (http://www.geeks3d.com/20091116/shader-library-2d-shockwave-post-processing-filter-glsl/)

uniform sampler2D sceneTex; // 0
uniform vec2 center = vec2(0.5, 0.5); // Mouse position
uniform float time = 2.0; // effect elapsed time
uniform vec3 shockParams = vec3(10.0, 0.8, 0.1); // 10.0, 0.8, 0.1
void main()
{
	vec2 uv = gl_TexCoord[0].xy;
	vec2 texCoord = uv;
	float distance = distance(uv, center);
	if ( (distance <= (time + shockParams.z)) &&
		(distance >= (time - shockParams.z)) )
	{
		float diff = (distance - time);
		float powDiff = 1.0 - pow(abs(diff*shockParams.x),
			shockParams.y);
		float diffTime = diff  * powDiff;
		vec2 diffUV = normalize(uv - center);
		texCoord = uv + (diffUV * diffTime);
	}
	gl_FragColor = texture2D(sceneTex, texCoord);
}
*/
