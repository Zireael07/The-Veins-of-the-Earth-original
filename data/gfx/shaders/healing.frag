uniform sampler2D tex;
uniform float tick;
uniform float tick_start;
uniform float time_factor;
uniform float noup;
uniform float circleRotationSpeed;
uniform float circleDescendSpeed;

uniform float beamsCount;
uniform vec4 beamColor1;
uniform vec4 beamColor2;
uniform vec4 circleColor;

vec2 Rotate(vec2 point, float ang)
{
  return vec2(
    point.x * cos(ang) - point.y * sin(ang),
    point.x * sin(ang) + point.y * cos(ang));
}

vec4 Uberblend(vec4 col0, vec4 col1)
{
//  return vec4((1.0 - col0.a) * (col1.rgb) + col0.a * (col1.rgb * col1.a + col0.rgb * (1.0 - col1.a)), min(1.0, col0.a + col1.a));
//  return vec4((1.0 - col1.a) * (col0.rgb) + col1.a * (col1.rgb * col1.a + col0.rgb * (1.0 - col1.a)), min(1.0, col0.a + col1.a));
  return vec4(
    (1.0 - col0.a) * (1.0 - col1.a) * (col0.rgb * col0.a + col1.rgb * col1.a) / (col0.a + col1.a + 1e-1) +
    (1.0 - col0.a) * (0.0 + col1.a) * (col1.rgb) +
    (0.0 + col0.a) * (1.0 - col1.a) * (col0.rgb * (1.0 - col1.a) + col1.rgb * col1.a) +
    (0.0 + col0.a) * (0.0 + col1.a) * (col1.rgb),
    min(1.0, col0.a + col1.a));
}

void main(void)
{
  float baseRadius = 0.35;

  float beamWidth = 0.025;
  float beamHeight = 1.0;
  float beamDescend = 0.5;
  float scaledTime = 25.0 * tick / time_factor;
  float firstBeamNum = floor(scaledTime);

  float verticalAngle = 0.2;


  vec2 spritePoint = (gl_TexCoord[0].xy - vec2(0.5, 1.0)).xy * vec2(1.0, -1.0);


  float topCirclePos = 1.0 - verticalAngle * baseRadius;
  float bottomCirclePos = verticalAngle * baseRadius;

  float posScale = 0.0;
  if(circleDescendSpeed > 0.0)
    posScale = clamp(1.0 - (tick - tick_start) / time_factor * circleDescendSpeed, 0.0, 1.0);
  vec3 planePoint = vec3(0.0, topCirclePos * posScale + bottomCirclePos * (1.0 - posScale), 0.0);

  vec2 planarPoint = vec2(spritePoint.x, (spritePoint.y - planePoint.y) / verticalAngle);

  vec4 resultColor = vec4(0.0, 0.0, 0.0, 0.0);

  float circleIntersection = (spritePoint.y - planePoint.y) / verticalAngle;

  vec4 circleColorSample = vec4(0.0, 0.0, 0.0, 0.0);
  if(!((noup == 1.0 && planarPoint.y > 0.0) || (noup == 2.0 && planarPoint.y < 0.0)))
  {
    if(length(planarPoint) < 0.5)
    {
      planarPoint = Rotate(planarPoint, scaledTime * 0.1 * circleRotationSpeed);
      circleColorSample = texture2D(tex, planarPoint + vec2(0.5, 0.5)) * circleColor;
      circleColorSample.a *= (1.0 - posScale);
      //resultColor.rgb *= resultColor.a;
      //resultColor.rgb = circleColor.rgb;
    }
  }

  vec4 beamFrontColor = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 beamRearColor = vec4(0.0, 0.0, 0.0, 0.0);

  float beamTime;

  int i;
  int ibeamsCount = int(beamsCount);
  for(i = 0; i < ibeamsCount; i++)
  {
    float beamIndex = floor(scaledTime) - float(i);
    float beamPhase = (scaledTime - beamIndex) / float(ibeamsCount);
    float beamVerticalOffset = 0.02;
    float heightPhase = 1.0 - pow(1.0 - beamPhase, 3.0);
    float height = beamHeight * (1.0 - heightPhase) * (1.0 - 2.0 * verticalAngle * baseRadius - beamVerticalOffset) + heightPhase * 0.1;

    float beamColorScale = sin(beamIndex * 20.0) * 0.5 + 0.5;
    float beamAng = (sin(beamIndex * 10.0) + sin(beamIndex * 7.0)) * 3.14159265;
    if((sin(beamAng) >  0.0) && noup == 1.0) continue;
    if((sin(beamAng) <= 0.0) && noup == 2.0) continue;


    vec3 beamBase = vec3(cos(beamAng), (sin(beamAng) + 1.0) * verticalAngle, sin(beamAng)) * baseRadius * beamPhase +
      vec3(0.0, height * 0.5 + beamVerticalOffset, 0.0);

    float zMult = (1.0 - (sin(beamAng) + 1.0) / 2.0) * 0.5 + 0.5;

    vec2 screenDelta = spritePoint - beamBase.xy;
    vec4 beamColor = vec4(zMult, zMult, zMult, 1.0) * (beamColor1 * beamColorScale + beamColor2 * (1.0 - beamColorScale));

    float verticalScale = clamp(screenDelta.y / height + 0.5, 0.0, 1.0);
    beamColor.a *=
      (1.0 - pow(clamp(2.0 * abs(screenDelta.x / beamWidth ), 0.0, 1.0),  2.0)) * 
      (1.0 - pow(1.0 - verticalScale, 4.0)) * (1.0 - pow(verticalScale, 1.0)) *
      (1.0 - pow((1.0 - beamPhase), 8.0)) * (1.0 - pow(beamPhase, 2.0)) * 4.0;
    beamColor.rgb *= beamColor.a;

    if(beamBase.z > circleIntersection)
      beamRearColor += beamColor;
    else
      beamFrontColor += beamColor;
  }
  beamRearColor.rgb  /= (beamRearColor.a  + 1e-5);
  beamFrontColor.rgb /= (beamFrontColor.a + 1e-5);
  //if(beamColorSample.a > 1.0) beamColorSample /= beamColorSample.a;

  beamRearColor.r = clamp(beamRearColor.r, 0.0, 0.99);
  beamRearColor.g = clamp(beamRearColor.g, 0.0, 0.99);
  beamRearColor.b = clamp(beamRearColor.b, 0.0, 0.99);
  beamRearColor.a = clamp(beamRearColor.a, 0.0, 0.99);

  beamFrontColor.r = clamp(beamFrontColor.r, 0.0, 0.99);
  beamFrontColor.g = clamp(beamFrontColor.g, 0.0, 0.99);
  beamFrontColor.b = clamp(beamFrontColor.b, 0.0, 0.99);
  beamFrontColor.a = clamp(beamFrontColor.a, 0.0, 0.99);

  resultColor = Uberblend(Uberblend(beamRearColor, circleColorSample), beamFrontColor); 
  resultColor.a *= gl_Color.a;  
  gl_FragColor = resultColor;
}
