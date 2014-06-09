uniform sampler2D tex;
uniform float tick;
uniform float tick_start;
uniform vec3 color;
uniform float time_factor; 
 
uniform float noup;
 
uniform vec2 ellipsoidalFactor; //(1.0, 1.0) is perfect circle, (2.0, 1.0) is vertical ellipse, (1.0, 2.0) is horizontal ellipse
 
 
struct RingIntersection
{
  vec4 color;
  float depth;
};
 
 
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
  
RingIntersection GetBladeRingColor(float currTime, vec2 pos, vec3 axis)
{
  RingIntersection result;
  
  vec3 rayOrigin = vec3(pos, -5.0);
  vec3 rayDir = vec3(0.0, 0.0, 1.0);
  
  vec3 planePoint = vec3(0.0, 0.0, 0.0);
  
  result.depth = 10.0;
  result.color = vec4(0.0, 0.0, 0.0, 0.0);
 
  vec3 baseIntersection = rayOrigin + rayDir * dot(planePoint - rayOrigin, axis) / dot(axis, rayDir);
 
  vec3 localAxis = axis;
  localAxis /= length(localAxis);

  vec3 intersection = rayOrigin + rayDir * dot(planePoint - rayOrigin, localAxis) / dot(localAxis, rayDir);

  vec3 tangent0 = cross(axis, vec3(0.0, 1.0, 0.0));
  if(length(tangent0) < 1e-1)
  {
    tangent0 = cross(axis, vec3(1.0, 0.0, 0.0));
  }else
  {
  }
  tangent0 /= length(tangent0);

  vec3 tangent1 = cross(tangent0, axis);

  vec2 planarPoint = vec2(dot(intersection - planePoint, tangent0), dot(intersection - planePoint, tangent1));  
  
  vec2 rotatedPoint;

  /*float fogPhase = currTime * 5.0 + sin(someDelta * 1.5 + 9.0 * i) * 0.5;// + GetFireDelta(currTime, vec2(0.1 * i, 0.5), 1.0, 1.0, 0.0, 0.2) * 0.5;
  fogPhase = clamp(fogPhase - floor(fogPhase), 0.0, 1.0);*/
  
  float ang = -currTime * 30.0 + sin(currTime * 20.0) * 0.5;// + GetFireDelta(currTime, vec2(0.1 * i, 0.5), 1.0, 1.0, 0.0, 0.2) * 0.5;
  rotatedPoint.x = planarPoint.x * cos(ang) - planarPoint.y * sin(ang);
  rotatedPoint.y = planarPoint.x * sin(ang) + planarPoint.y * cos(ang);
  if(length(rotatedPoint) < 0.5 && rotatedPoint.x < 0.0)
  {
    vec4 airColor = /*vec4(sin(10 * i), sin(20 * i), sin(30 * i), 1.0);*/texture2D(tex, rotatedPoint + vec2(0.5, 0.5));
    //airColor.a *= (1.0 - pow(fogPhase, 3.0)) * (1.0 - pow((1.0 - fogPhase), 3.0));
    result.color = airColor;
    result.depth = intersection.z;
  }
  
  return result;
}
 
const int ringsCount = 1;
 
void main(void)
{
//  gl_FragColor = Uberblend(texture2D(tex, gl_TexCoord[0].xy), texture2D(tex, vec2(gl_TexCoord[0].x - 0.5, gl_TexCoord[0].y))); return;
//  gl_FragColor = texture2D(tex, - gl_TexCoord[0].xy); return;
  vec2 radius = gl_TexCoord[0].xy - vec2(0.5, 0.5);
 
  radius *= ellipsoidalFactor;
  
  float radiusLen = length(radius);
 
  RingIntersection ints[10];

  for (int intersectionIndex = 0; intersectionIndex < 8; intersectionIndex++)
  {
    float phase = 0.0;//tick_start * 100.0f;
    vec3 axis = vec3(
      sin(phase * 1.0 + float(intersectionIndex + 1) * 1.0),
      sin(phase * 2.0 + float(intersectionIndex + 1) * 2.0),
      sin(phase * 3.0 + float(intersectionIndex + 1) * 3.0));
    axis /= length(axis);
    ints[intersectionIndex] = GetBladeRingColor(tick / time_factor/* * (float(intersectionIndex) * 0.1 + 1.0)*/ + float(intersectionIndex) * 10.1, radius, axis);
    /*ints[intersectionIndex].color.rgb = vec3(sin(intersectionIndex * 10.0), sin(intersectionIndex * 20.0), sin(intersectionIndex * 30.0)) * 0.5 + vec3(0.5, 0.5, 0.5);    ints[intersectionIndex].color.rgb = vec3(sin(intersectionIndex * 10.0), sin(intersectionIndex * 20.0), sin(intersectionIndex * 30.0)) * 0.5 + vec3(0.5, 0.5, 0.5);
    ints[intersectionIndex].color.a = 1.0;*/
  }
/*  vec3 axis = vec3(0.4, -0.5, -0.5);
  axis /= length(axis);
  ints[0] = GetBladeRingColor(tick / time_factor * 0.9 + 10.0, radius, axis);
 
  axis = vec3(-0.6, -0.3, -0.2);
  axis /= length(axis);
  ints[1] = GetBladeRingColor(tick / time_factor, radius, axis);

  axis = vec3(-0.4, 0.3, 0.2);
  axis /= length(axis);
  ints[2] = GetBladeRingColor(tick / time_factor, radius, axis);

  ints[3].color.a = 0.0;
  ints[3].depth = 100.0;*/
 
  int intersectionIndex = 0;
  for (int intersectionIndex = 0; intersectionIndex < 8; intersectionIndex++)
  {
    if((ints[intersectionIndex].depth < 0.0 && noup == 2.0) || (ints[intersectionIndex].depth > 0.0 && noup == 1.0))
    {
      ints[intersectionIndex].color *= 0.0;
    }
    ints[intersectionIndex].color.rgb *= max(0.0, min(1.0, (0.5 - ints[intersectionIndex].depth) * 2.0 - 0.5)) * 1.0;
  }

  int i, j;
  for(i = 0; i < 8; i++)
  {
    for(j = i + 1; j < 8; j++)
    {
      if(ints[i].depth < ints[j].depth)
      {
        RingIntersection tmp = ints[j];
        ints[j] = ints[i];
        ints[i] = tmp;
      }
    }
  }
  
  vec4 resultColor = vec4(0.0, 0.0, 0.0, 0.0);
  for(i = 0; i < 8; i++)
  {
    resultColor = Uberblend(resultColor, ints[i].color);
  }

  resultColor.a = clamp(resultColor.a, 0.0, 1.0);
  resultColor.r = clamp(resultColor.r, 0.0, 1.0);
  resultColor.g = clamp(resultColor.g, 0.0, 1.0);
  resultColor.b = clamp(resultColor.b, 0.0, 1.0);
  resultColor.a *= gl_Color.a;
  
    
  gl_FragColor = resultColor;
}