{@}AntimatterCopy.fs{@}uniform sampler2D tDiffuse;

varying vec2 vUv;

void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
}{@}AntimatterCopy.vs{@}varying vec2 vUv;
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}AntimatterPass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}AntimatterPosition.vs{@}uniform sampler2D tPos;
uniform float uDPR;

void main() {
    vec4 decodedPos = texture2D(tPos, position.xy);
    vec3 pos = decodedPos.xyz;

    vec4 mvPosition = modelViewMatrix * vec4(pos, 1.0);
    gl_PointSize = (0.02 * uDPR) * (1000.0 / length(mvPosition.xyz));
    gl_Position = projectionMatrix * mvPosition;
}{@}AntimatterBasicFrag.fs{@}void main() {
    gl_FragColor = vec4(1.0);
}{@}antimatter.glsl{@}vec3 getData(sampler2D tex, vec2 uv) {
    return texture2D(tex, uv).xyz;
}

vec4 getData4(sampler2D tex, vec2 uv) {
    return texture2D(tex, uv);
}

{@}blendmodes.glsl{@}float blendColorDodge(float base, float blend) {
    return (blend == 1.0)?blend:min(base/(1.0-blend), 1.0);
}
vec3 blendColorDodge(vec3 base, vec3 blend) {
    return vec3(blendColorDodge(base.r, blend.r), blendColorDodge(base.g, blend.g), blendColorDodge(base.b, blend.b));
}
vec3 blendColorDodge(vec3 base, vec3 blend, float opacity) {
    return (blendColorDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendColorBurn(float base, float blend) {
    return (blend == 0.0)?blend:max((1.0-((1.0-base)/blend)), 0.0);
}
vec3 blendColorBurn(vec3 base, vec3 blend) {
    return vec3(blendColorBurn(base.r, blend.r), blendColorBurn(base.g, blend.g), blendColorBurn(base.b, blend.b));
}
vec3 blendColorBurn(vec3 base, vec3 blend, float opacity) {
    return (blendColorBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendVividLight(float base, float blend) {
    return (blend<0.5)?blendColorBurn(base, (2.0*blend)):blendColorDodge(base, (2.0*(blend-0.5)));
}
vec3 blendVividLight(vec3 base, vec3 blend) {
    return vec3(blendVividLight(base.r, blend.r), blendVividLight(base.g, blend.g), blendVividLight(base.b, blend.b));
}
vec3 blendVividLight(vec3 base, vec3 blend, float opacity) {
    return (blendVividLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendHardMix(float base, float blend) {
    return (blendVividLight(base, blend)<0.5)?0.0:1.0;
}
vec3 blendHardMix(vec3 base, vec3 blend) {
    return vec3(blendHardMix(base.r, blend.r), blendHardMix(base.g, blend.g), blendHardMix(base.b, blend.b));
}
vec3 blendHardMix(vec3 base, vec3 blend, float opacity) {
    return (blendHardMix(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearDodge(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendLinearDodge(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendLinearDodge(vec3 base, vec3 blend, float opacity) {
    return (blendLinearDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearBurn(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendLinearBurn(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendLinearBurn(vec3 base, vec3 blend, float opacity) {
    return (blendLinearBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearLight(float base, float blend) {
    return blend<0.5?blendLinearBurn(base, (2.0*blend)):blendLinearDodge(base, (2.0*(blend-0.5)));
}
vec3 blendLinearLight(vec3 base, vec3 blend) {
    return vec3(blendLinearLight(base.r, blend.r), blendLinearLight(base.g, blend.g), blendLinearLight(base.b, blend.b));
}
vec3 blendLinearLight(vec3 base, vec3 blend, float opacity) {
    return (blendLinearLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLighten(float base, float blend) {
    return max(blend, base);
}
vec3 blendLighten(vec3 base, vec3 blend) {
    return vec3(blendLighten(base.r, blend.r), blendLighten(base.g, blend.g), blendLighten(base.b, blend.b));
}
vec3 blendLighten(vec3 base, vec3 blend, float opacity) {
    return (blendLighten(base, blend) * opacity + base * (1.0 - opacity));
}
float blendDarken(float base, float blend) {
    return min(blend, base);
}
vec3 blendDarken(vec3 base, vec3 blend) {
    return vec3(blendDarken(base.r, blend.r), blendDarken(base.g, blend.g), blendDarken(base.b, blend.b));
}
vec3 blendDarken(vec3 base, vec3 blend, float opacity) {
    return (blendDarken(base, blend) * opacity + base * (1.0 - opacity));
}
float blendPinLight(float base, float blend) {
    return (blend<0.5)?blendDarken(base, (2.0*blend)):blendLighten(base, (2.0*(blend-0.5)));
}
vec3 blendPinLight(vec3 base, vec3 blend) {
    return vec3(blendPinLight(base.r, blend.r), blendPinLight(base.g, blend.g), blendPinLight(base.b, blend.b));
}
vec3 blendPinLight(vec3 base, vec3 blend, float opacity) {
    return (blendPinLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendReflect(float base, float blend) {
    return (blend == 1.0)?blend:min(base*base/(1.0-blend), 1.0);
}
vec3 blendReflect(vec3 base, vec3 blend) {
    return vec3(blendReflect(base.r, blend.r), blendReflect(base.g, blend.g), blendReflect(base.b, blend.b));
}
vec3 blendReflect(vec3 base, vec3 blend, float opacity) {
    return (blendReflect(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendGlow(vec3 base, vec3 blend) {
    return blendReflect(blend, base);
}
vec3 blendGlow(vec3 base, vec3 blend, float opacity) {
    return (blendGlow(base, blend) * opacity + base * (1.0 - opacity));
}
float blendOverlay(float base, float blend) {
    return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
}
vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(blendOverlay(base.r, blend.r), blendOverlay(base.g, blend.g), blendOverlay(base.b, blend.b));
}
vec3 blendOverlay(vec3 base, vec3 blend, float opacity) {
    return (blendOverlay(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendHardLight(vec3 base, vec3 blend) {
    return blendOverlay(blend, base);
}
vec3 blendHardLight(vec3 base, vec3 blend, float opacity) {
    return (blendHardLight(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendPhoenix(vec3 base, vec3 blend) {
    return min(base, blend)-max(base, blend)+vec3(1.0);
}
vec3 blendPhoenix(vec3 base, vec3 blend, float opacity) {
    return (blendPhoenix(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNormal(vec3 base, vec3 blend) {
    return blend;
}
vec3 blendNormal(vec3 base, vec3 blend, float opacity) {
    return (blendNormal(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNegation(vec3 base, vec3 blend) {
    return vec3(1.0)-abs(vec3(1.0)-base-blend);
}
vec3 blendNegation(vec3 base, vec3 blend, float opacity) {
    return (blendNegation(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendMultiply(vec3 base, vec3 blend) {
    return base*blend;
}
vec3 blendMultiply(vec3 base, vec3 blend, float opacity) {
    return (blendMultiply(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendAverage(vec3 base, vec3 blend) {
    return (base+blend)/2.0;
}
vec3 blendAverage(vec3 base, vec3 blend, float opacity) {
    return (blendAverage(base, blend) * opacity + base * (1.0 - opacity));
}
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}
vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}
vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
    return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSoftLight(float base, float blend) {
    return (blend<0.5)?(2.0*base*blend+base*base*(1.0-2.0*blend)):(sqrt(base)*(2.0*blend-1.0)+2.0*base*(1.0-blend));
}
vec3 blendSoftLight(vec3 base, vec3 blend) {
    return vec3(blendSoftLight(base.r, blend.r), blendSoftLight(base.g, blend.g), blendSoftLight(base.b, blend.b));
}
vec3 blendSoftLight(vec3 base, vec3 blend, float opacity) {
    return (blendSoftLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSubtract(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendSubtract(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendSubtract(vec3 base, vec3 blend, float opacity) {
    return (blendSubtract(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendExclusion(vec3 base, vec3 blend) {
    return base+blend-2.0*base*blend;
}
vec3 blendExclusion(vec3 base, vec3 blend, float opacity) {
    return (blendExclusion(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendDifference(vec3 base, vec3 blend) {
    return abs(base-blend);
}
vec3 blendDifference(vec3 base, vec3 blend, float opacity) {
    return (blendDifference(base, blend) * opacity + base * (1.0 - opacity));
}
float blendAdd(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendAdd(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendAdd(vec3 base, vec3 blend, float opacity) {
    return (blendAdd(base, blend) * opacity + base * (1.0 - opacity));
}{@}conditionals.glsl{@}vec4 when_eq(vec4 x, vec4 y) {
  return 1.0 - abs(sign(x - y));
}

vec4 when_neq(vec4 x, vec4 y) {
  return abs(sign(x - y));
}

vec4 when_gt(vec4 x, vec4 y) {
  return max(sign(x - y), 0.0);
}

vec4 when_lt(vec4 x, vec4 y) {
  return max(sign(y - x), 0.0);
}

vec4 when_ge(vec4 x, vec4 y) {
  return 1.0 - when_lt(x, y);
}

vec4 when_le(vec4 x, vec4 y) {
  return 1.0 - when_gt(x, y);
}

vec3 when_eq(vec3 x, vec3 y) {
  return 1.0 - abs(sign(x - y));
}

vec3 when_neq(vec3 x, vec3 y) {
  return abs(sign(x - y));
}

vec3 when_gt(vec3 x, vec3 y) {
  return max(sign(x - y), 0.0);
}

vec3 when_lt(vec3 x, vec3 y) {
  return max(sign(y - x), 0.0);
}

vec3 when_ge(vec3 x, vec3 y) {
  return 1.0 - when_lt(x, y);
}

vec3 when_le(vec3 x, vec3 y) {
  return 1.0 - when_gt(x, y);
}

vec2 when_eq(vec2 x, vec2 y) {
  return 1.0 - abs(sign(x - y));
}

vec2 when_neq(vec2 x, vec2 y) {
  return abs(sign(x - y));
}

vec2 when_gt(vec2 x, vec2 y) {
  return max(sign(x - y), 0.0);
}

vec2 when_lt(vec2 x, vec2 y) {
  return max(sign(y - x), 0.0);
}

vec2 when_ge(vec2 x, vec2 y) {
  return 1.0 - when_lt(x, y);
}

vec2 when_le(vec2 x, vec2 y) {
  return 1.0 - when_gt(x, y);
}

float when_eq(float x, float y) {
  return 1.0 - abs(sign(x - y));
}

float when_neq(float x, float y) {
  return abs(sign(x - y));
}

float when_gt(float x, float y) {
  return max(sign(x - y), 0.0);
}

float when_lt(float x, float y) {
  return max(sign(y - x), 0.0);
}

float when_ge(float x, float y) {
  return 1.0 - when_lt(x, y);
}

float when_le(float x, float y) {
  return 1.0 - when_gt(x, y);
}

vec4 and(vec4 a, vec4 b) {
  return a * b;
}

vec4 or(vec4 a, vec4 b) {
  return min(a + b, 1.0);
}

vec4 Not(vec4 a) {
  return 1.0 - a;
}

vec3 and(vec3 a, vec3 b) {
  return a * b;
}

vec3 or(vec3 a, vec3 b) {
  return min(a + b, 1.0);
}

vec3 Not(vec3 a) {
  return 1.0 - a;
}

vec2 and(vec2 a, vec2 b) {
  return a * b;
}

vec2 or(vec2 a, vec2 b) {
  return min(a + b, 1.0);
}


vec2 Not(vec2 a) {
  return 1.0 - a;
}

float and(float a, float b) {
  return a * b;
}

float or(float a, float b) {
  return min(a + b, 1.0);
}

float Not(float a) {
  return 1.0 - a;
}{@}contrast.glsl{@}vec3 adjustContrast(vec3 color, float c, float m) {
	float t = 0.5 - c * 0.5;
	color.rgb = color.rgb * c + t;
	return color * m;
}{@}curl.glsl{@}#test Device.mobile
float sinf2(float x) {
    x*=0.159155;
    x-=floor(x);
    float xx=x*x;
    float y=-6.87897;
    y=y*xx+33.7755;
    y=y*xx-72.5257;
    y=y*xx+80.5874;
    y=y*xx-41.2408;
    y=y*xx+6.28077;
    return x*y;
}

float cosf2(float x) {
    return sinf2(x+1.5708);
}
#endtest

#test !Device.mobile
    #define sinf2 sin
    #define cosf2 cos
#endtest

float potential1(vec3 v) {
    float noise = 0.0;
    noise += sinf2(v.x * 1.8 + v.z * 3.) + sinf2(v.x * 4.8 + v.z * 4.5) + sinf2(v.x * -7.0 + v.z * 1.2) + sinf2(v.x * -5.0 + v.z * 2.13);
    noise += sinf2(v.y * -0.48 + v.z * 5.4) + sinf2(v.y * 2.56 + v.z * 5.4) + sinf2(v.y * 4.16 + v.z * 2.4) + sinf2(v.y * -4.16 + v.z * 1.35);
    return noise;
}

float potential2(vec3 v) {
    float noise = 0.0;
    noise += sinf2(v.y * 1.8 + v.x * 3. - 2.82) + sinf2(v.y * 4.8 + v.x * 4.5 + 74.37) + sinf2(v.y * -7.0 + v.x * 1.2 - 256.72) + sinf2(v.y * -5.0 + v.x * 2.13 - 207.683);
    noise += sinf2(v.z * -0.48 + v.x * 5.4 -125.796) + sinf2(v.z * 2.56 + v.x * 5.4 + 17.692) + sinf2(v.z * 4.16 + v.x * 2.4 + 150.512) + sinf2(v.z * -4.16 + v.x * 1.35 - 222.137);
    return noise;
}

float potential3(vec3 v) {
    float noise = 0.0;
    noise += sinf2(v.z * 1.8 + v.y * 3. - 194.58) + sinf2(v.z * 4.8 + v.y * 4.5 - 83.13) + sinf2(v.z * -7.0 + v.y * 1.2 -845.2) + sinf2(v.z * -5.0 + v.y * 2.13 - 762.185);
    noise += sinf2(v.x * -0.48 + v.y * 5.4 - 707.916) + sinf2(v.x * 2.56 + v.y * 5.4 + -482.348) + sinf2(v.x * 4.16 + v.y * 2.4 + 9.872) + sinf2(v.x * -4.16 + v.y * 1.35 - 476.747);
    return noise;
}

vec3 snoiseVec3( vec3 x ) {
    float s  = potential1(x);
    float s1 = potential2(x);
    float s2 = potential3(x);
    return vec3( s , s1 , s2 );
}

//Analitic derivatives of the potentials for the curl noise, based on: http://weber.itn.liu.se/~stegu/TNM084-2019/bridson-siggraph2007-curlnoise.pdf

float dP3dY(vec3 v) {
    float noise = 0.0;
    noise += 3. * cosf2(v.z * 1.8 + v.y * 3. - 194.58) + 4.5 * cosf2(v.z * 4.8 + v.y * 4.5 - 83.13) + 1.2 * cosf2(v.z * -7.0 + v.y * 1.2 -845.2) + 2.13 * cosf2(v.z * -5.0 + v.y * 2.13 - 762.185);
    noise += 5.4 * cosf2(v.x * -0.48 + v.y * 5.4 - 707.916) + 5.4 * cosf2(v.x * 2.56 + v.y * 5.4 + -482.348) + 2.4 * cosf2(v.x * 4.16 + v.y * 2.4 + 9.872) + 1.35 * cosf2(v.x * -4.16 + v.y * 1.35 - 476.747);
    return noise;
}

float dP2dZ(vec3 v) {
    return -0.48 * cosf2(v.z * -0.48 + v.x * 5.4 -125.796) + 2.56 * cosf2(v.z * 2.56 + v.x * 5.4 + 17.692) + 4.16 * cosf2(v.z * 4.16 + v.x * 2.4 + 150.512) -4.16 * cosf2(v.z * -4.16 + v.x * 1.35 - 222.137);
}

float dP1dZ(vec3 v) {
    float noise = 0.0;
    noise += 3. * cosf2(v.x * 1.8 + v.z * 3.) + 4.5 * cosf2(v.x * 4.8 + v.z * 4.5) + 1.2 * cosf2(v.x * -7.0 + v.z * 1.2) + 2.13 * cosf2(v.x * -5.0 + v.z * 2.13);
    noise += 5.4 * cosf2(v.y * -0.48 + v.z * 5.4) + 5.4 * cosf2(v.y * 2.56 + v.z * 5.4) + 2.4 * cosf2(v.y * 4.16 + v.z * 2.4) + 1.35 * cosf2(v.y * -4.16 + v.z * 1.35);
    return noise;
}

float dP3dX(vec3 v) {
    return -0.48 * cosf2(v.x * -0.48 + v.y * 5.4 - 707.916) + 2.56 * cosf2(v.x * 2.56 + v.y * 5.4 + -482.348) + 4.16 * cosf2(v.x * 4.16 + v.y * 2.4 + 9.872) -4.16 * cosf2(v.x * -4.16 + v.y * 1.35 - 476.747);
}

float dP2dX(vec3 v) {
    float noise = 0.0;
    noise += 3. * cosf2(v.y * 1.8 + v.x * 3. - 2.82) + 4.5 * cosf2(v.y * 4.8 + v.x * 4.5 + 74.37) + 1.2 * cosf2(v.y * -7.0 + v.x * 1.2 - 256.72) + 2.13 * cosf2(v.y * -5.0 + v.x * 2.13 - 207.683);
    noise += 5.4 * cosf2(v.z * -0.48 + v.x * 5.4 -125.796) + 5.4 * cosf2(v.z * 2.56 + v.x * 5.4 + 17.692) + 2.4 * cosf2(v.z * 4.16 + v.x * 2.4 + 150.512) + 1.35 * cosf2(v.z * -4.16 + v.x * 1.35 - 222.137);
    return noise;
}

float dP1dY(vec3 v) {
    return -0.48 * cosf2(v.y * -0.48 + v.z * 5.4) + 2.56 * cosf2(v.y * 2.56 + v.z * 5.4) +  4.16 * cosf2(v.y * 4.16 + v.z * 2.4) -4.16 * cosf2(v.y * -4.16 + v.z * 1.35);
}


vec3 curlNoise( vec3 p ) {

    //A sinf2 or cosf2 call is a trigonometric function, these functions are expensive in the GPU
    //the partial derivatives with approximations require to calculate the snoiseVec3 function 4 times.
    //The previous function evaluate the potentials that include 8 trigonometric functions each.
    //
    //This means that the potentials are evaluated 12 times (4 calls to snoiseVec3 that make 3 potential calls).
    //The whole process call 12 * 8 trigonometric functions, a total of 96 times.


    /*
    const float e = 1e-1;
    vec3 dx = vec3( e   , 0.0 , 0.0 );
    vec3 dy = vec3( 0.0 , e   , 0.0 );
    vec3 dz = vec3( 0.0 , 0.0 , e   );
    vec3 p0 = snoiseVec3(p);
    vec3 p_x1 = snoiseVec3( p + dx );
    vec3 p_y1 = snoiseVec3( p + dy );
    vec3 p_z1 = snoiseVec3( p + dz );
    float x = p_y1.z - p0.z - p_z1.y + p0.y;
    float y = p_z1.x - p0.x - p_x1.z + p0.z;
    float z = p_x1.y - p0.y - p_y1.x + p0.x;
    return normalize( vec3( x , y , z ));
    */


    //The noise that is used to define the potentials is based on analitic functions that are easy to derivate,
    //meaning that the analitic solution would provide a much faster approach with the same visual results.
    //
    //Usinf2g the analitic derivatives the algorithm does not require to evaluate snoiseVec3, instead it uses the
    //analitic partial derivatives from each potential on the corresponding axis, providing a total of
    //36 calls to trigonometric functions, making the analytic evaluation almost 3 times faster than the aproximation method.


    float x = dP3dY(p) - dP2dZ(p);
    float y = dP1dZ(p) - dP3dX(p);
    float z = dP2dX(p) - dP1dY(p);


    return normalize( vec3( x , y , z ));



}{@}depthvalue.fs{@}float getDepthValue(sampler2D tDepth, vec2 uv, float n, float f) {
    vec4 depth = texture2D(tDepth, uv);
    return (2.0 * n) / (f + n - depth.x * (f - n));
}

float getDepthValue(float z, float n, float f) {
    return (2.0 * n) / (f + n - z * (f - n));
}

float getEyeZ(float depth, float n, float f) {
    float z = depth * 2.0 - 1.0;
    return (2.0 * n * f) / (f + n - z * (f - n));
}

vec3 eyePosFromDepth(sampler2D tDepth, vec2 c, float n, float f) {
    float eyeZ = getEyeZ(texelFetch(tDepth, ivec2(gl_FragCoord.xy), 0).x, n, f);
    float x = ((1.0 - projectionMatrix[2][0]) / projectionMatrix[0][0]) - (2.0 * (c.x + 0.5) / (resolution.x * projectionMatrix[0][0]));
    float y = ((1.0 + projectionMatrix[2][1]) / projectionMatrix[1][1]) - (2.0 * (c.y + 0.5) / (resolution.y * projectionMatrix[1][1]));
    return vec3(vec2(x,y) * -eyeZ, -eyeZ);
}

vec3 eyePosFromDepth(float depth, float n, float f, vec2 c, bool linearDepth) {
    float eyeZ = linearDepth ? depth : getEyeZ(depth, n, f);
    float x = ((1.0 - projectionMatrix[2][0]) / projectionMatrix[0][0]) - (2.0 * (c.x + 0.5) / (resolution.x * projectionMatrix[0][0]));
    float y = ((1.0 + projectionMatrix[2][1]) / projectionMatrix[1][1]) - (2.0 * (c.y + 0.5) / (resolution.y * projectionMatrix[1][1]));
    return vec3(vec2(x,y) * -eyeZ, -eyeZ);
}

vec3 worldPosFromDepth(sampler2D tDepth) {
    float depth = texture2D(tDepth, vUv).r;
    float z = depth * 2.0 - 1.0;

    vec4 clipSpacePosition = vec4(vUv * 2.0 - 1.0, z, 1.0);
    vec4 viewSpacePosition = inverse(projectionMatrix) * clipSpacePosition;

    // Perspective division
    viewSpacePosition /= viewSpacePosition.w;

    vec4 worldSpacePosition = inverse(viewMatrix) * viewSpacePosition;

    return worldSpacePosition.xyz;
}
{@}eases.glsl{@}#ifndef PI
#define PI 3.141592653589793
#endif

#ifndef HALF_PI
#define HALF_PI 1.5707963267948966
#endif

float backInOut(float t) {
  float f = t < 0.5
    ? 2.0 * t
    : 1.0 - (2.0 * t - 1.0);

  float g = pow(f, 3.0) - f * sin(f * PI);

  return t < 0.5
    ? 0.5 * g
    : 0.5 * (1.0 - g) + 0.5;
}

float backIn(float t) {
  return pow(t, 3.0) - t * sin(t * PI);
}

float backOut(float t) {
  float f = 1.0 - t;
  return 1.0 - (pow(f, 3.0) - f * sin(f * PI));
}

float bounceOut(float t) {
  const float a = 4.0 / 11.0;
  const float b = 8.0 / 11.0;
  const float c = 9.0 / 10.0;

  const float ca = 4356.0 / 361.0;
  const float cb = 35442.0 / 1805.0;
  const float cc = 16061.0 / 1805.0;

  float t2 = t * t;

  return t < a
    ? 7.5625 * t2
    : t < b
      ? 9.075 * t2 - 9.9 * t + 3.4
      : t < c
        ? ca * t2 - cb * t + cc
        : 10.8 * t * t - 20.52 * t + 10.72;
}

float bounceIn(float t) {
  return 1.0 - bounceOut(1.0 - t);
}

float bounceInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
}

float circularInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
    : 0.5 * (sqrt((3.0 - 2.0 * t) * (2.0 * t - 1.0)) + 1.0);
}

float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

float circularOut(float t) {
  return sqrt((2.0 - t) * t);
}

float cubicInOut(float t) {
  return t < 0.5
    ? 4.0 * t * t * t
    : 0.5 * -pow(2.0 - 2.0 * t, 3.0) + 1.0;
}

float cubicIn(float t) {
  return t * t * t;
}

float cubicOut(float t) {
  float f = t - 1.0;
  return f * f * f + 1.0;
}

float elasticInOut(float t) {
  return t < 0.5
    ? 0.5 * sin(+13.0 * HALF_PI * 2.0 * t) * pow(2.0, 10.0 * (2.0 * t - 1.0))
    : 0.5 * sin(-13.0 * HALF_PI * ((2.0 * t - 1.0) + 1.0)) * pow(2.0, -10.0 * (2.0 * t - 1.0)) + 1.0;
}

float elasticIn(float t) {
  return sin(13.0 * t * HALF_PI) * pow(2.0, 10.0 * (t - 1.0));
}

float elasticOut(float t) {
  return sin(-13.0 * (t + 1.0) * HALF_PI) * pow(2.0, -10.0 * t) + 1.0;
}

float expoInOut(float t) {
  return t == 0.0 || t == 1.0
    ? t
    : t < 0.5
      ? +0.5 * pow(2.0, (20.0 * t) - 10.0)
      : -0.5 * pow(2.0, 10.0 - (t * 20.0)) + 1.0;
}

float expoIn(float t) {
  return t == 0.0 ? t : pow(2.0, 10.0 * (t - 1.0));
}

float expoOut(float t) {
  return t == 1.0 ? t : 1.0 - pow(2.0, -10.0 * t);
}

float linear(float t) {
  return t;
}

float quadraticInOut(float t) {
  float p = 2.0 * t * t;
  return t < 0.5 ? p : -p + (4.0 * t) - 1.0;
}

float quadraticIn(float t) {
  return t * t;
}

float quadraticOut(float t) {
  return -t * (t - 2.0);
}

float quarticInOut(float t) {
  return t < 0.5
    ? +8.0 * pow(t, 4.0)
    : -8.0 * pow(1.0 - t, 4.0) + 1.0;
}

float quarticIn(float t) {
  return pow(t, 4.0);
}

float quarticOut(float t) {
  return pow(1.0 - t, 3.0) * (t - 1.0) + 1.0;
}

float qinticInOut(float t) {
  return t < 0.5
    ? +16.0 * pow(t, 5.0)
    : -0.5 * pow(2.0 * t - 2.0, 5.0) + 1.0;
}

float qinticIn(float t) {
  return pow(t, 5.0);
}

float qinticOut(float t) {
  return 1.0 - (pow(1.0 - t, 5.0));
}

float sineInOut(float t) {
  return -0.5 * (cos(PI * t) - 1.0);
}

float sineIn(float t) {
  return sin((t - 1.0) * HALF_PI) + 1.0;
}

float sineOut(float t) {
  return sin(t * HALF_PI);
}
{@}ColorMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 color;
uniform float alpha;

#!VARYINGS

#!SHADER: ColorMaterial.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ColorMaterial.fs
void main() {
    gl_FragColor = vec4(color, alpha);
}{@}DebugCamera.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec3 vColor;

#!SHADER: DebugCamera.vs
void main() {
    vColor = mix(uColor, vec3(1.0, 0.0, 0.0), step(position.z, -0.1));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DebugCamera.fs
void main() {
    gl_FragColor = vec4(vColor, 1.0);
}{@}OcclusionMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 bbMin;
uniform vec3 bbMax;

#!VARYINGS

#!SHADER: Vertex.vs
void main() {
    vec3 pos = position;
    pos *= bbMax - bbMin;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment.fs
void main() {
    gl_FragColor = vec4(1.0);
}{@}ScreenQuad.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS

#!SHADER: ScreenQuad.vs
void main() {
    gl_Position = vec4(position, 1.0);
}

#!SHADER: ScreenQuad.fs
void main() {
    gl_FragColor = texture2D(tMap, gl_FragCoord.xy / resolution);
    gl_FragColor.a = 1.0;
}
{@}ScreenQuadVR.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uEye;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec2 st = uv - origin;
    st /= scale;
    return st + origin;
}

void main() {
    vUv = scaleUV(uv, vec2(2.0, 1.0), vec2(0.0)) - vec2(uEye, 0.0);
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
}{@}TestMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float alpha;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: TestMaterial.vs
void main() {
    vec3 pos = position;
    vNormal = normalMatrix * normal;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: TestMaterial.fs
void main() {
    gl_FragColor = vec4(vNormal, 1.0);
}{@}TextureMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: TextureMaterial.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: TextureMaterial.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}BlitPass.fs{@}void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
    gl_FragColor.a = 1.0;
}{@}NukePass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}ShadowDepth.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: ShadowDepth.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ShadowDepth.fs
void main() {
    gl_FragColor = vec4(vec3(gl_FragCoord.x), 1.0);
}{@}instance.vs{@}vec3 transformNormal(vec3 n, vec4 orientation) {
    vec3 nn = n + 2.0 * cross(orientation.xyz, cross(orientation.xyz, n) + orientation.w * n);
    return nn;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale, vec4 orientation) {
    vec3 _pos = position;
    _pos *= scale;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, vec4 orientation) {
    vec3 _pos = position;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale, vec4 orientation) {
    return transformPosition(position, offset, vec3(scale), orientation);
}

vec3 transformPosition(vec3 position, vec3 offset) {
    return position + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale) {
    vec3 pos = position * scale;
    return pos + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale) {
    vec3 pos = position * scale;
    return pos + offset;
}{@}lights.fs{@}vec3 worldLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}lights.vs{@}vec3 worldLight(vec3 pos) {
    vec4 mvPos = modelViewMatrix * vec4(position, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}

vec3 worldLight(vec3 lightPos, vec3 localPos) {
    vec4 mvPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(lightPos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}shadows.fs{@}#define PI2 6.2831853072
#define PI 3.141592653589793

#define MAX_PCSS_SAMPLES 17
vec2 poissonDisk[MAX_PCSS_SAMPLES];

struct PCSShadowConfig {
    int sampleCount;
    int ringCount;
    float lightWorldSize;
    float lightFrustumWidth;
    float nearPlane;
};

PCSShadowConfig defaultPCSSShadowConfig() {
    PCSShadowConfig config;
    config.sampleCount = 10;
    config.ringCount = 11;
    config.lightWorldSize = 0.3;
    config.lightFrustumWidth = 6.75;
    config.nearPlane = 6.5;
    return config;
}

bool frustumTest(vec3 coords) {
    return coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
}

float rand(float n){return fract(sin(n) * 43758.5453123);}
highp float rand( const in vec2 uv ) {
    const highp float a = 12.9898, b = 78.233, c = 43758.5453;
    highp float dt = dot( uv.xy, vec2( a, b ) ), sn = mod( dt, PI );
    return fract( sin( sn ) * c );
}

void initPoissonSamples(const in vec2 randomSeed, PCSShadowConfig config) {
    float angleStep = PI2 * float(config.ringCount) / float(config.sampleCount);
    float invSampleCount = 1.0 / float(config.sampleCount);
    float angle = rand(randomSeed) * PI2;
    float radius = invSampleCount;
    float radiusStep = radius;
    
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > config.sampleCount ) {
            break;
        }
        poissonDisk[i] = vec2(cos(angle), sin(angle)) * pow(radius, 0.75);
        radius += radiusStep;
        angle += angleStep;
    }
}

float penumbraSize(const in float zReceiver, const in float zBlocker) {
    return (zReceiver - zBlocker) / zBlocker;
}

float findBlocker(sampler2D shadowMap, const in vec2 uv, const in float zReceiver, PCSShadowConfig config) {
    // This uses similar triangles to compute what
    // area of the shadow map we should search
    float lightSizeUV = config.lightWorldSize / config.lightFrustumWidth;
    float searchRadius = lightSizeUV * (zReceiver - config.nearPlane) / zReceiver;
    float blockerDepthSum = 0.0;
    int numBlockers = 0;
    
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > config.sampleCount ) {
            break;
        }
        float shadowMapDepth = texture2D(shadowMap, uv + poissonDisk[i] * searchRadius).r;
        if (shadowMapDepth < zReceiver) {
            blockerDepthSum += shadowMapDepth;
            numBlockers ++ ;
        }
    }
    
    if (numBlockers == 0)return -1.0;
    
    return blockerDepthSum / float(numBlockers);
}

float pcfFilter(sampler2D shadowMap, vec2 uv, float zReceiver, float filterRadius, PCSShadowConfig config) {
    float sum = 0.0;
    float depth;
    int numSamples = config.sampleCount;
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > numSamples ) {
            break;
        }
        depth = texture2D(shadowMap, uv + poissonDisk[i] * filterRadius).r;
        if (zReceiver <= depth) sum += 1.0;
    }
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > numSamples ) {
            break;
        }
        depth = texture2D(shadowMap, uv + -poissonDisk[i].yx * filterRadius).r;
        if (zReceiver <= depth) sum += 1.0;
    }
    return sum / (2.0 * float(numSamples));
}

float PCSS(sampler2D shadowMap, vec3 coords, PCSShadowConfig config) {
    vec2 uv = coords.xy;
    float zReceiver = coords.z; // Assumed to be eye-space z in this code
    
    initPoissonSamples(uv, config);
    
    float avgBlockerDepth = findBlocker(shadowMap, uv, zReceiver, config);
    if (avgBlockerDepth == -1.0)return 1.0; 

    float penumbraRatio = penumbraSize(zReceiver, avgBlockerDepth);
    float lightSizeUV = config.lightWorldSize / config.lightFrustumWidth;
    float filterRadius = penumbraRatio * lightSizeUV * config.nearPlane / zReceiver;    

    return pcfFilter(shadowMap, uv, zReceiver, filterRadius, config);
}

float shadowLookupPCSS(sampler2D map, vec3 coords, float size, float compare, vec3 wpos, PCSShadowConfig config) {
    float shadow = 1.0;
    bool frustumTest = frustumTest(coords);
    if (frustumTest) {
        shadow = PCSS(map, coords, config);
    }
    return clamp(shadow, 0.0, 1.0);
}

float shadowCompare(sampler2D map, vec2 coords, float compare) {
    return step(compare, texture2D(map, coords).r);
}

float shadowLerp(sampler2D map, vec2 coords, float compare, float size) {
    const vec2 offset = vec2(0.0, 1.0);

    vec2 texelSize = vec2(1.0) / size;
    vec2 centroidUV = floor(coords * size + 0.5) / size;

    float lb = shadowCompare(map, centroidUV + texelSize * offset.xx, compare);
    float lt = shadowCompare(map, centroidUV + texelSize * offset.xy, compare);
    float rb = shadowCompare(map, centroidUV + texelSize * offset.yx, compare);
    float rt = shadowCompare(map, centroidUV + texelSize * offset.yy, compare);

    vec2 f = fract( coords * size + 0.5 );

    float a = mix( lb, lt, f.y );
    float b = mix( rb, rt, f.y );
    float c = mix( a, b, f.x );

    return c;
}

float srange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float shadowrandom(vec3 vin) {
    vec3 v = vin * 0.1;
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += srange(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += srange(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}

float shadowLookup(sampler2D map, vec3 coords, float size, float compare, vec3 wpos) {
    float shadow = 1.0;

    #if defined(SHADOW_MAPS)
    bool frustumTest = coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
    if (frustumTest) {
        
        vec2 texelSize = vec2(1.0) / size;

        float dx0 = -texelSize.x;
        float dy0 = -texelSize.y;
        float dx1 = +texelSize.x;
        float dy1 = +texelSize.y;

        float rnoise = shadowrandom(wpos) * 0.00015;
        dx0 += rnoise;
        dy0 -= rnoise;
        dx1 += rnoise;
        dy1 -= rnoise;

        #if defined(SHADOWS_MED)
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx1, dy0), compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx0, 0.0), compare);
        shadow += shadowCompare(map, coords.xy, compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx1, 0.0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx0, dy1), compare);
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy1), compare);
        shadow /= 5.0;

        #elif defined(SHADOWS_HIGH)
        shadow = shadowLerp(map, coords.xy + vec2(dx0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy, compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy1), compare, size);
        shadow /= 9.0;

        #else
        shadow = shadowCompare(map, coords.xy, compare);
        #endif
    }

        #endif

    return clamp(shadow, 0.0, 1.0);
}

#test !!window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos, mat4 mvMatrix, mat4 viewMatrix) {
    vec4 mvPos = mvMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookup(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, normal, 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), bias, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, vec3 normal) {
    return 1.0;
}

float getShadow(vec3 pos, float bias) {
    return 1.0;
}

float getShadow(vec3 pos) {
    return 1.0;
}

float getShadowPCSS(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap, PCSShadowConfig config) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookupPCSS(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadowPCSS(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    PCSShadowConfig config = defaultPCSSShadowConfig();
    return getShadowPCSS(pos, normal, bias, config);
}

#endtest

#test !window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias) {

    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookup(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos);        
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }
    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal) {
    return getShadow(pos, normal, 0.0);
}

float getShadow(vec3 pos, float bias) {
    return getShadow(pos, vec3(99999.0), bias);
}

float getShadow(vec3 pos) {
    return getShadow(pos, vec3(99999.0), 0.0);
}

float getShadowPCSS(vec3 pos, vec3 normal, float bias, PCSShadowConfig config) {    
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookupPCSS(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos, config);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }
    #endif
    
    return shadow;
}

float getShadowPCSS(vec3 pos, vec3 normal, float bias) {
    PCSShadowConfig config = defaultPCSSShadowConfig();
    return getShadowPCSS(pos, normal, bias, config);
}
#endtest{@}fresnel.glsl{@}float getFresnel(vec3 normal, vec3 viewDir, float power) {
    float d = dot(normalize(normal), normalize(viewDir));
    return 1.0 - pow(abs(d), power);
}

float getFresnel(float inIOR, float outIOR, vec3 normal, vec3 viewDir) {
    float ro = (inIOR - outIOR) / (inIOR + outIOR);
    float d = dot(normalize(normal), normalize(viewDir));
    return ro + (1. - ro) * pow((1. - d), 5.);
}


//viewDir = -vec3(modelViewMatrix * vec4(position, 1.0));{@}FXAA.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMask;

#!VARYINGS
varying vec2 v_rgbNW;
varying vec2 v_rgbNE;
varying vec2 v_rgbSW;
varying vec2 v_rgbSE;
varying vec2 v_rgbM;

#!SHADER: FXAA.vs

varying vec2 vUv;

void main() {
    vUv = uv;

    vec2 fragCoord = uv * resolution;
    vec2 inverseVP = 1.0 / resolution.xy;
    v_rgbNW = (fragCoord + vec2(-1.0, -1.0)) * inverseVP;
    v_rgbNE = (fragCoord + vec2(1.0, -1.0)) * inverseVP;
    v_rgbSW = (fragCoord + vec2(-1.0, 1.0)) * inverseVP;
    v_rgbSE = (fragCoord + vec2(1.0, 1.0)) * inverseVP;
    v_rgbM = vec2(fragCoord * inverseVP);

    gl_Position = vec4(position, 1.0);
}

#!SHADER: FXAA.fs

#require(conditionals.glsl)

#ifndef FXAA_REDUCE_MIN
    #define FXAA_REDUCE_MIN   (1.0/ 128.0)
#endif
#ifndef FXAA_REDUCE_MUL
    #define FXAA_REDUCE_MUL   (1.0 / 8.0)
#endif
#ifndef FXAA_SPAN_MAX
    #define FXAA_SPAN_MAX     8.0
#endif

vec4 fxaa(sampler2D tex, vec2 fragCoord, vec2 resolution,
            vec2 v_rgbNW, vec2 v_rgbNE,
            vec2 v_rgbSW, vec2 v_rgbSE,
            vec2 v_rgbM) {
    vec4 color;
    mediump vec2 inverseVP = vec2(1.0 / resolution.x, 1.0 / resolution.y);
    vec3 rgbNW = texture2D(tex, v_rgbNW).xyz;
    vec3 rgbNE = texture2D(tex, v_rgbNE).xyz;
    vec3 rgbSW = texture2D(tex, v_rgbSW).xyz;
    vec3 rgbSE = texture2D(tex, v_rgbSE).xyz;
    vec4 texColor = texture2D(tex, v_rgbM);
    vec3 rgbM  = texColor.xyz;
    vec3 luma = vec3(0.299, 0.587, 0.114);
    float lumaNW = dot(rgbNW, luma);
    float lumaNE = dot(rgbNE, luma);
    float lumaSW = dot(rgbSW, luma);
    float lumaSE = dot(rgbSE, luma);
    float lumaM  = dot(rgbM,  luma);
    float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
    float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));

    mediump vec2 dir;
    dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
    dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));

    float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) *
                          (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);

    float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
    dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX),
              max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX),
              dir * rcpDirMin)) * inverseVP;

    vec3 rgbA = 0.5 * (
        texture2D(tex, fragCoord * inverseVP + dir * (1.0 / 3.0 - 0.5)).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * (2.0 / 3.0 - 0.5)).xyz);
    vec3 rgbB = rgbA * 0.5 + 0.25 * (
        texture2D(tex, fragCoord * inverseVP + dir * -0.5).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * 0.5).xyz);

    float lumaB = dot(rgbB, luma);

    color = vec4(rgbB, texColor.a);
    color = mix(color, vec4(rgbA, texColor.a), when_lt(lumaB, lumaMin));
    color = mix(color, vec4(rgbA, texColor.a), when_gt(lumaB, lumaMax));

    return color;
}

void main() {
    vec2 fragCoord = vUv * resolution;
    float mask = texture2D(tMask, vUv).r;
    if (mask < 0.5) {
        gl_FragColor = fxaa(tDiffuse, fragCoord, resolution, v_rgbNW, v_rgbNE, v_rgbSW, v_rgbSE, v_rgbM);
    } else {
        gl_FragColor = texture2D(tDiffuse, vUv);
    }
    gl_FragColor.a = 1.0;
}
{@}glscreenprojection.glsl{@}vec2 frag_coord(vec4 glPos) {
    return ((glPos.xyz / glPos.w) * 0.5 + 0.5).xy;
}

vec2 getProjection(vec3 pos, mat4 projMatrix) {
    vec4 mvpPos = projMatrix * vec4(pos, 1.0);
    return frag_coord(mvpPos);
}

void applyNormal(inout vec3 pos, mat4 projNormalMatrix) {
    vec3 transformed = vec3(projNormalMatrix * vec4(pos, 0.0));
    pos = transformed;
}{@}DefaultText.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS

varying vec2 vUv;

#!SHADER: DefaultText.vs

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DefaultText.fs

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha;
}
{@}msdf.glsl{@}float msdf(vec3 tex, vec2 uv) {
    // TODO: fallback for fwidth for webgl1 (need to enable ext)
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float d = fwidth(signedDist);
    float alpha = smoothstep(-d, d, signedDist);
    if (alpha < 0.01) discard;
    return alpha;
}

float msdf(sampler2D tMap, vec2 uv) {
    vec3 tex = texture2D(tMap, uv).rgb;
    return msdf( tex, uv );
}

float strokemsdf(sampler2D tMap, vec2 uv, float stroke, float padding) {
    vec3 tex = texture2D(tMap, uv).rgb;
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float t = stroke;
    float alpha = smoothstep(-t, -t + padding, signedDist) * smoothstep(t, t - padding, signedDist);
    return alpha;
}{@}GLUIBatch.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(rotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));
    pos.xy *= scale;
    pos.xyz += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(1.0);
}{@}GLUIBatchText.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 lrotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(lrotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));

    //custommain

    pos.xy *= scale;
    pos += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = v_uColor;
    gl_FragColor.a = alpha * v_uAlpha;
}
{@}GLUIColor.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIColor.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIColor.fs
void main() {
    vec2 uv = vUv;
    vec3 uvColor = vec3(uv, 1.0);
    gl_FragColor = vec4(mix(uColor, uvColor, 0.0), uAlpha);
}{@}GLUIObject.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIObject.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIObject.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
}{@}gluimask.fs{@}uniform vec4 uMaskValues;

#require(range.glsl)

vec2 getMaskUV() {
    vec2 ores = gl_FragCoord.xy / resolution;
    vec2 uv;
    uv.x = range(ores.x, uMaskValues.x, uMaskValues.z, 0.0, 1.0);
    uv.y = 1.0 - range(1.0 - ores.y, uMaskValues.y, uMaskValues.w, 0.0, 1.0);
    return uv;
}{@}luma.fs{@}float luma(vec3 color) {
  return dot(color, vec3(0.299, 0.587, 0.114));
}

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}{@}PBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: Vertex

#require(pbr.vs)

void main() {
    vec3 pos = position;
    setupPBR(pos);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(pbr.fs)

void main() {
    gl_FragColor = getPBR();
}
{@}pbr.fs{@}uniform sampler2D tBaseColor;
uniform sampler2D tMRO;
uniform sampler2D tNormal;
uniform sampler2D tLUT;

uniform sampler2D tEnvDiffuse;
uniform sampler2D tEnvSpecular;
uniform vec2 uEnvOffset;

uniform sampler2D tLightmap;
uniform float uUseLightmap;
uniform float uLightmapIntensity;
uniform float uUseLinearOutput;

uniform vec3 uTint;
uniform vec2 uTiling;
uniform vec2 uOffset;
uniform vec4 uMRON;
uniform vec3 uEnv;

uniform float uHDR;

varying vec2 vUv;
varying vec2 vUv2;
varying vec3 vV;
varying vec3 vWorldNormal;

vec3 unpackNormalPBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 N = normalize(surf_norm);

    vec3 q1perp = cross( q1, N );
    vec3 q0perp = cross( N, q0 );

    vec3 T = q1perp * st0.x + q0perp * st1.x;
    vec3 B = q1perp * st0.y + q0perp * st1.y;

    float det = max( dot( T, T ), dot( B, B ) );
    float scalefactor = ( det == 0.0 ) ? 0.0 : inversesqrt( det );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;

    return normalize( T * ( mapN.x * scalefactor ) + B * ( mapN.y * scalefactor ) + N * mapN.z );
}

const vec2 INV_ATAN = vec2(0.1591, 0.3183);
const float LN2 = 0.6931472;
const float ENV_LODS = 7.0;
const float PI = 3.14159;

struct PBRConfig {
    float reflection;
    float clearcoat;
    vec3 color;
    vec3 lightColor;
    vec3 envReflection;
    bool overrideMRO;
    vec3 mro;
};

vec3 fresnelSphericalGaussianRoughness(float cosTheta, vec3 F0, float roughness) {
    return F0 + (max(vec3(1.0 - roughness), F0) - F0) * pow(2.0, (-5.55473 * cosTheta - 6.98316) * cosTheta);
}

vec2 sampleSphericalMap(vec3 v) {
    vec3 normalizedV = normalize(v);
    vec2 uv = vec2(0.5 + atan(normalizedV.z, normalizedV.x) / (2.0 * PI), 0.5 + asin(normalizedV.y) / PI);
    return uv;
}

vec4 SRGBtoLinear(vec4 srgb) {
    vec3 linOut = pow(srgb.xyz, vec3(2.2));
    return vec4(linOut, srgb.w);
}

vec3 linearToSRGB(vec3 color) {
    return pow(color, vec3(0.4545454545454545));
}

vec4 linearToSRGB(vec4 color) {
    return vec4(pow(color.rgb, vec3(0.4545454545454545)), 1.0);
}

vec4 RGBMToLinear(vec4 value) {
    float maxRange = 6.0;
    return vec4(value.xyz * value.w * maxRange, 1.0);
}

vec4 autoToLinear(vec4 texel, float uHDR) {
    vec4 color = RGBMToLinear(texel);
    if (uHDR < 0.001) { color = SRGBtoLinear(texel); }
    return color;
}

vec3 uncharted2Tonemap(vec3 x) {
    float A = 0.15;
    float B = 0.50;
    float C = 0.10;
    float D = 0.20;
    float E = 0.02;
    float F = 0.30;
    return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}

vec3 uncharted2(vec3 color) {
    const float W = 11.2;
    float exposureBias = 2.0;
    vec3 curr = uncharted2Tonemap(exposureBias * color);
    vec3 whiteScale = 1.0 / uncharted2Tonemap(vec3(W));
    return curr * whiteScale;
}

vec4 getIBLContribution(float NdV, vec4 baseColor, vec4 MRO, vec3 R, vec3 V, vec3 N, sampler2D tLUT, sampler2D tEnvDiffuse, sampler2D tEnvSpecular, PBRConfig config) {
    float metallic = clamp(MRO.x + uMRON.x - 1.0, 0.0, 1.0);
    float roughness = clamp(MRO.y + uMRON.y - 1.0, 0.0, 1.0);
    float ao = mix(1.0, MRO.z, uMRON.z);

    if (config.overrideMRO) {
        metallic = config.mro.x;
        roughness = config.mro.y;
        ao *= config.mro.z;
    }

    vec2 lutUV = vec2(NdV, roughness);
    vec2 diffuseUV = sampleSphericalMap(N);

    vec3 brdf = SRGBtoLinear(texture2D(tLUT, lutUV)).rgb;
    vec3 diffuse = autoToLinear( texture2D(tEnvDiffuse, diffuseUV + uEnvOffset ), uHDR).rgb;

    vec3 lightmap = vec3(1.0);

    if (uUseLightmap > 0.0) {
        lightmap = texture2D(tLightmap, vUv2).rgb;
        lightmap.rgb = pow(lightmap.rgb, vec3(2.2)) * uLightmapIntensity;
        diffuse.rgb *= lightmap.rgb;
    }

    diffuse *= baseColor.rgb;

    float level = floor(roughness * ENV_LODS);
    vec2 specUV = sampleSphericalMap(R);

    specUV.y /= 2.0;
    specUV /= pow(2.0, level);
    specUV.y += 1.0 - exp(-LN2 * level);

    vec3 specular = autoToLinear(texture2D(tEnvSpecular, specUV + uEnvOffset), uHDR).rgb;

    // fake stronger specular highlight
    specular += pow(specular, vec3(2.2)) * uEnv.y;

    if (uUseLightmap > 0.0) {
        specular *= lightmap;
    }

    vec3 F0 = vec3(0.04);
    F0 = mix(F0, baseColor.rgb, metallic);

    vec3 F = fresnelSphericalGaussianRoughness(NdV, F0, roughness);

    vec3 diffuseContrib = 1.0 - F;
    specular = specular.rgb * (F * brdf.x + brdf.y);

    diffuseContrib *= 1.0 - metallic;

    float alpha = baseColor.a;

    return vec4((diffuseContrib * diffuse + specular + (config.envReflection*0.01)) * ao * uEnv.x, alpha);
}

vec3 getNormal() {
    vec3 N = vWorldNormal;
    vec3 V = normalize(vV);
    return unpackNormalPBR(V, N, tNormal, uMRON.w, 1.0, vUv).xyz;
}

vec4 getPBR(vec3 baseColor, PBRConfig config) {
    vec3 N = vWorldNormal;
    vec3 V = normalize(vV);
    vec3 worldNormal = getNormal();
    vec3 R = reflect(V, worldNormal);
    float NdV = abs(dot(worldNormal, V));
    vec4 baseColor4 = SRGBtoLinear(vec4(baseColor, 1.0));

    vec4 MRO = texture2D(tMRO, vUv);
    vec4 color = getIBLContribution(NdV, baseColor4, MRO, R, V, worldNormal, tLUT, tEnvDiffuse, tEnvSpecular, config);

    if (uUseLinearOutput < 0.5) {
        color.rgb = uncharted2(color.rgb);
        color = linearToSRGB(color);
    }

    return color;
}

vec4 getPBR(vec3 baseColor) {
    PBRConfig config;
    return getPBR(baseColor, config);
}

vec4 getPBR() {
    vec4 baseColor = texture2D(tBaseColor, vUv);
    vec4 color = getPBR(baseColor.rgb * uTint);
    color.a *= baseColor.a;
    return color;
}
{@}pbr.vs{@}attribute vec2 uv2;

uniform sampler2D tBaseColor;
uniform vec2 uTiling;
uniform vec2 uOffset;

varying vec2 vUv;
varying vec2 vUv2;
varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec3 vV;

void setupPBR(vec3 p0) { //inlinemain
    vUv = uv * uTiling + uOffset;
    vUv2 = uv2;
    vec4 worldPos = modelMatrix * vec4(p0, 1.0);
    vV = worldPos.xyz - cameraPosition;
    vNormal = normalMatrix * normal;
    vWorldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * normal;
}

void setupPBR(vec3 p0, vec3 n) {
    vUv = uv * uTiling + uOffset;
    vUv2 = uv2;
    vec4 worldPos = modelMatrix * vec4(p0, 1.0);
    vV = worldPos.xyz - cameraPosition;
    vNormal = normalMatrix * n;
    vWorldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * n;
}
{@}perlin3d.glsl{@}//
// GLSL textureless classic 3D noise "cnoise",
// with an RSL-style periodic variant "pnoise".
// Author:  Stefan Gustavson (stefan.gustavson@liu.se)
// Version: 2011-10-11
//
// Many thanks to Ian McEwan of Ashima Arts for the
// ideas for permutation and gradient selection.
//
// Copyright (c) 2011 Stefan Gustavson. All rights reserved.
// Distributed under the MIT license. See LICENSE file.
// https://github.com/ashima/webgl-noise
//

vec3 mod289(vec3 x)
{
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x)
{
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x)
{
    return mod289(((x*34.0)+1.0)*x);
}

vec4 taylorInvSqrt(vec4 r)
{
    return 1.79284291400159 - 0.85373472095314 * r;
}

vec3 fade(vec3 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

// Classic Perlin noise
float cnoise(vec3 P)
{
    vec3 Pi0 = floor(P); // Integer part for indexing
    vec3 Pi1 = Pi0 + vec3(1.0); // Integer part + 1
    Pi0 = mod289(Pi0);
    Pi1 = mod289(Pi1);
    vec3 Pf0 = fract(P); // Fractional part for interpolation
    vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
    vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
    vec4 iy = vec4(Pi0.yy, Pi1.yy);
    vec4 iz0 = Pi0.zzzz;
    vec4 iz1 = Pi1.zzzz;
    
    vec4 ixy = permute(permute(ix) + iy);
    vec4 ixy0 = permute(ixy + iz0);
    vec4 ixy1 = permute(ixy + iz1);
    
    vec4 gx0 = ixy0 * (1.0 / 7.0);
    vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
    gx0 = fract(gx0);
    vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
    vec4 sz0 = step(gz0, vec4(0.0));
    gx0 -= sz0 * (step(0.0, gx0) - 0.5);
    gy0 -= sz0 * (step(0.0, gy0) - 0.5);
    
    vec4 gx1 = ixy1 * (1.0 / 7.0);
    vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
    gx1 = fract(gx1);
    vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
    vec4 sz1 = step(gz1, vec4(0.0));
    gx1 -= sz1 * (step(0.0, gx1) - 0.5);
    gy1 -= sz1 * (step(0.0, gy1) - 0.5);
    
    vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
    vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
    vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
    vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
    vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
    vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
    vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
    vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);
    
    vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
    g000 *= norm0.x;
    g010 *= norm0.y;
    g100 *= norm0.z;
    g110 *= norm0.w;
    vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
    g001 *= norm1.x;
    g011 *= norm1.y;
    g101 *= norm1.z;
    g111 *= norm1.w;
    
    float n000 = dot(g000, Pf0);
    float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
    float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
    float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
    float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
    float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
    float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
    float n111 = dot(g111, Pf1);
    
    vec3 fade_xyz = fade(Pf0);
    vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
    vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
    float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x);
    return 2.2 * n_xyz;
}

// Classic Perlin noise, periodic variant
float pnoise(vec3 P, vec3 rep)
{
    vec3 Pi0 = mod(floor(P), rep); // Integer part, modulo period
    vec3 Pi1 = mod(Pi0 + vec3(1.0), rep); // Integer part + 1, mod period
    Pi0 = mod289(Pi0);
    Pi1 = mod289(Pi1);
    vec3 Pf0 = fract(P); // Fractional part for interpolation
    vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
    vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
    vec4 iy = vec4(Pi0.yy, Pi1.yy);
    vec4 iz0 = Pi0.zzzz;
    vec4 iz1 = Pi1.zzzz;
    
    vec4 ixy = permute(permute(ix) + iy);
    vec4 ixy0 = permute(ixy + iz0);
    vec4 ixy1 = permute(ixy + iz1);
    
    vec4 gx0 = ixy0 * (1.0 / 7.0);
    vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
    gx0 = fract(gx0);
    vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
    vec4 sz0 = step(gz0, vec4(0.0));
    gx0 -= sz0 * (step(0.0, gx0) - 0.5);
    gy0 -= sz0 * (step(0.0, gy0) - 0.5);
    
    vec4 gx1 = ixy1 * (1.0 / 7.0);
    vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
    gx1 = fract(gx1);
    vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
    vec4 sz1 = step(gz1, vec4(0.0));
    gx1 -= sz1 * (step(0.0, gx1) - 0.5);
    gy1 -= sz1 * (step(0.0, gy1) - 0.5);
    
    vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
    vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
    vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
    vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
    vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
    vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
    vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
    vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);
    
    vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
    g000 *= norm0.x;
    g010 *= norm0.y;
    g100 *= norm0.z;
    g110 *= norm0.w;
    vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
    g001 *= norm1.x;
    g011 *= norm1.y;
    g101 *= norm1.z;
    g111 *= norm1.w;
    
    float n000 = dot(g000, Pf0);
    float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
    float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
    float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
    float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
    float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
    float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
    float n111 = dot(g111, Pf1);
    
    vec3 fade_xyz = fade(Pf0);
    vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
    vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
    float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x);
    return 2.2 * n_xyz;
}{@}radialblur.fs{@}vec3 radialBlur( sampler2D map, vec2 uv, float size, vec2 resolution, float quality ) {
    vec3 color = vec3(0.);

    const float pi2 = 3.141596 * 2.0;
    const float direction = 8.0;

    vec2 radius = size / resolution;
    float test = 1.0;

    for ( float d = 0.0; d < pi2 ; d += pi2 / direction ) {
        vec2 t = radius * vec2( cos(d), sin(d));
        for ( float i = 1.0; i <= 100.0; i += 1.0 ) {
            if (i >= quality) break;
            color += texture2D( map, uv + t * i / quality ).rgb ;
        }
    }

    return color / ( quality * direction);
}

vec3 radialBlur( sampler2D map, vec2 uv, float size, float quality ) {
    vec3 color = vec3(0.);

    const float pi2 = 3.141596 * 2.0;
    const float direction = 8.0;

    vec2 radius = size / vec2(1024.0);
    float test = 1.0;
    float samples = 0.0;

    for ( float d = 0.0; d < pi2 ; d += pi2 / direction ) {
        vec2 t = radius * vec2( cos(d), sin(d));
        for ( float i = 1.0; i <= 100.0; i += 1.0 ) {
            if (i >= quality) break;
            color += texture2D( map, uv + t * i / quality ).rgb ;
            samples += 1.0;
        }
    }

    return color / samples;
}
{@}range.glsl{@}

float range(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    vec3 sub = vec3(oldValue, newMax, oldMax) - vec3(oldMin, newMin, oldMin);
    return sub.x * sub.y / sub.z + newMin;
}

vec2 range(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    vec2 oldRange = oldMax - oldMin;
    vec2 newRange = newMax - newMin;
    vec2 val = oldValue - oldMin;
    return val * newRange / oldRange + newMin;
}

vec3 range(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    vec3 oldRange = oldMax - oldMin;
    vec3 newRange = newMax - newMin;
    vec3 val = oldValue - oldMin;
    return val * newRange / oldRange + newMin;
}

float crange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

vec2 crange(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

vec3 crange(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

float rangeTransition(float t, float x, float padding) {
    float transition = crange(t, 0.0, 1.0, -padding, 1.0 + padding);
    return crange(x, transition - padding, transition + padding, 1.0, 0.0);
}
{@}rgb2hsv.fs{@}vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}{@}rgbshift.fs{@}vec4 getRGB(sampler2D tDiffuse, vec2 uv, float angle, float amount) {
    vec2 offset = vec2(cos(angle), sin(angle)) * amount;
    vec4 r = texture2D(tDiffuse, uv + offset);
    vec4 g = texture2D(tDiffuse, uv);
    vec4 b = texture2D(tDiffuse, uv - offset);
    return vec4(r.r, g.g, b.b, g.a);
}{@}rotation.glsl{@}mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}


mat2 rotationMatrix(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat2(c, -s, s, c);
}{@}roundedBorder.glsl{@}float roundedBorder(float thickness, float radius, vec2 uv, vec2 resolution, out float inside) {
    // Get square-pixel coordinates in range -1.0 .. 1.0
    float multiplier = max(resolution.x, resolution.y);
    vec2 ratio = resolution / multiplier;
    vec2 squareUv = (2.0 * uv - 1.0) * ratio; // -1.0 .. 1.0

    float squareThickness = (thickness / multiplier);
    float squareRadius = 2.0 * (radius / multiplier);
    vec2 size = ratio - vec2(squareRadius + squareThickness);


    vec2 q = abs(squareUv) - size;
    float d = min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - squareRadius;
    float dist = abs(d);
    float delta = fwidth(dist);
    float border = 1.0 - smoothstep(-delta, delta, dist - squareThickness);

    delta = fwidth(d);
    float limit = squareThickness * 0.5;
    inside = 1.0 - smoothstep(-delta, delta, d - limit);

    return border;
}

float roundedBorder(float thickness, float radius, vec2 uv, vec2 resolution) {
    float inside;
    return roundedBorder(thickness, radius, uv, resolution, inside);
}
{@}simplenoise.glsl{@}float getNoise(vec2 uv, float time) {
    float x = uv.x * uv.y * time * 1000.0;
    x = mod(x, 13.0) * mod(x, 123.0);
    float dx = mod(x, 0.01);
    float amount = clamp(0.1 + dx * 100.0, 0.0, 1.0);
    return amount;
}

#test Device.mobile
float sinf(float x) {
    x*=0.159155;
    x-=floor(x);
    float xx=x*x;
    float y=-6.87897;
    y=y*xx+33.7755;
    y=y*xx-72.5257;
    y=y*xx+80.5874;
    y=y*xx-41.2408;
    y=y*xx+6.28077;
    return x*y;
}
#endtest

#test !Device.mobile
    #define sinf sin
#endtest

highp float getRandom(vec2 co) {
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy, vec2(a, b));
    highp float sn = mod(dt, 3.14);
    return fract(sin(sn) * c);
}

float cnoise(vec3 v) {
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += (sinf(v.x * 0.9 / s + t * 10.0) + sinf(v.x * 2.4 / s + t * 15.0) + sinf(v.x * -3.5 / s + t * 4.0) + sinf(v.x * -2.5 / s + t * 7.1)) * 0.3;
    noise += (sinf(v.y * -0.3 / s + t * 18.0) + sinf(v.y * 1.6 / s + t * 18.0) + sinf(v.y * 2.6 / s + t * 8.0) + sinf(v.y * -2.6 / s + t * 4.5)) * 0.3;
    return noise;
}

float cnoise(vec2 v) {
    float t = v.x * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += (sinf(v.x * 0.9 / s + t * 10.0) + sinf(v.x * 2.4 / s + t * 15.0) + sinf(v.x * -3.5 / s + t * 4.0) + sinf(v.x * -2.5 / s + t * 7.1)) * 0.3;
    noise += (sinf(v.y * -0.3 / s + t * 18.0) + sinf(v.y * 1.6 / s + t * 18.0) + sinf(v.y * 2.6 / s + t * 8.0) + sinf(v.y * -2.6 / s + t * 4.5)) * 0.3;
    return noise;
}

float fbm(vec3 x, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec3 shift = vec3(100);

    for (int i = 0; i < 10; ++i) {
        if (i >= octaves){ break; }

        v += a * cnoise(x);
        x = x * 2.0 + shift;
        a *= 0.5;
    }

    return v;
}

float fbm(vec2 x, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100);
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));

    for (int i = 0; i < 10; ++i) {
        if (i >= octaves){ break; }

        v += a * cnoise(x);
        x = rot * x * 2.0 + shift;
        a *= 0.5;
    }

    return v;
}
{@}skinning.glsl{@}attribute vec4 skinIndex;
attribute vec4 skinWeight;

uniform sampler2D boneTexture;
uniform float boneTextureSize;

mat4 getBoneMatrix(const in float i) {
    float j = i * 4.0;
    float x = mod(j, boneTextureSize);
    float y = floor(j / boneTextureSize);

    float dx = 1.0 / boneTextureSize;
    float dy = 1.0 / boneTextureSize;

    y = dy * (y + 0.5);

    vec4 v1 = texture2D(boneTexture, vec2(dx * (x + 0.5), y));
    vec4 v2 = texture2D(boneTexture, vec2(dx * (x + 1.5), y));
    vec4 v3 = texture2D(boneTexture, vec2(dx * (x + 2.5), y));
    vec4 v4 = texture2D(boneTexture, vec2(dx * (x + 3.5), y));

    return mat4(v1, v2, v3, v4);
}

void applySkin(inout vec3 pos, inout vec3 normal) {
    mat4 boneMatX = getBoneMatrix(skinIndex.x);
    mat4 boneMatY = getBoneMatrix(skinIndex.y);
    mat4 boneMatZ = getBoneMatrix(skinIndex.z);
    mat4 boneMatW = getBoneMatrix(skinIndex.w);

    mat4 skinMatrix = mat4(0.0);
    skinMatrix += skinWeight.x * boneMatX;
    skinMatrix += skinWeight.y * boneMatY;
    skinMatrix += skinWeight.z * boneMatZ;
    skinMatrix += skinWeight.w * boneMatW;
    normal = vec4(skinMatrix * vec4(normal, 0.0)).xyz;

    vec4 bindPos = vec4(pos, 1.0);
    vec4 transformed = vec4(0.0);
    
    transformed += boneMatX * bindPos * skinWeight.x;
    transformed += boneMatY * bindPos * skinWeight.y;
    transformed += boneMatZ * bindPos * skinWeight.z;
    transformed += boneMatW * bindPos * skinWeight.w;

    pos = transformed.xyz;
}

void applySkin(inout vec3 pos) {
    vec3 normal = vec3(0.0, 1.0, 0.0);
    applySkin(pos, normal);
}{@}transformUV.glsl{@}vec2 translateUV(vec2 uv, vec2 translate) {
    return uv - translate;
}

vec2 rotateUV(vec2 uv, float r, vec2 origin) {
    float c = cos(r);
    float s = sin(r);
    mat2 m = mat2(c, -s,
                  s, c);
    vec2 st = uv - origin;
    st = m * st;
    return st + origin;
}

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec2 st = uv - origin;
    st /= scale;
    return st + origin;
}

vec2 rotateUV(vec2 uv, float r) {
    return rotateUV(uv, r, vec2(0.5));
}

vec2 scaleUV(vec2 uv, vec2 scale) {
    return scaleUV(uv, scale, vec2(0.5));
}

vec2 skewUV(vec2 st, vec2 skew) {
    return st + st.gr * skew;
}

vec2 transformUV(vec2 uv, float a[9]) {

    // Array consists of the following
    // 0 translate.x
    // 1 translate.y
    // 2 skew.x
    // 3 skew.y
    // 4 rotate
    // 5 scale.x
    // 6 scale.y
    // 7 origin.x
    // 8 origin.y

    vec2 st = uv;

    //Translate
    st -= vec2(a[0], a[1]);

    //Skew
    st = st + st.gr * vec2(a[2], a[3]);

    //Rotate
    st = rotateUV(st, a[4], vec2(a[7], a[8]));

    //Scale
    st = scaleUV(st, vec2(a[5], a[6]), vec2(a[7], a[8]));

    return st;
}{@}tridither.glsl{@}//https://www.shadertoy.com/view/4djSRW
float hash12(vec2 p)
{
    vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 hash32(vec2 p)
{
    vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yxz+33.33);
    return fract((p3.xxy+p3.yzz)*p3.zyx);
}

vec4 hash42(vec2 p)
{
    vec4 p4 = fract(vec4(p.xyxy) * vec4(.1031, .1030, .0973, .1099));
    p4 += dot(p4, p4.wzxy+33.33);
    return fract((p4.xxyz+p4.yzzw)*p4.zywx);

}

float dither1(in float color, in vec2 coord, in float time) {
    float noiseA = hash12(coord + fract(time + 1781.0));
    float noiseB = hash12(coord + fract(time + 1130.0));
    return color + ((noiseA + (noiseB - 1.0)) / 255.0);
}

vec3 dither3(in vec3 color, in vec2 coord, in float time) {
    vec2 seed = coord;
    vec3 noiseA = hash32(seed + fract(time) * 1300.0);
    vec3 noiseB = hash32(seed.yx + fract(time) * 1854.0);
    return color + ((noiseA + (noiseB - 1.0)) / 255.0);
}

vec4 dither4(in vec4 color, in vec2 coord, in float time) {
    vec2 seed = coord;
    vec4 noiseA = hash42(seed + fract(time + 1015.0));
    vec4 noiseB = hash42(seed + fract(time + 1543.0));
    return color + ((noiseA + (noiseB - 1.0)) / 255.0);
}
{@}SceneComposite.fs{@}uniform sampler2D tFrom;
uniform sampler2D tTo;
uniform sampler2D tDither;
uniform sampler2D tTitle;
uniform float uTransition;
uniform float uIsMenu;
uniform vec2 uContrast;
uniform vec2 uMouse;
varying vec2 vUv;
uniform float uIntro;
uniform vec3 uIntroColor;
uniform float uRipple;
uniform float uMobile;
uniform float uCornerHover;
uniform float uWobble;
uniform float uFuzz;
uniform float uLoading;
uniform vec3 uEdgeColor;
uniform float uShowTitle;

#require(UnrealBloom.fs)
#require(contrast.glsl)
#require(simplenoise.glsl)
#require(transformUV.glsl)
#require(blendmodes.glsl)
#require(rgb2hsv.fs)
#require(rgbshift.fs)
#require(range.glsl)

void main() {
    float transition = uTransition;
    if (uIsMenu > 0.0 && uIsMenu < 2.0 && transition > 0.0) {
        // menu is opening, reverse the transition
        transition = 1.0 - transition;
    }


    vec2 squareUV = scaleUV(vUv, vec2(1.0, resolution.x/resolution.y));
    vec2 uv = vUv;
    uv = scaleUV(uv, vec2(1.0 + (1.0-uIntro) * 0.8));

    float titleFuzz = mix(resolution.x, 40.0, smoothstep(1.0, 0.02, uShowTitle));
    vec2 titleUV = round(vUv * titleFuzz) / titleFuzz;
    titleUV.x += sign(sin(titleUV.y * 20.0 + time * 1.0)) * 0.001;
    float title = texture2D(tTitle, titleUV).r;
    title = step(0.5, title);
    //title *= step(0.5-uShowTitle*0.5, abs(vUv.y-0.5));

    if (uShowTitle > 0.0) {
        float fuzz = mix(resolution.x, 50.0, title);
        vec2 fuzzUV = round(uv * fuzz) / fuzz;
        fuzzUV = scaleUV(fuzzUV, vec2(1.0 + title * 0.25));
        uv = mix(uv, fuzzUV, smoothstep(0.0, 0.1, uShowTitle));
    }

    vec2 mouseUV = scaleUV(uv, vec2(1.0, resolution.x/resolution.y));
    vec2 checkMouse = scaleUV(vec2(uMouse.x, 1.0-uMouse.y), vec2(1.0, resolution.x/resolution.y));
    float mouseDist = length(mouseUV-checkMouse);

    if (uFuzz < 1.0) {
        float fuzz = mix(40.0, resolution.x, smoothstep(0.0, 1.0, uFuzz));
        vec2 fuzzUV = round(uv * fuzz) / fuzz;
        fuzzUV = scaleUV(fuzzUV, vec2(1.05));
        uv = mix(uv, fuzzUV, smoothstep(1.0, 0.0, uFuzz));
    }

    if (uLoading > 0.0) {
        float loading = mix(60.0, resolution.x, smoothstep(0.1, 0.0, uLoading));
        vec2 loadingUV = round(uv * loading) / loading;
        loadingUV = scaleUV(loadingUV, vec2(1.0 - uLoading * 0.2));
        loadingUV = scaleUV(loadingUV, vec2(1.0 + sin(time + length(squareUV-0.5) * 4.0) * 0.2 * smoothstep(0.0, 1.0, uLoading)));
        loadingUV = rotateUV(loadingUV, -cos(time - length(squareUV-0.5) * 5.0 + 10.0) * smoothstep(0.1, 0.5, uLoading) * 1.5);
        uv = mix(uv, loadingUV, smoothstep(0.0, 1.0, uLoading));
    }

    if (uWobble < 1.0) {
        float wobble = sin(length(vUv-0.5) * 8.0 - uWobble * 14.0);
        wobble *= smoothstep(1.0, 0.0, uWobble) * smoothstep(mix(0.9, 1.5, uMobile), 0.0, length(squareUV-0.5)) * 0.5 * smoothstep(0.0, 0.1, uWobble);
        vec2 wobbleUV = scaleUV(uv, vec2(1.0 + wobble - smoothstep(0.5, 0.0, uWobble) * 0.2 * smoothstep(0.0, 0.2, uWobble)));
        wobbleUV = rotateUV(wobbleUV, - wobble * 2.0 * smoothstep(-0.5, 0.5, length(squareUV-0.5)));
        uv = mix(uv, wobbleUV, smoothstep(1.0, 0.0, uWobble));
    }

    float wave = 0.0;
    if (uRipple > 0.0) {
        wave = smoothstep(uRipple, uRipple+mix(0.0, 0.5, mouseDist), mouseDist);
        wave = smoothstep(0.5, 0.0, abs(wave-0.5)) * smoothstep(mix(0.25, 0.5, uMobile), 0.0, mouseDist);
        vec2 waveUV = scaleUV(uv, vec2(1.0 + wave * 0.5), checkMouse);
        uv = mix(uv, waveUV, smoothstep(0.2, 0.0, uRipple));
    }

    vec3 color;
    if (uIsMenu > 0.0) {
        // Pixel Transition
        float pixelTransition = smoothstep(0.2, 0.5, abs(transition-0.5));
        float pixelation = mix(50.0, resolution.x, pixelTransition);

        //pixelation = mix(pixelation, 20.0, wave);
        uv = round(uv * pixelation) / pixelation;
        uv = scaleUV(uv, vec2(1.0 + (1.0-pixelTransition) * 0.2));

        vec2 center = vec2(uMouse.x, 1.0-uMouse.y) * 2.0 - vec2(0.5,0.5);

        float trans = transition * mix(2.0, 2.0, uMobile); //trans = 0.3;
        vec2 dir = normalize(uv - center);
        float d = smoothstep(trans + 0.2, trans - 0.2, distance(squareUV, center));
        d *= smoothstep(0.0, 0.5, transition);

        vec2 menuuv = (uv - center) / (1. + d) + center;
        menuuv = scaleUV(menuuv, vec2(1.0 + smoothstep(0.0, 0.8, transition)*1.0));
       // menuuv = mix(menuuv, vUv, smoothstep(0.5, 0.2, abs(uTransition-0.5)));

        vec2 detailuv = (uv - vec2(0.5)) / (2. - d) + vec2(0.5);
        detailuv = scaleUV(detailuv, vec2(1.0 - (1.0-transition) * 0.5));
        //detailuv = mix(detailuv, vUv, smoothstep(0.5, 0.2, abs(uTransition-0.5)));

        vec3 menu;
        vec3 detail;
        if (uIsMenu > 1.0) {
            // closing menu
            menu = getRGB(tFrom, menuuv, radians(45.0), 0.0002).rgb;
            detail = getRGB(tTo, detailuv, radians(45.0), 0.0002).rgb;
        } else {
            // opening menu
            menu = getRGB(tTo, menuuv, radians(45.0), 0.0002).rgb;
            detail = getRGB(tFrom, detailuv, radians(45.0), 0.0002).rgb;
        }

        color = mix(menu, detail, d);//mix(d, transition, smoothstep(0.35, 0.5, abs(transition-0.5))));


    } else {
        float wipeTransition = 1.0-transition;
        float wipeOffset = mix(0.0, 0.5, smoothstep(0.5, 0.2, abs(wipeTransition-0.5)));
        wipeTransition = smoothstep(wipeTransition-wipeOffset, wipeTransition+wipeOffset, 1.0-uv.y);
        float wipeWave = smoothstep(0.5, 0.0, abs(wipeTransition-0.5));
        uv = scaleUV(uv, vec2(1.0 + wipeWave * 0.2));
        uv = rotateUV(uv, wipeWave * 0.2);

        //uv.y -= smoothstep(1.0, 0.0, abs(uv.x-0.5)) * smoothstep(0.5, 0.0, abs(transition-0.5)) * 0.2;

        vec2 fromUV = scaleUV(uv, vec2(1.0 + transition * 0.5), vec2(0.5, -0.5));
        vec3 from = getRGB(tFrom, fromUV, radians(45.0), 0.0002).rgb;
        vec2 toUV = scaleUV(uv, vec2(1.0 + (1.0-wipeTransition) * 0.5), vec2(0.5, 1.5));
        vec3 to = getRGB(tTo, toUV, radians(45.0), 0.0002).rgb;

        float dither = texture2D(tDither, squareUV*resolution.x*0.01).r;
        to = mix(to, uEdgeColor, smoothstep(1.0, 0.6, wipeTransition));

        color = mix(from, to, step(1.0-wipeTransition, dither));
        //color += pow(wipeWave, 2.0) * 0.5;
    }

    if (uShowTitle > 0.0) {
        vec3 inverted = vec3(1.0-color.r, 1.0-color.g, 1.0-color.b);
        inverted = mix(inverted, vec3(0.95), 0.7);
        inverted = mix(color*1.4, inverted, smoothstep(0.0, 0.1, uShowTitle));
        color = mix(color, inverted, title * smoothstep(0.0, 0.05, uShowTitle));
        color += title * smoothstep(0.0, 0.2, uShowTitle) * mix(0.2, 0.15, uShowTitle);
    }

    // Intro Open
    if (uIntro < 1.0) {
        vec2 noiseUV = rotateUV(squareUV, -length(squareUV-0.5) * 10.0);
        squareUV += cnoise(noiseUV * 2.0 + time * 0.5) * 0.1 * smoothstep(0.0, 0.4, length(squareUV-0.5));
        squareUV = rotateUV(squareUV, length(squareUV-0.5) * 50.0);
        color = mix(color, mix(uIntroColor, vec3(1.0), 0.3), step(uIntro * mix(1.2, 1.6, uMobile) * mix(0.2, 1.1, uIntro) * 1.5, length(squareUV-0.5)));
        color = mix(color, uIntroColor, step(uIntro * mix(1.2, 1.6, uMobile), length(squareUV-0.5)));
    }

    color += pow(wave, 10.0) * 0.2;
    color += smoothstep(0.5, 0.0, uWobble) * 0.2 * smoothstep(0.0, 0.12, uWobble);


    float edges = step(0.5, abs(uv.y-0.5));
    edges = max(edges, step(0.5, abs(uv.x-0.5)));
    color = mix(color, uEdgeColor, edges);


    gl_FragColor = vec4(color, 1.0);
}
{@}RoundedGLUIObject.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    vec4 color = texture2D(tMap, vUv);

    color.a *= uAlpha;
    color.rgb = vec3(1.0, 0.0, 0.0);

    gl_FragColor = color;
}
{@}SpiralShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform float uFlip;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)

void main() {
    vec3 color = vec3(uFlip);

    vec2 uv = rotateUV(vUv, length(vUv-0.5) * mix(10.0, 15.0, sin(time * 0.5)));

    uv.x -= time * 0.015 * mix(-1.0, 1.0, uFlip);

    float checkSize = 150.0;
    float fmodResult = mod(floor(checkSize * uv.x) + floor(checkSize * uv.y), 2.0);
    float checker = max(max(sign(fmodResult), 0.0), 1.0 - step(-0.0025, uv.y));

    float alpha = checker;
    
    gl_FragColor = vec4(color, alpha);
}{@}VideoShader.glsl{@}#!ATTRIBUTES
attribute vec4 random;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec4 vRandom;

#!SHADER: Vertex

void main() {
    vec3 pos = position;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vUv = vec2(1. - uv);
    vRandom = random;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment
#require(fog.fs)
#require(fresnel.glsl)
#require(transformUV.glsl)

void main() {
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);

    vec2 uv = scaleUV(vUv, vec2(1.0 + mix(0.0, 20.0, step(0.4, fresnel)), 1.0), vec2(0.0, 1.0));

    vec3 color = texture2D(tMap, uv).rgb;
    if (uv.x < 0.01 || uv.y < 0.01 || uv.x > 0.99 || uv.y > 0.99) color = vRandom.rgb;


    //color *= mix(0.8, 1.0, pow(fresnel, 1.0));
    color += fresnel * 0.6;
//    color = mixFog(color);
    gl_FragColor = vec4(color, 1.0);
}
{@}WackyShader.glsl{@}#!ATTRIBUTES
attribute vec3 vdata;

#!UNIFORMS
uniform vec3 uColor;
uniform float uRandom;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying float vRandom;

#!SHADER: Vertex

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vUv = uv;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    vRandom = 0.0;//fract(length(vWorldPos.xz) * 0.1);

    vec3 pos = position;
    pos.x += sin(vWorldPos.y * 1.0 - time * 3.0 + length(vWorldPos) * 0.2 + vdata.x * 20.0) * 1.5 * smoothstep(1.0, 10.0, vWorldPos.y);
    pos.z += cos(vWorldPos.y * 1.0 - time * 3.0 + length(vWorldPos) * 0.2 + vdata.x * 20.0) * 1.5 * smoothstep(1.0, 10.0, vWorldPos.y);
    pos.z += sin(vWorldPos.y * 0.5 + time * 2.0) * 0.2 * smoothstep(2.0, 10.0, vWorldPos.y);

    vPos = pos;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));

    vNormal = normalize(normalMatrix * normal);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(rgb2hsv.fs)

void main() {
    vec2 uv = vUv;
    vec3 color = uColor;

    color = rgb2hsv(color);
    color.x -= vRandom * 0.5;
    color.x -= sin(time * 0.2 - vWorldPos.y * 0.5 + uRandom * 20.0) * 0.2 + time * 0.01;
    //color.x += length(cameraPosition-vWorldPos) * 0.02;
    color.x = floor(color.x*10.0)/10.0;
    color.x += fract(color.x * 6.0);
    color.y *= 1.1;


    color = hsv2rgb(color);

    color *= mix(0.7, 1.0, smoothstep(0.0, 1.5, vWorldPos.y));
    color *= mix(1.2, 0.9, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    vec2 uvRepeat = fract(vWorldPos.xz * 15.0) - 0.5;
	float radius = smoothstep(5.0, 4.0, length(cameraPosition - vWorldPos));
	float circle = 1.0 - smoothstep(radius - radius*0.1, radius, length(uvRepeat));
	if (circle > 0.5) discard;

    gl_FragColor = vec4(color, 1.0);
}{@}WebcamTVShader.glsl{@}#!ATTRIBUTES
attribute vec4 random;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform vec3 uHand;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec4 vRandom;

#!SHADER: Vertex

void main() {
    vec3 pos = position;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vUv = uv;
    vRandom = random;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment
#require(fog.fs)
#require(fresnel.glsl)
#require(transformUV.glsl)
#require(blendmodes.glsl)
#require(simplenoise.glsl)
#require(rgb2hsv.fs)

void main() {
    float wave = 0.5 + sin(time * 2.0 + vUv.y * 15.0);

    vec2 handUV = vUv;
    handUV += cnoise(vUv*2.0 + uHand.xy * 1.0 + time * 0.5) * 0.05;
    float handCenter = length(scaleUV(handUV, vec2(1.0,1.0))-uHand.xy);

    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    
    vec2 uv = scaleUV(vUv, vec2(1.0 + mix(0.0, 20.0, step(0.4, fresnel)), 1.0), vec2(0.0, 1.0));
    uv.y += wave * mix(0.01, 0.0, uHand.z);
    // uv.y = 1.0-uv.y;

    float warpHand = smoothstep(0.2, -0.2, handCenter) * uHand.z;
    uv = scaleUV(uv, vec2(1.0 + warpHand * 0.1));
    //uv = rotateUV(uv, warpHand * 2.0);

    vec3 color = vRandom.rgb;
    if (vUv.x > 0.01 && vUv.y > 0.01 && vUv.x < 0.99 && vUv.y < 0.99) {
        color = texture2D(tMap, uv).rgb;

        color += smoothstep(0.2, 0.0, handCenter) * uHand.z * 0.55;
        //color *= mix(0.8, 1.0, pow(fresnel, 1.0));
        color += fresnel * 0.6;
        color = blendOverlay(color, vec3(getNoise(vUv,time)), wave * mix(0.5, 0.05, uHand.z));

        color = rgb2hsv(color);
        color.y *= uHand.z;
        color.z *= mix(0.8, 1.1, uHand.z);
        color = hsv2rgb(color);
    }

//    color = mixFog(color);
    gl_FragColor = vec4(color, 1.0);
}
{@}FresnelShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uStrength;
uniform float uBelow;
uniform vec3 uBelowColor;
uniform float uDiscard;
uniform sampler2D tSketch;
uniform float uSketchScale;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uShading;
uniform float uHover;
uniform float uTalking;
uniform float uPixellate;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vWorldPos;
varying vec3 vPos;

#!SHADER: Vertex
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif

void main() {
    vec3 pos = position;
    vec3 n = normal;
    vec3 prevPos = pos;
    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);

#ifdef NUM_LIGHTS
    setupLight(pos);
#endif

    gl_Position = projectionMatrix * modelViewPos;
    vUv = uv;
    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vPos = pos;
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(fresnel.glsl)
#require(blendmodes.glsl)
#require(simplenoise.glsl)
#require(rgbshift.fs)

void main() {

    vec2 uv = vUv;

    // if (uPixellate > 0.0) {
    //     float pixels = 1000.0;
    //     pixels *= 1.0 + sin(time * 0.02 + uv.y * 10.0) * 0.1;
    //     uv = round(uv * pixels) / pixels;
    // }

    vec3 color = getRGB(tMap, uv, radians(45.0), 0.0002).rgb;

    // quick and dirty fake IBL lighting, s/o blackle
    // https://www.shadertoy.com/view/ttGfz1
    color *= mix(0.8, 1.05, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    float fresnel = 1.0-getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(uStrength.x, uStrength.y, pow(fresnel, uStrength.z));

    if (uDiscard > 0.0) {
        vec3 cameraP = cameraPosition;
        cameraP.y -= 4.0;
        float dist = length(cameraP - vWorldPos);
        float edge = 10.0;
        if (dist < edge) discard;
    }

#ifdef NUM_LIGHTS
    setupLight();
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * 2.0 * uShading);
#endif

    //color *= 1.2;
    color = blendOverlay(color, texture2D(tSketch, vPos.zx*0.1*uSketchScale+vPos.zy*0.1*uSketchScale).rgb, 0.06);
    color += uHover * (1.0-fresnel) * 0.3;

    color = mix(color, vec3(1.0), (1.0-pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0)) * uTalking * (0.8 + sin(time * 10.0) * 0.2));

    vec2 uvRepeat = fract(vWorldPos.xz * 15.0) - 0.5;
	float radius = smoothstep(5.0, 4.0, length(cameraPosition - vWorldPos));
	float circle = 1.0 - smoothstep(radius - radius*0.1, radius, length(uvRepeat));
	if (circle > 0.5) discard;

    if (uBelow > 0.0) {
        vec3 belowColor = mix(color, uBelowColor, uBelow);
        belowColor += (1.0-step(0.1, abs(cnoise(vWorldPos * mix(0.2, 0.5, smoothstep(-20.0, 0.0, vWorldPos.y)) - time * 0.08)))) * 0.08 * smoothstep(-20.0, 0.0, vWorldPos.y);
        color = mix(belowColor, color, step(0.0, vWorldPos.y));
    }

    gl_FragColor = vec4(color, 1.0);
}
{@}PorterCharacterShader.glsl{@}#!ATTRIBUTES
attribute vec3 vdata;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uGrab;
uniform float uVisible;
uniform vec3 uColor;
uniform float uColorOverride;
uniform float uReset;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vWorldPos;
varying vec3 vPos;


#!SHADER: Vertex
#require(skinning.glsl)

void main() {
    vec3 pos = position;
    vec3 n = normal;
    vec3 prevPos = pos;
    applySkin(pos, n);

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vPos = pos;

    gl_Position = projectionMatrix * modelViewPos;
    vUv = uv;
    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment

#require(fresnel.glsl)
#require(range.glsl)

void main() {
    vec3 color = texture2D(tMap, vUv).rgb;

    color = mix(color, uColor, uColorOverride);

    float grab = smoothstep(0.0 - vPos.z * 0.2, 0.5 - vPos.z * 0.2, uGrab - 0.1);
    color = mix(color, uColor, grab);
    color += smoothstep(0.5, 0.0, abs(grab-0.5)) * 0.1;

    float reset = smoothstep(0.0 - vPos.y * 0.1, 0.5 - vPos.y * 0.1, uReset - 0.1);
    color = mix(color, vec3(0.95), reset);

    //color *= mix(0.5, 1.0, step(0.0, vWorldPos.y));

    // quick and dirty fake IBL lighting, s/o blackle
    // https://www.shadertoy.com/view/ttGfz1
    color *= mix(0.6, 1.15, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color += pow(fresnel, mix(2.0, 1.5, uGrab)) * (0.25 + uGrab * 0.1);

    color += smoothstep(1.0, 0.5, uVisible) * 0.5;
    if (vPos.y > uVisible) discard;

    gl_FragColor = vec4(color, 1.0);
}
{@}PorterHeadShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;

#!SHADER: Vertex
#require(simplenoise.glsl)

void main() {
    vUv = uv;

    vec3 pos = position;
    pos *= 1.0 + cnoise(pos+time*0.1) * 0.06;
    vPos = pos;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(fresnel.glsl)

void main() {
    vec2 uv = vUv;
    vec4 color = texture2D(tMap, uv);
    
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color.rgb *= mix(0.8, 1.1, 1.0-fresnel);
    //color.rgb += pow(fresnel, 2.0) * 0.2;

    gl_FragColor = color;
    gl_FragColor.a *= uAlpha;
}{@}TestButtonShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor1; //js new Color()
uniform vec3 uColor2; //js new Color()
uniform float uAlpha; //js 1
uniform float uActive; //js 0

#!VARYINGS

#!SHADER: Vertex
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(mix(uColor1, uColor2, uActive), uAlpha);
}
{@}MenuBGShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor; //js new Color('#ffffff');
uniform sampler2D tFluid;
uniform sampler2D tFluidMask;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(transformUV.glsl)

void main() {
    vec2 uv = vUv;
    vec3 color = vec3(0.9);

    // vec2 screenUV = gl_FragCoord.xy / resolution.xy;
    // screenUV = scaleUV(screenUV, vec2(1.0, resolution.x/resolution.y));
    // float fuzz = 40.0;
    // screenUV = round(screenUV * fuzz) / fuzz;
    // vec2 fluid = texture2D(tFluid, screenUV).xy;
    // float fluidPush = smoothstep(0.0, 2.0, abs(fluid.x)*0.01 + abs(fluid.y)*0.01);
    // color += fluidPush * 0.05;
    
    gl_FragColor = vec4(color, 1.0);
}{@}MenuComposite.fs{@}uniform sampler2D tDiffuse;
varying vec2 vUv;
uniform float uScroll;
uniform float uScrollDelta;

#require(UnrealBloom.fs)
#require(contrast.glsl)
#require(simplenoise.glsl)
#require(transformUV.glsl)
#require(blendmodes.glsl)
#require(rgb2hsv.fs)

void main() {
    vec2 baseUV = gl_FragCoord.xy / resolution;
    vec2 squareUV = scaleUV(baseUV, vec2(1.0, resolution.x/resolution.y));
    vec2 uv = baseUV;
    uv.y -= smoothstep(0.0, 2.0, abs(uv.x-0.5)) * uScrollDelta * 0.05;

    vec3 color = texture2D(tDiffuse, uv).rgb;

    gl_FragColor = vec4(color, 1.0);
}
{@}MenuHomeShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tScene;
uniform float uAlpha;
uniform float uHover;
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(rgb2hsv.fs)
#require(rgbshift.fs)

void main() {
    vec2 uv = scaleUV(vUv, vec2(1.05));
    uv = scaleUV(uv, vec2(1.0 + uHover * 0.02 + pow(sin(time + uv.y * 6.0) * 0.2, 3.0)));
    uv.x += sign(sin(-time * 1.0 + uv.y * 20.0)) * mix(0.01, 0.0, uHover) * step(0.5, sin(time * 2.0 + uv.y * 30.0));

    float fuzz = mix(60.0, resolution.x, uHover);
    uv = round(uv * fuzz) / fuzz;

    vec3 color = getRGB(tMap, scaleUV(uv, vec2(1.0, 1.12)), radians(45.0), 0.001 * (1.0 - uHover)).rgb;

    vec2 sceneUv = scaleUV(uv, vec2(resolution.x/resolution.y - 0.4, 1.0));
    if (resolution.y > resolution.x) {
         sceneUv = scaleUV(uv, vec2(1.0, resolution.y/resolution.x + 0.15));
    }

    vec3 scene = getRGB(tScene, sceneUv, radians(45.0), 0.001 * (1.0 - uHover)).rgb;

    if (length(scene) > 0.1) color = scene;

    color = rgb2hsv(color);
    color.y *= mix(0.9, 1.0, uHover);
    color.z *= mix(0.8, 1.0, smoothstep(1.0, 0.0, length(uv-0.5)));
    color = hsv2rgb(color);

    //color = blendOverlay(color, vec3(getNoise(uv, time)), 0.3 * (1.0 - uHover));
    
    gl_FragColor = vec4(color, uAlpha);
}{@}MenuSceneShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tSprite;
uniform sampler2D tIcon;
uniform vec3 uColor;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;
uniform vec2 uMouse;
uniform vec2 uSpriteMove;
uniform float uRandom;
uniform float uHover;
uniform vec2 uRipple;
uniform float uActive;
uniform float uUseSprite;
uniform float uFinal;
uniform float uLink;
uniform float uIndex;
uniform float uPhone;
uniform float uTouch;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vWarpPos;
varying float vShading;

#!SHADER: Vertex

#require(curl.glsl)

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));

    vec3 pNoise = curlNoise(vWorldPos * mix(0.3, 0.4, uPhone) + time * 0.04 + vec3(uMouse, 0.) * 1.4 + cameraPosition.y * 0.1);
    vec3 warpPos = position + 0.11 * pNoise * mix(1.0, 0.8, uPhone);// * smoothstep(2.0, 0.0, uHover);
    vec2 mouse = vec2((1.0-uMouse.x-0.5) * 3.0, (1.0 - uMouse.y) * 5.0 - 2.5);
    vec2 checkPos = vec2(vWorldPos.x * -1.0, vWorldPos.y);
    warpPos.z += smoothstep(2.5, 0.5, length(checkPos-cameraPosition.xy-mouse)) * 2.2 * uTouch;
    warpPos.z -= 1.8;
    warpPos.z += (0.5 + sin(time * 0.5 + uRipple.x * 10.0 + length(checkPos-cameraPosition.xy-mouse) * 2.0)) * smoothstep(1.5, 0.0, uRipple.x) * 1.0 * uTouch;

    vec3 vWarpPos = warpPos;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(warpPos, 1.0);
}

#!SHADER: Fragment

#require(blendmodes.glsl)
#require(range.glsl)
#require(simplenoise.glsl)
#require(transformUV.glsl)
#require(rgb2hsv.fs)

float stepped(in float s, in float scale, in int steps) {
    return steps > 0 ? floor( s / ((1.0*scale) / float(steps))) * 1.0 / float(steps-1) : s;
}

void main() {
    vec2 uv = vUv;
    vec3 color = uColor;//texture2D(tPalette, uv).rgb;

    //if (uActive > 0.0) color += uHover * 0.1;
    color = mix(vec3(mix(0.7 + uRandom * (0.5 + sin(time * 0.5 + uIndex) * 0.5) * 0.12, 0.2, uFinal)), color, uActive);

    uv += cnoise(vWorldPos*0.5+time*0.2+uHover*0.2+length(uv-0.5) * 3.0) * smoothstep(0.5, 0.2, abs(uHover-0.5)) * 0.025;
    vec3 ui = texture2D(tMap, scaleUV(uv, vec2(1.0 + uHover*0.1))).rgb;

    color = blendSoftLight(color, ui, 1.0 * ui.r);
    color = blendOverlay(color, ui, 0.3 * ui.r);

    // Animated Sprite
    if (uActive > 0.0) {
        vec2 spriteUV = scaleUV(scaleUV(vUv, vec2(1.5 - uHover*0.2)), vec2(4.0, 8.0), uSpriteMove);
        vec4 sprite = texture2D(tSprite, spriteUV);
        sprite.rgb = mix(uColor, sprite.rgb, mix(0.25, 1.0, uHover));
        color = mix(color, sprite.rgb, sprite.a * uUseSprite);
        color = blendAdd(color, ui, uUseSprite * ui.r * 0.7);
    }

    color = blendAdd(color, ui, mix(mix(0.0, 0.5, uLink), 1.0, uHover * uActive) * ui.r);

    // Border
    float offset = mix(1.0, 0.92, uHover);
    offset -= 0.04 * uFinal;
    if (uIndex == 0.0 && uLink == 0.0) offset -= 0.04;
    float border = step(offset, uv.x) + step(offset, 1.0-uv.x) + step(offset, uv.y) + step(offset, 1.0-uv.y);
    border = min(1.0, border);
    color = mix(color, mix(vec3(1.0), uColor, uUseSprite), border);

    if (uLink == 0.0) {
        vec2 iconUV = uv;
        iconUV.x += sin(time * 1.2 + step(1.0, mod(uv.y, 0.05) * 40.0) + length(vWorldPos)*1.0) * 0.04;
        iconUV.x -= sin(time * 1.5 + step(0.5, mod(uv.y, 0.2) * 10.0) + length(vWorldPos)*1.0) * 0.04;

        vec3 icon = texture2D(tIcon, scaleUV(mix(iconUV, uv, uHover), vec2(0.8))).rgb;
        color -= icon.r * mix(mix(0.15, 0.4, uHover), 0.0, ui.r) * uActive;

        float scan = fract(-time * 0.8 - uv.y * 2.8);
        color += scan * icon.r * uHover * 1.0;
    }

    if (uIndex == 0.0 && uLink == 0.0) {
        vec2 angleUV = vUv;
        float angle = radians(360.0);
        float a = atan(angleUV.y - 0.5, angleUV.x - 0.5);
        float s = mod(a-angle + time, angle) / angle;
        //s = stepped(s, 1.0, 0.0);
        vec3 trioGradient = mix(uColor1, uColor2, step(0.33, s));
        trioGradient = mix(trioGradient, uColor3, step(0.66, s));
        color = mix(color, trioGradient, border);
    }

    // Rainbow Color
    if (uFinal > 0.0) {
        vec3 rainbow = vec3(1.0, 0.6, 0.6);
        rainbow = rgb2hsv(rainbow);
        rainbow.x += time * 0.02 - uv.y * 0.8 + uHover * 0.1 + sin(uv.x*5.0-time*3.0) * 0.03;
        rainbow.x = floor(rainbow.x*6.0)/6.0;
        rainbow.x += fract(rainbow.x * 4.0) * uHover;
        rainbow = hsv2rgb(rainbow);
        color = uColor;
        color = mix(color, rainbow, ui.r + border);
    }

    
    gl_FragColor = vec4(color, 1.0);
}{@}MenuButtonIconShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap; //js { value: null }
uniform sampler2D tMap2; //js { value: null }
uniform float uSwitch; //js { value: 0 }
uniform float uHover; //js { value: 0 }

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(simplenoise.glsl)
#require(transformUV.glsl)

void main() {
    vec2 uv = vUv;
    float pixelation = mix(256.0, 6.0, smoothstep(0.0, 1.0, uHover));
    uv = round(uv * pixelation) / pixelation;

    // uv += cnoise(uv * 2.0 + length(uv-0.5) * 2.0 + time * 0.1 + uHover * 1.0) * smoothstep(0.5, 0.0, abs(uHover-0.5)) * 0.1;
    uv = scaleUV(uv, vec2(1.0 + smoothstep(0.0, 1.0, uHover) * 0.05));

    vec4 color = texture2D(tMap, uv);
    vec4 color2 = texture2D(tMap2, uv);
    color = mix(color, color2, smoothstep(0.45, 0.55, 1.0-uSwitch));

    color.rgb = vec3(1.0);


    gl_FragColor = color;
}{@}MenuButtonShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor; //js { value: new Color() }
uniform float uHover; //js { value: 0 }

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    vNormal = normalize(normalMatrix * normal);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(rgb2hsv.fs)

void main() {
    vec2 uv = vUv;
    vec3 color = uColor;

    vec3 rainbow = rgb2hsv(uColor);
    rainbow.x += sin(uv.x * 2.0 - time * 0.2 + uHover * 1.0) * 0.32;
    rainbow.x += cos(uv.y * 5.0 - time * 1.0) * 0.01;
    rainbow.x = floor(rainbow.x*4.0)/4.0;
    rainbow.y *= 1.5;
    rainbow = hsv2rgb(rainbow);
    color = mix(color, rainbow * 1.2, uHover * 0.1);

    color *= mix(1.1, 0.9, smoothstep(0.7, 0.0, length(uv-0.5)));
    //color += sin(uv.x * 2.0 - time * 2.5) * 0.05;
    color *= mix(0.8, 1.2, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));
    
    gl_FragColor = vec4(color, 1.0);
}{@}MenuButtonUIShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tScene;
uniform float uAlpha;
uniform float uHover;
uniform float uTimeV;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(rgb2hsv.fs)
#require(transformUV.glsl)
#require(simplenoise.glsl)

void main() {
    vec2 uv = vUv;
    
    vec3 color = texture2D(tScene, uv).rgb;
    float alpha = step(0.7, length(color));
    vec4 tex = vec4(color, alpha);

    vec2 swirlUV = uv;
    swirlUV += cnoise(swirlUV * 1.0 - vec2(0.5) + uTimeV * 0.25 + uHover * 0.5 - length(swirlUV-0.5) * 3.0);
    swirlUV = rotateUV(swirlUV, uTimeV * 0.2 + uHover * 2.0);

    float swirler = 1.0-step(smoothstep(0.45, 0.25, length(uv-0.5))*uHover, length(swirlUV-0.5));
    swirler = step(0.6, swirler);
    vec4 swirl = vec4(vec3(1.0), swirler);

    tex = mix(swirl, tex, tex.a);

    tex.a *= uAlpha;

    gl_FragColor = tex;
}{@}ResetMessageShader.glsl{@}#!ATTRIBUTES
attribute vec3 animation;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uLetterCount;
uniform float uTransition;
uniform float uTransitionDirection;

#!VARYINGS
varying vec2 vUv;
varying float vTransition;

#!SHADER: Vertex
#require(range.glsl)
void main() {
    vUv = uv;
    vTransition = 1.0;
    if (uTransition < 1.0) {
        float letter = (animation.x + 1.0) / uLetterCount;
        vTransition = rangeTransition(uTransition, 1.0 - letter, 0.05);
    }

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(msdf.glsl)
#require(range.glsl)
#require(eases.glsl)
void main() {
    float alpha = msdf(tMap, vUv);

    float fade = crange(uTransition, 0.0, mix(0.5, 0.3, uTransitionDirection), 0.0, 1.0);
    if (uTransitionDirection > 0.0) {
        fade = cubicOut(fade);
    } else {
        fade = cubicIn(fade);
    }
    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha * fade * vTransition;
}
{@}AspectWebcamShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAspect;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(transformUV.glsl)

void main() {
    vec2 suv = vUv;
    vec2 asp = vec2(1.);
    if (uAspect > 1.777) asp.x = uAspect / 1.7777;
    else asp.y = 1.7777 / uAspect;
    suv = scaleUV(suv, asp);

    vec3 color = texture2D(tMap, suv).rgb;
    gl_FragColor = vec4(color, 1.0);
}{@}CheerleaderShader.glsl{@}#!ATTRIBUTES
attribute vec3 open_p;
attribute vec3 open_n;

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tVideo;
uniform float uAlpha;
uniform float uMouthOpen;
uniform vec3 uColor;
uniform vec3 uColor2;
uniform float uDelta;
uniform float uMixVideo;
uniform float uEaten;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vPos;

#!SHADER: Vertex
#require(simplenoise.glsl)

void main() {
    vec3 pos = position;
    vec3 n = normal;
    vUv = uv;

    pos = mix(pos, open_p, uMouthOpen);
    vPos = pos;

    pos += cnoise(pos * 2.0 + time * 0.3 + uDelta * 0.05) * smoothstep(-0.08, -0.7, pos.y) * 0.2;
    n = mix(n, open_n, uMouthOpen);

    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(fresnel.glsl)
#require(range.glsl)

void main() {
    vec3 color = texture2D(tMap, vUv).rgb;

    vec2 faceUV = mod(
        vec2(abs(vPos.x)*6.0, abs(vPos.y)*6.0),
        vec2(1.)
    );
    vec3 video = texture2D(tVideo, faceUV).rgb;

    float mixVideo = 0.0;
    if (uEaten > 1.0) {
        mixVideo = uMixVideo * step(crange(uEaten, 1.0, 5.0, 0.1, 0.02), 1.0-length(color-vec3(1.0, 0.0, 0.0)));
        color = mix(color, video + color * 0.1, mixVideo);
    }

//    vec3 color = uColor;
    vec3 normal = vNormal;
    vec3 viewDir = normalize(vViewDir);

    float fresnel = 1.0 - getFresnel(normal, viewDir, 1.0);

//    color = mix(uColor2, color, pow(fresnel, 1.0));
    color *= mix(0.92, 1.05, pow(fresnel, 2.0));
    color += pow(fresnel, 5.0) * 0.04;

    color = mix(color, color * mix(0.5, 1.5, fresnel), mixVideo);

    gl_FragColor = vec4(color, uAlpha);
}
{@}BuildingButtonShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uStrength;
uniform float uBelow;
uniform float uDiscard;
uniform sampler2D tSketch;
uniform float uSketchScale;
uniform float uHover;
uniform vec3 uHoverColor;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vWorldPos;
varying vec3 vPos;

#!SHADER: Vertex

void main() {
    vec3 pos = position;
    vec3 n = normal;
    vec3 prevPos = pos;
    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);

    gl_Position = projectionMatrix * modelViewPos;
    vUv = uv;
    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vPos = pos;
}

#!SHADER: Fragment
#require(fresnel.glsl)
#require(blendmodes.glsl)
#require(rgb2hsv.fs)

void main() {
    vec3 color = texture2D(tMap, vUv).rgb;
    color *= mix(uBelow, 1.0, step(0.0, vWorldPos.y));

    vec3 hoverColor = mix(color*2.0, uHoverColor, 0.1);
    hoverColor = rgb2hsv(hoverColor);
    hoverColor.x += vPos.y * 0.1 - time * 0.8;
    hoverColor.x = floor(hoverColor.x*5.0)/5.0;
    hoverColor = hsv2rgb(hoverColor);


    color = mix(color, hoverColor, uHover * 0.5 * smoothstep(0.0, 5.0, vPos.y));

    // quick and dirty fake IBL lighting, s/o blackle
    // https://www.shadertoy.com/view/ttGfz1
    color *= mix(0.6, 1.25, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    float fresnel = 1.0-getFresnel(vNormal, vViewDir, 1.0);
    //color *= mix(uStrength.x, uStrength.y, pow(fresnel, uStrength.z));

    
    //color *= 1.2;
    color = blendOverlay(color, texture2D(tSketch, vPos.zx*0.1*uSketchScale+vPos.zy*0.1*uSketchScale).rgb, 0.05);

    gl_FragColor = vec4(color, 1.0);
}
{@}BuildingShaderPBR.glsl{@}#!ATTRIBUTES
#ifdef INSTANCED
attribute vec4 random;
#endif

#!UNIFORMS
uniform sampler2D tPalette;
uniform vec2 uPaletteSize;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uUseTexture;

#!VARYINGS
varying vec3 vColor;

#!SHADER: Vertex
#require(lighting.vs)
#require(pbr.vs)

float rand(float n){return fract(sin(n) * 43758.5453123);}

void main() {
    vec3 pos = position;
    setupLight(pos);
    vUv = uv;
#ifdef INSTANCED
    int offset = int(rand(round(random.z) / uPaletteSize.x) * uPaletteSize.x);
    vColor = texelFetch(tPalette, ivec2(offset % int(uPaletteSize.x), 0), 0).rgb;
#else
    vColor = vec3(0.98, 0.98, 0.95);
#endif
    vec3 transformedNormal = normal;
    if (uUseTexture > 0.0) {
        setupPBR(pos, transformedNormal);
    }

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(pbr.fs)
#require(lighting.fs)
#require(shadows.fs)
#require(fog.fs)

void main() {
    setupLight();

    vec3 color = vColor;
    if (uUseTexture > 0.0) {
        vec4 pbr = getPBR();
        color = linearToSRGB(pbr).rgb;
    }
    color = color * mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);

//    color = mixFog(color);

    gl_FragColor = vec4(color, 1.0);
}
{@}ColoredItemShader.glsl{@}#!ATTRIBUTES
attribute float transition;
attribute vec4 random;

#!UNIFORMS
uniform vec3 uColor;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uShadowStrength2;
uniform float uLightStrength2;
uniform float uUseColor;
uniform float uShading;
uniform vec2 uContrast;
uniform float uBelow;
uniform vec3 uBelowColor;
uniform sampler2D tSketch;
uniform vec4 uSketch;
uniform float uDiscard;
uniform vec3 uFresnelColor;
uniform float uFresnelStrength;
uniform float uHueShift;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec4 vRandom;
varying float vDistance;

#!SHADER: Vertex
#require(instance.vs)
#require(eases.glsl)
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif

void main() {
#ifdef INSTANCED
    vec3 scaled = scale;
#ifdef BATCH_TRANSITION
    scaled *= cubicOut(transition);
#endif
    vec3 pos = transformPosition(position, offset, scaled, orientation);
#else
    vec3 pos = position;
#endif
#ifdef NUM_LIGHTS
    setupLight(pos);
#else
#endif
    vUv = uv;
    vRandom = random;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vDistance = length(cameraPosition-vWorldPos);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(fog.fs)
#require(fresnel.glsl)
#require(contrast.glsl)
#require(blendmodes.glsl)
#require(simplenoise.glsl)
#require(rgb2hsv.fs)

void main() {
    vec3 color = uColor;

    if (length(vRandom.rgb) > 0.0001) color = mix(vRandom.rgb, uColor, uUseColor);

    color = rgb2hsv(color);
    color.x += uHueShift;
    color = hsv2rgb(color);


#ifdef NUM_LIGHTS
    setupLight();
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength * uLightStrength2);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * uShadowStrength2);
#endif
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(1.0-0.1*uShading, 1.0+uShading*0.1, fresnel);
    color = adjustContrast(color, uContrast.x, uContrast.y);

    color *= mix(0.8, 1.0, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));
    color = blendOverlay(color, texture2D(tSketch, vPos.zx*0.1*uSketch.x+vPos.zy*0.1*uSketch.y+vPos.yx*0.1*uSketch.z).rgb, 0.04*uSketch.w);

    color = mix(color, uFresnelColor, smoothstep(0.5, 0.0, abs(pow(fresnel, 3.0)-0.5)) * uFresnelStrength * 0.25);

    if (uDiscard > 0.0) {
        vec2 uvRepeat = fract(vWorldPos.xz * 15.0) - 0.5;
	    float radius = smoothstep(5.0, 4.0, length(cameraPosition - vWorldPos));
	    float circle = 1.0 - smoothstep(radius - radius*0.1, radius, length(uvRepeat));
	    if (circle > 0.5) discard;
    }
    
    if (uBelow > 0.0) {
        vec3 belowColor = mix(color, uBelowColor, uBelow);
        belowColor += (1.0-step(0.1, abs(cnoise(vWorldPos * mix(0.2, 0.5, smoothstep(-20.0, 0.0, vWorldPos.y)) - time * 0.08)))) * 0.08 * smoothstep(-20.0, 0.0, vWorldPos.y);
        color = mix(belowColor, color, step(0.0, vWorldPos.y));
    }
    

    gl_FragColor = vec4(color, 1.0);
}
{@}GradientShader.glsl{@}#!ATTRIBUTES
#ifdef INSTANCED
attribute vec4 random;
#endif

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying float vGradient;

#!SHADER: Vertex
void main() {
    vec3 pos = position;
    vUv = uv;

#ifdef INSTANCED
    vec4 mpos = modelMatrix * vec4(pos, 1.);
    vGradient = (mpos.y / random.y) + random.x;
    vGradient /= 5.;
    vUv = random.zw;
#endif
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    vec3 color = texture2D(tMap, vUv).rgb;

    vec3 grad = mix(vec3(1.0, 0.5176, 0.5176), vec3(0.7451, 1.0, 0.9098), vGradient);
   //  color = mix(color, vec3(grad), 0.5);

    gl_FragColor = vec4(color, 1.0);
}{@}fog.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec2 uFog;
uniform vec3 uFogColor;

#!VARYINGS

#!SHADER: Vertex

#!SHADER: Fragment
#require(range.glsl)
#require(eases.glsl)

float getFog() {
    float fog = crange(length(cameraPosition - vWorldPos), uFog.x, uFog.x + uFog.y, 0.0, 1.0);
    return sineOut(fog);
}

vec3 mixFog(vec3 color) {
    float fog = getFog();
    return mix(color, uFogColor, fog);
}
{@}CityObjectShader.glsl{@}#!ATTRIBUTES
attribute vec4 random;

#!UNIFORMS
uniform sampler2D tPalette;
uniform vec2 uPaletteSize;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform vec2 uPaletteIndex;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uColorOverride;

#!VARYINGS
varying vec2 vUv;
varying vec3 vColor;
varying vec3 vNormal;
varying vec4 vRandom;
varying vec3 vWorldPos;

#!SHADER: Vertex
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif

float rand(float n){return fract(sin(n) * 43758.5453123);}

void main() {
    vec3 pos = position;
#ifdef NUM_LIGHTS
    setupLight(pos);
#endif
    vUv = uv;
#ifdef INSTANCED
    int offset = int(uPaletteIndex.x);
    if (offset >= 0) {
        if (random.z > 0.35) {
            offset = int(uPaletteIndex.y);
        }
    } else {
        offset = int(rand(round(random.z) / uPaletteSize.x) * uPaletteSize.x);
    }
    vColor = texelFetch(tPalette, ivec2(offset % int(uPaletteSize.x), 0), 0).rgb;
#else
    vColor = vec3(0.98, 0.98, 0.95);
#endif
    vRandom = random;
    vNormal = normal;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(rgb2hsv.fs)

void main() {
    vec3 color = vColor;

    vec3 mixColor = mix(uColor1, uColor2, step(0.35, vRandom.z));
    color = mix(color, mixColor, uColorOverride);

#ifdef NUM_LIGHTS
    setupLight();
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);
#endif
    color *= mix(0.8, 1.1, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

	float r = smoothstep(6.0, 4.0, length(cameraPosition - vWorldPos));
	float circle = 1.0 - smoothstep(r - r*0.1, r, length(fract(vWorldPos.xz * 15.0) - 0.5));
	if (circle > 0.5) discard;

    gl_FragColor = vec4(color, 1.0);
}
{@}FlatSkyShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor; //js new Color()

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vec3 pos = position;
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
    float far = gl_DepthRange.far;
    float near = gl_DepthRange.near;

    float depth = (((far - near) * 0.999) + near + far) * 0.5;
    gl_FragDepth = depth;

    gl_FragColor = vec4(uColor, 1.0);
}
{@}ColoredItemHolePlugShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uFresnelStrength;
uniform float uFresnelStrength2;

#!VARYINGS
varying vec2 vUv;
varying vec2 vGeomUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vGeomNormal;

#!SHADER: Vertex
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif
#require(FloorHoleShaderCommon.vs)

void main() {
    vec3 pos = position;
#ifdef NUM_LIGHTS
    setupLight(pos);
#else
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
#endif
    vUv = uv;
    vGeomUv = uv;
    vGeomNormal = normal;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#endif
#require(transformUV.glsl)
#require(range.glsl)
#require(rgb2hsv.fs)
#require(FloorHoleShaderCommon.fs)
#require(shadows.fs)

void main() {
#ifdef NUM_LIGHTS
    setupLight();
#endif

    vec3 color = uColor;
    color = getRevealedHolePlug(color, vUv, vec2(uFresnelStrength,uFresnelStrength2));

#ifdef NUM_LIGHTS
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);
#endif
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(0.9, 1.1, pow(fresnel, 1.5));

    gl_FragColor = vec4(color, 1.0);
}
{@}ColoredItemHoleShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uShadowStrength2;
uniform float uLightStrength2;
uniform float uShading;
uniform vec2 uContrast;
uniform vec3 uFresnelColor;
uniform float uFresnelStrength;
uniform float uBelow;
uniform vec3 uBelowColor;

#!VARYINGS
varying vec2 vUv;
varying vec2 vGeomUv;
varying vec3 vGeomNormal;

#!SHADER: Vertex
#require(lighting.vs)
#require(FloorHoleShaderCommon.vs)

void main() {
    vec3 pos = position;
    setupLight(pos);
    vUv = uv;
    vGeomUv = uv;
    vGeomNormal = normal;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(lighting.fs)
#require(transformUV.glsl)
#require(range.glsl)
#require(rgb2hsv.fs)
#require(FloorHoleShaderCommon.fs)
#require(shadows.fs)
#require(contrast.glsl)

void main() {
    setupLight();

    vec3 color = uColor;
    vec2 uv = vUv;
    uv = warpHoleUv(uv);

    if (uActivated > 0.0 && vPos.y <= -0.01) {
        color = getActivatedHoleSides(color);
    }
    color = getHoleSides(color);

    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength * uLightStrength2);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * uShadowStrength2);
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(1.0-0.1*uShading, 1.0+uShading*0.1, fresnel);
    color = adjustContrast(color, uContrast.x, uContrast.y);

    color *= mix(0.8, 1.0, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    color = mix(color, uFresnelColor, smoothstep(0.5, 0.0, abs(pow(fresnel, 3.0)-0.5)) * uFresnelStrength * 0.25);

    if (uBelow > 0.0) {
        vec3 belowColor = mix(color, uBelowColor, uBelow);
        belowColor += (1.0-step(0.1, abs(cnoise(vWorldPos * mix(0.2, 0.5, smoothstep(-20.0, 0.0, vWorldPos.y)) - time * 0.08)))) * 0.08 * smoothstep(-20.0, 0.0, vWorldPos.y);
        color = mix(belowColor, color, step(0.0, vWorldPos.y));
    }

    gl_FragColor = vec4(color, 1.0);
}
{@}FloorColorShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
#require(lighting.vs)
void main() {
    vec3 pos = position;
    setupLight(pos);
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(lighting.fs)
#require(shadows.fs)
#require(tridither.glsl)
#require(fog.fs)
#require(blendmodes.glsl)

void main() {
    setupLight();
    vec3 color = uColor;
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);

//    color = mixFog(color);
//    color = dither3(color, gl_FragCoord.xy, time);
    gl_FragColor = vec4(color, 1.0);
}
{@}FloorHolePlugShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec4 uHole;

#!VARYINGS
varying vec2 vGeomUv;
varying vec3 vGeomNormal;

#!SHADER: Vertex
#require(FloorShaderCommon.vs)
#require(FloorHoleShaderCommon.vs)

void floorVertex() {
    vUv = transformHoleUv(uHole, uv);
    vGeomUv = uv;
    vGeomNormal = normal;
}

#!SHADER: Fragment
#require(FloorShaderCommon.fs)
#require(FloorHoleShaderCommon.fs)

void main() {
    setupLight();

    vec2 uv = getScaledUv(vUv);

    float whichMap = getWhichTile(uv);
    vec3 color = getTiledColor(whichMap, uv);
    color = getRevealedHolePlug(color, uv);
    color = getLightAndShadow(color, uv);

    gl_FragColor = vec4(color, 1.0);
}
{@}FloorHoleShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec4 uHole;

#!VARYINGS
varying vec2 vGeomUv;
varying vec3 vGeomNormal;

#!SHADER: Vertex
#require(FloorShaderCommon.vs)
#require(FloorHoleShaderCommon.vs)

void floorVertex() {
    vUv = transformHoleUv(uHole, uv);
    vGeomUv = uv;
    vGeomNormal = normal;
}

#!SHADER: Fragment
#require(FloorShaderCommon.fs)
#require(FloorHoleShaderCommon.fs)

void main() {
    setupLight();

    vec2 uv = getScaledUv(vUv);
    uv = warpHoleUv(uv);

    float whichMap = getWhichTile(uv);
    vec3 color = getTiledColor(whichMap, uv);

    if (uActivated > 0.0 && vPos.y <= -0.01) {
        color = getActivatedHoleSides(color);
        color = getLightAndShadowWithoutGrid(color, uv);
    } else {
        color = getLightAndShadow(color, uv);
    }

    color = getHoleSides(color);

    if (vPos.y < -22.0) discard;

    gl_FragColor = vec4(color, 1.0);
}
{@}FloorHoleShaderCommon.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uRevealed;
uniform float uForceReveal;
uniform float uActivated;
uniform float uHover;
uniform vec3 uDestinationColor;
uniform sampler2D tDestinationMap;
uniform float uFinal;
uniform float uGlowStrength;
uniform sampler2D tIcon;
uniform float uHoleHeight;
uniform vec3 uHoleColor;

#!VARYINGS

#!SHADER: Vertex
#require(transformUV.glsl)

float getRotationFromMatrix(mat4 matrix) {
    if (abs(matrix[2][1]) < 0.9999) {
        return atan(matrix[2][0], matrix[2][2]);
    }
    return atan(-matrix[0][2], matrix[0][0]);
}

vec2 transformHoleUv(vec4 hole, vec2 uv) {
    uv = rotateUV(uv, -getRotationFromMatrix(modelMatrix));
    uv = (uv - 0.5) / hole.zw + 0.5 + hole.xy;
    return uv;
}

#!SHADER: Fragment
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(fresnel.glsl)

#ifndef PI
#define PI 3.141592653589793
#endif

#ifndef HALF_PI
#define HALF_PI 1.5707963267948966
#endif

vec3 getRainbowColor(vec3 color, vec2 uv, float uiMask) {
    if (uFinal > 0.0) {
        vec3 rainbow = vec3(1.0, 0.6, 0.6);
        rainbow = rgb2hsv(rainbow);
        rainbow.x += time * 0.07 + uv.y * 0.25 + uHover * 0.4 + sin(uv.x*5.0-time*2.0) * 0.05;
        rainbow.x = floor(rainbow.x*7.0)/7.0;
        rainbow = hsv2rgb(rainbow);
        color = mix(rainbow, color, uiMask);
    }
    return color;
}

vec2 warpHoleUv(vec2 uv) {
    vec2 aspect = vec2(2.0, 30.0) * 0.1;
    vec2 warpUV = vPos.yy * aspect * 0.05;

    warpUV.y += time * 0.1;
    warpUV.x += time * 0.005;
    uv = mix(warpUV, uv, step(-0.0125, vPos.y));
    return uv;
}

vec3 getActivatedHoleSides(vec3 color) {
    float angle = atan(vPos.z, vPos.x);
    vec2 tiledUv = vec2(
        vGeomUv.x * 1.5 - time * 0.1,
        vGeomUv.y * 1.5 * 3.48 + time * 0.1
    );
    float stagger = ceil(tiledUv.x);
    tiledUv.y += stagger * -0.1;
    tiledUv = mod(tiledUv, 1.0);
    tiledUv = scaleUV(tiledUv, vec2(1.6)); // reduce ui margin

    vec3 ui = texture2D(tDestinationMap, tiledUv).rgb;
    vec2 uv = vPos.xz * 0.04 + 0.5;
    vec3 dest = blendAdd(getRainbowColor(uDestinationColor, uv, ui.r), ui, 0.8 * ui.r);
    dest *= mix(1.0, 1.2, pow(uHover, 1.0));
    float upwards = rangeTransition(
        uActivated,
        crange(vPos.y, 0.0, -24.0, 0.9, 0.0) + (sin(angle * 12.0 + time * 5.0) + cos(angle * 18.5 + time * 7.0)) * 0.04,
        0.01
    );

    color = uDestinationColor;//mix(color, dest, upwards);

    vec3 normal = vNormal;
    vec3 viewDir = normalize(vViewDir);
    float fresnel = 1.0 - getFresnel(normal, viewDir, 1.0);
    color *= mix(0.8, 1.0, pow(fresnel, 2.0));

    return color;
}

float square2d(vec2 p, float size) {
    vec2 b = abs(p) - vec2(size);
    return length(max(b, 0.0)) + min(max(b.x, b.y), 0.0);
}

vec3 getHoleSides(vec3 color) {
    if (uRevealed > 0.0 && vPos.y > -0.01) {
        // darken an area around the edge
        float signedDist = square2d(vGeomUv - 0.5, 0.258);
        float d = fwidth(signedDist);
        float alpha = 1.0 - smoothstep(-d, d, signedDist);
        color *= mix(1.0, 0.92, alpha * uRevealed);
    }

    // darken in the depths of the hole
    //color *= smoothstep(-60., 0.0, vPos.y);
    //color *= mix(0.9, 1.0, step(-0.0125, vPos.y));
    color = mix(uHoleColor, color, smoothstep(-uHoleHeight, 0.0, vPos.y));

    return color;
}

vec3 getRevealedHolePlug(vec3 color, vec2 uv, vec2 fresnelStrength) {    
    if (uRevealed > 0.0 || uForceReveal > 0.0) {
        vec3 ui = texture2D(tDestinationMap, scaleUV(vGeomUv, vec2(1.5))).rgb;
        float uiApply = ui.r * vGeomNormal.y;
        vec3 dest = uDestinationColor;//blendAdd(uDestinationColor, ui, 0.8 * uiApply);

        if (uFinal > 0.0) {
            dest = getRainbowColor(dest, vGeomUv, uiApply);
        }
        dest *= mix(1.0, 1.1, uHover);    
        color = mix(color, dest, uRevealed);

        vec3 normal = vNormal;
        vec3 viewDir = normalize(vViewDir);
        float fresnel = 1.0 - getFresnel(normal, viewDir, 1.0);
        color *= mix(0.95, 1.05, pow(fresnel, 1.0) * fresnelStrength.x);
        color += pow(fresnel, 4.0) * 0.3 * fresnelStrength.y;
        
        vec2 iconUV =  scaleUV(vGeomUv, vec2(1.0, 1.0));
        vec3 icon = texture2D(tIcon, iconUV).rgb;
        
        color -= icon.r * mix(0.3, 0.6, uHover);
        float scan = fract(-time * 0.8 - iconUV.y * 2.8);
        color += scan * icon.r;
    }
    return color;
}

vec3 getRevealedHolePlug(vec3 color, vec2 uv) {
    return getRevealedHolePlug(color, uv, vec2(1.0));
}
{@}FloorImageShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uAlpha;
uniform float uInvert;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
#require(lighting.vs)
void main() {
    vec3 pos = position;
    setupLight(pos);
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(lighting.fs)
#require(shadows.fs)
#require(tridither.glsl)
#require(fog.fs)
#require(blendmodes.glsl)

void main() {
    setupLight();
    vec4 color = texture2D(tMap, vUv);
    color.rgb *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color.rgb *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * 2.0);


    color.rgb = mix(color.rgb, vec3(pow(1.0-color.r, 2.0)), uInvert);

    //color.rgb *= uColor;

    color.a *= uAlpha;

    if (color.a == 0.0) discard;

//    color = mixFog(color);
//    color = dither3(color, gl_FragCoord.xy, time);
    gl_FragColor = color;
}
{@}FloorShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: Vertex
#require(FloorShaderCommon.vs)

void floorVertex() {

}

#!SHADER: Fragment
#require(FloorShaderCommon.fs)

void main() {
    setupLight();

    vec2 uv = getScaledUv(vUv);

    float whichMap = getWhichTile(uv);
    vec3 color = getTiledColor(whichMap, uv);
    color = getLightAndShadow(color, uv);

    if (uDiscard > 0.0) {
        vec3 cameraP = cameraPosition;
        cameraP.y -= 4.0;
        float dist = length(cameraP - vWorldPos);
        float edge = 14.0;
        if (dist < edge) discard;
    }

    gl_FragColor = vec4(color, 1.0);
}
{@}FloorShaderCommon.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform vec4 uUVScale;
uniform vec2 uUVScale2;
uniform sampler2D tMap;
uniform sampler2D tMap2;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uScale;
uniform float uFloorShadow;
uniform float uTiled;
uniform float uGridStrength;
uniform float uGridScale;
uniform float uHueShift;
uniform float uBrightness;
uniform float uDiscard;
uniform vec3 uEdgeColor;
uniform float uEdgeStrength;
uniform vec2 uEdgeRange;
uniform float uPixellate;
uniform float uMouseFluid;

uniform sampler2D tFluid;
uniform sampler2D tFluidMask;


#!VARYINGS
varying vec2 vUv;
varying vec3 vWorldPos;

#!SHADER: Vertex
#require(lighting.vs)
#require(rotation.glsl)

void floorVertex();

void main() {
    vec3 pos = position;
    setupLight(pos);
    vUv = uv;

    vec4 worldPos = modelMatrix * vec4(position, 1.0);

    float radius = 500.0;
    float distToTangent = -900.0 + cameraPosition.z;

    float gradient = clamp((worldPos.z - distToTangent) / radius, 0.0, 1.0);
    float angle = gradient * 3.14159 * 0.5 - 3.14159 * 0.5;

    vec2 circlePos = vec2(radius * clamp(cos(angle), 0.0, 3.14159 * 0.5), radius * clamp(sin(angle), -3.14 * 0.5, 3.14 * 0.5));
    vec3 cylinderPos = vec3(worldPos.x, -circlePos.x, circlePos.y);
    vec2 dir = normalize(cylinderPos.yz) * worldPos.y;
    cylinderPos.yz -= dir.xy;
    cylinderPos.y += radius;
    cylinderPos.z += radius;

    worldPos.z -= distToTangent;
    float temp = worldPos.z;

    if (temp > 0.0 && temp < radius) {
        worldPos.xyz = cylinderPos;
    }

    if (temp <= 0.0) {
        worldPos.z = worldPos.y;
        worldPos.y = -temp * (3.14159 * 0.5) + radius;
    }

    worldPos.z += distToTangent;
    vWorldPos = worldPos.xyz;
    //gl_Position = projectionMatrix * viewMatrix * worldPos;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);

    floorVertex();
}

#!SHADER: Fragment
#require(lighting.fs)
#require(shadows.fs)
#require(tridither.glsl)
#require(fog.fs)
#require(transformUV.glsl)
#require(rgb2hsv.fs)

vec3 stroke(float dist, vec3 color, vec3 bg, float thickness, float aa) {
    float alpha = smoothstep(0.5 * (thickness + aa), 0.5 * (thickness - aa), abs(dist));
    return mix(bg, color, alpha);
}

vec3 renderGrid(vec2 pos) {
    vec3 axes = vec3(0.8);
    float subdiv = 22.;

    float thickness = 0.0003;
    float aa = length(fwidth(pos));

    vec2 toSubGrid = pos - round(pos*subdiv)/subdiv;
    vec3 color;
    color = stroke(min(abs(toSubGrid.x), abs(toSubGrid.y)), vec3(0.3), color, thickness, aa);

    subdiv *= 10.;
    vec2 toGrid = pos - round(pos*subdiv)/subdiv;
    color = stroke(min(abs(toGrid.x), abs(toGrid.y)), vec3(0.1), color, thickness, aa);

    return color;
}

vec2 getScaledUv(vec2 uv) {
    uv = (rotateUV(uv, uUVScale.w * 0.017453292519943295));
    uv -= vec2(0.5);
    uv *= uUVScale.z;
    uv += vec2(0.5);
    uv -= uUVScale.xy;
    uv *= uUVScale2;
    return uv;
}

vec3 getTiledColor(float whichMap, vec2 uv) {
    if (uMouseFluid > 0.0) {
        vec2 screenUV = gl_FragCoord.xy / resolution.xy;
        float fuzz = 60.0;
        screenUV = round(screenUV * fuzz) / fuzz;
        vec2 fluid = texture2D(tFluid, screenUV).xy;
        float fluidPush = smoothstep(0.0, 2.0, abs(fluid.x)*0.01 + abs(fluid.y)*0.01);
        vec2 fluidUV = uv + fluidPush * 0.1 * round(rotateUV(uv, radians(45.0)) * fuzz) / fuzz;
        uv = mix(uv, fluidUV, uMouseFluid);
    }
    
    if (uPixellate > 0.0) {
        float pixels = 140.0;
        vec2 pixeluv = round(vec2(uv.x, uv.y*(uUVScale2.y/uUVScale.x) * 1.5) * pixels) / pixels;
        uv = mix(uv, pixeluv, uPixellate);
    }
    
    vec3 color = texture2D(tMap, uv).rgb;
    vec3 color2 = texture2D(tMap2, uv).rgb;
    color = mix(color, color2, whichMap);
    color *= uColor;

    //color += fluidPush * 0.04 * uGridStrength;

    return color;
}

float getWhichTile(vec2 uv) {
    float checkSize = 1.0;
    float fmodResult = mod(floor(checkSize * uv.x) + floor(checkSize * uv.y), 2.0);
    return max(max(sign(fmodResult), 0.0), 1.0 - step(-0.0025, vPos.y));
}

vec3 getLightAndShadow(vec3 color, vec2 uv) {
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * uFloorShadow);

    vec3 grid = renderGrid(vUv*20.0*uGridScale);
    float drawGridX = pow(mod(sin(-time * 0.25 - vPos.x * 0.5), 1.0), 1.0);
    float drawGridY = pow(mod(sin(-time * 0.25 - vPos.z * 0.5), 1.0), 1.0);
    //grid *= mix(0.4, 1.0, drawGridX);
    color += grid * uGridStrength * 0.25 * (1.0-step(0.5, vPos.y));// * smoothstep(0.1, 0.05, vWorldPos.y);

    color = rgb2hsv(color);
    color.x += uHueShift;
    color = hsv2rgb(color);
    color *= uBrightness;

    color = mix(color, uEdgeColor, uEdgeStrength * smoothstep(uEdgeRange.x, uEdgeRange.y, length(vUv-0.5)));

    return color;
}

vec3 getLightAndShadowWithoutGrid(vec3 color, vec2 uv) {
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * uFloorShadow);
    return color;
}
{@}TerrainShader.glsl{@}#!ATTRIBUTES
attribute vec4 random;

#!UNIFORMS
uniform float uSoften;
uniform vec3 uLightDirection;

uniform sampler2D tMapBase;
uniform sampler2D tMapBaseNormal;
uniform float tMapBaseScale;

uniform sampler2D tMapPath;
uniform sampler2D tMapPathNormal;
uniform float tMapPathScale;

uniform sampler2D tMapMask1;
uniform sampler2D tMapMask1Normal;
uniform float tMapMask1Scale;

uniform sampler2D tMapMask2;
uniform sampler2D tMapMask2Normal;
uniform float tMapMask2Scale;

uniform sampler2D tMapMask3;
uniform sampler2D tMapMask3Normal;
uniform float tMapMask3Scale;

uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uShading;

uniform vec3 uGradient1;
uniform vec3 uGradient2;
uniform float uBelow;
uniform vec3 uBelowColor;
uniform sampler2D tSketch;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec3 vMPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec3 vViewDir;
varying vec4 vRandom;

#!SHADER: Vertex
#require(instance.vs)
#require(eases.glsl)
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif

void main() {
#ifdef INSTANCED
    vec3 pos = transformPosition(position, offset, scale, orientation);
#else
    vec3 pos = position;
#endif
#ifdef NUM_LIGHTS
    setupLight(pos);
#else
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
#endif
    vUv = uv;
    vRandom = random;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vWorldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * normal;
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
    vPos = pos;

    vec4 mPos = modelMatrix * vec4(pos, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(fog.fs)
#require(fresnel.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)

vec3 getColor( sampler2D tMap, sampler2D tNormal, float uvscale ) {
    vec2 tuv = mod(vWorldPos.xz / vec2(uvscale), vec2(1.)); // world space xz => uv
    // vec3 norm = unpackNormal(vEyePos, vWorldNormal, tNormal, 1.0, 1.0, tuv);
    vec3 norm = texture2D(tNormal, tuv).rgb;

    vec3 c = texture2D(tMap, tuv).rgb;
    vec3 lightDirection = normalize(vec3(0.15, 1.0, 0.5));
    float diffuse = max(dot(norm, lightDirection), 0.0);
    c *= crange(diffuse, 0., 1., 0.3, 1.);

    return c;
}

void main() {
    // set colors
    vec3 color = getColor(tMapBase, tMapBaseNormal, tMapBaseScale);
    color = mix(
        color,
        getColor(tMapPath, tMapPathNormal, tMapPathScale),
        smoothstep(1. - uSoften, 1., vRandom.x)
    );
    if (vRandom.y > vRandom.z && vRandom.y > vRandom.w) color = mix(
        color,
        getColor(tMapMask1, tMapMask1Normal, tMapMask1Scale),
        smoothstep(1. - uSoften, 1., vRandom.y)
    );
    if (vRandom.z > vRandom.y && vRandom.y > vRandom.w) color = mix(
        color,
        getColor(tMapMask2, tMapMask2Normal, tMapMask2Scale),
        smoothstep(1. - uSoften, 1., vRandom.z)
    );
    if (vRandom.w > vRandom.y && vRandom.y > vRandom.z) color = mix(
        color,
        getColor(tMapMask3, tMapMask3Normal, tMapMask3Scale),
        smoothstep(1. - uSoften, 1., vRandom.w)
    );


#ifdef NUM_LIGHTS
    setupLight();
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * 2.0);
#endif

    vec3 gradient = mix(uGradient1, uGradient2, smoothstep(0.0, -20.0, vWorldPos.y));
    color = mix(color, gradient, step(1.0, -vPos.y));
    color += step(0.0, sin(time * 2.0 + vWorldPos.y * 2.0)) * 0.02 * (1.0-smoothstep(0.0, -20.0, vWorldPos.y)) * step(0.0, -vWorldPos.y);


    // color = mixFog(color);
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    fresnel = mix(1.0-0.1, 1.0+0.1, pow(fresnel, 1.5));

    color = mix(color, color * fresnel, 1.0-smoothstep(0.0, -20.0, vWorldPos.y));

    //color *= mix(0.6, 1.0, smoothstep(-2.0, 3.5, vWorldPos.y));
    //color *= ;
    
    vec3 fakeLight = color * mix(0.7, 1.15, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));
    color = mix(color, fakeLight, 1.0-smoothstep(0.0, -20.0, vWorldPos.y));

    color *= 1.0 + cnoise(vWorldPos*0.05 - time * 0.15) * 0.04 * step(0.0, vPos.y);
    color = blendOverlay(color, texture2D(tSketch, vPos.zx*0.1+vPos.zy*0.1).rgb, 0.1);

    if (uBelow > 0.0) {
        vec3 belowColor = mix(color, uBelowColor, uBelow);
        belowColor += (1.0-step(0.1, abs(cnoise(vWorldPos * mix(0.2, 0.5, smoothstep(-20.0, 0.0, vWorldPos.y)) - time * 0.08)))) * 0.08 * smoothstep(-20.0, 0.0, vWorldPos.y);
        color = mix(belowColor, color, step(0.0, vWorldPos.y));
    }
    
    gl_FragColor = vec4(color, 1.0);
}
{@}AlbumAtlasShader.glsl{@}#!ATTRIBUTES
attribute vec4 random;

#!UNIFORMS
uniform sampler2D tMain;
uniform sampler2D tAtlas1;
uniform sampler2D tAtlas2;
uniform sampler2D tWebcam;
uniform float uAspect;
uniform float uGridSize;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uShading;
uniform vec2 uRatio;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec4 vRandom;

#!SHADER: Vertex
#require(instance.vs)
#require(eases.glsl)
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif

void main() {
#ifdef INSTANCED
    vec3 pos = transformPosition(position, offset, scale, orientation);
#else
    vec3 pos = position;
#endif
#ifdef NUM_LIGHTS
    setupLight(pos);
#else
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
#endif
    vUv = uv;
    vRandom = random;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(fog.fs)
#require(fresnel.glsl)
#require(transformUV.glsl)

void main() {
    vec3 color = vRandom.rgb;
    if (vUv.x > 0. && vUv.y > 0.) {
        vec2 suv = vUv;
        int index = int(round(vRandom.w));
        int gridsize = int(round(uGridSize));
        if (index != 0) {
            int y = ((index - 1) % (gridsize * gridsize)) / gridsize;
            int x = (index - 1) % gridsize;
            suv = scaleUV(vUv, vec2(uGridSize));
            suv = translateUV(suv, vec2(
                (-0.5 + 1. / uGridSize / 2.) + float(x) / uGridSize,
                (-0.5 + 1. / uGridSize / 2.) + float(y) / uGridSize
            ));
        }

        if (index == 0) {
            vec4 cover = texture2D(tMain, suv);
            if (uAspect > 0.01) {
                vec2 asp = vec2(1.);
                if (uAspect > 1.) asp.x = uAspect / 1.;
                else asp.y = 1. / uAspect;
                suv = scaleUV(suv, asp);
            }
            color = texture2D(tWebcam, suv).rgb;
            color = mix(color, cover.rgb, cover.a);
        }
        else if (index <= gridsize * gridsize) color = texture2D(tAtlas1, suv).rgb;
        else color = texture2D(tAtlas2, suv).rgb;
    }
    

#ifdef NUM_LIGHTS
    setupLight();
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);
#endif

    // color = mixFog(color);
    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(1.0-0.1*uShading, 1.0+uShading*0.1, pow(fresnel, 1.5));
    gl_FragColor = vec4(color, 1.0);
}
{@}BedroomWallsShader.glsl{@}#!ATTRIBUTES
#ifdef INSTANCED
attribute vec4 random;
#endif

#!UNIFORMS
uniform vec3 uColor1; //js {value: new Color()}
uniform vec3 uColor2; //js {value: new Color()}
uniform vec3 uShading; //js {value: new Vector3(0.9, 1.1, 1.5)}
uniform float uHeight; //js {value: 3.5}
uniform float uAlpha; 
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uShadowStrength2;
uniform float uLightStrength2;
uniform sampler2D tSketch; //js { value: Utils3D.getRepeatTexture('assets/images/sketch.jpg') }

#!VARYINGS
varying vec2 vUv;
varying float vGradient;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vPos;

#!SHADER: Vertex
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif

void main() {
    vec3 pos = position;

#ifdef INSTANCED
    vec4 mpos = modelMatrix * vec4(position, 1.);
    vGradient = (mpos.y) + random.x;
    vGradient /= uHeight;
#endif
#ifdef NUM_LIGHTS
    setupLight(pos);
#endif
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
    vPos = pos;
    vUv = uv;
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(fresnel.glsl)
#require(blendmodes.glsl)

vec3 stroke(float dist, vec3 color, vec3 bg, float thickness, float aa) {
    float alpha = smoothstep(0.5 * (thickness + aa), 0.5 * (thickness - aa), abs(dist));
    return mix(bg, color, alpha);
}


vec3 renderGrid(vec2 pos) {
    vec3 axes = vec3(0.8);
    float subdiv = 22.;

    float thickness = 0.0002;
    float aa = length(fwidth(pos));

    vec2 toSubGrid = pos - round(pos*subdiv)/subdiv;
    vec3 color;
    color = stroke(min(abs(toSubGrid.x), abs(toSubGrid.y)), vec3(0.3), color, thickness, aa);

    subdiv *= 10.;
    vec2 toGrid = pos - round(pos*subdiv)/subdiv;
    color = stroke(min(abs(toGrid.x), abs(toGrid.y)), vec3(0.1), color, thickness, aa);

    return color;
}

void main() {
    vec3 color = mix(uColor1, uColor2, vGradient);
    //vec3 color = mix(vec3(0.569,0.953,0.275), vec3(0.953,0.318,0.447), vGradient);
    //color = vec3(vGradient);

    #ifdef NUM_LIGHTS
        setupLight();
        color *= mix(vec3(1.0), getPointLightColor(), uLightStrength * uLightStrength2);
        color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength * uShadowStrength2);
    #endif

    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(uShading.x, uShading.y, pow(fresnel, uShading.z));
    color = blendOverlay(color, texture2D(tSketch, vPos.zx*0.15+vPos.yx*0.15+vPos.yz*0.15).rgb, 0.025);

    color += renderGrid(vUv * 0.05) * 0.3;

    gl_FragColor = vec4(color, 1.0);
}{@}CheckerSkyShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor; //js { value: new Color('#0000ff') }
uniform float uAlpha; //js { value: 1 }
uniform float uTime; //js { value: 0 }
uniform float uIntro; //js { value: 0 }
uniform vec3 uPink; //js { value: new Color('#f67eb6') }
uniform vec3 uBaseColor; //js { value: new Color('#ffffff') }
uniform float uBlendBase; //js { value: 1 }
#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(simplenoise.glsl)
#require(transformUV.glsl)

vec3 stroke(float dist, vec3 color, vec3 bg, float thickness, float aa) {
    float alpha = smoothstep(0.5 * (thickness + aa), 0.5 * (thickness - aa), abs(dist));
    return mix(bg, color, alpha);
}


vec3 renderGrid(vec2 pos) {
    vec3 axes = vec3(0.8);
    float subdiv = 22.;

    float thickness = 0.0003;
    float aa = length(fwidth(pos));

    vec2 toSubGrid = pos - round(pos*subdiv)/subdiv;
    vec3 color;
    color = stroke(min(abs(toSubGrid.x), abs(toSubGrid.y)), vec3(0.3), color, thickness, aa);

    subdiv *= 10.;
    vec2 toGrid = pos - round(pos*subdiv)/subdiv;
    color = stroke(min(abs(toGrid.x), abs(toGrid.y)), vec3(0.1), color, thickness, aa);

    return color;
}


void main() {
    vec2 uv = vUv;
    vec3 color = uColor;
    vec3 noisePos = vPos;
    noisePos += cnoise(vPos * 0.5+time*0.3) * 0.2;
    color -= smoothstep(0.0, 1.2, abs(noisePos.y)) * 0.2;
    color += renderGrid(uv * 1.5) * mix(0.5, 0.25, uIntro);

    vec2 size = vec2(120.0, 60.0) * 1.6;
    float total = floor(uv.x * float(size.x)) +
                  floor(uv.y * float(size.y));
    vec3 checker = mix(uPink+0.1, uPink, mod(total, 2.0));

    vec2 noiseUV = vPos.zy;
    noiseUV += cnoise(rotateUV(vPos.yx, 100.0) * 4.0) * 0.6;
    noiseUV = rotateUV(noiseUV, length(vPos.zx) * 60.0 + time * 2.0);
    color = mix(color, checker, step(uIntro*4.0, abs(noiseUV.y)));

    color = mix(color, uBaseColor, smoothstep(0.08, 0.0, abs(vPos.y)) * uBlendBase);

    gl_FragColor = vec4(color, uAlpha);
}{@}DialShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform vec3 uColor2;
uniform float uHover;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    vNormal = normalize(normalMatrix * normal);
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec2 uv = vUv;
    vec3 color = uColor;
    color = mix(color, uColor2, uHover);

    color *= mix(0.0, 1.2, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));



    gl_FragColor = vec4(color, 1.0);
}{@}HomeBillboardShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform vec3 uColor;
uniform float uFuzz;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    vNormal = normal;
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(simplenoise.glsl)

void main() {
    vec2 uv = vUv;


    vec2 titleUV = uv;
    float fuzz = mix(10.0, 1000.0, smoothstep(0.0, 1.0, uFuzz));
    titleUV = round(titleUV * fuzz) / fuzz;

    //uv.x += time * 0.1;
    vec4 color = texture2D(tMap, titleUV);


    color.rgb *= step(0.5, vPos.z);
    color.rgb *= mix(0.5, 1.0, step(0.0, pow(sin(time * 1.0 - uv.x * 4.0), 3.0)));

    float edges = smoothstep(0.5, 0.42, abs(uv.x-0.5));
    edges = min(edges, smoothstep(0.5, 0.22, abs(uv.y-0.5)));
    color.rgb += (1.0-edges) * uColor * (0.6 + sin(time * 3.0) * 0.3);
    color.rgb = mix(color.rgb, uColor, step(0.95, (1.0-edges)));

    color.rgb = mix(color.rgb, uColor, 1.0-step(0.1, vPos.z));

    color *= mix(0.5, 1.5, (1.0-pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0)));

    color += getNoise(vUv, time) * 0.1;


    gl_FragColor = color;
    gl_FragColor.a *= uAlpha;
}{@}HomeCatShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec2 uv = vUv;

    float fuzz = mix(40.0, 5000.0, step(-0.98, sin(time + uv.y*10.0)));
    uv = round(uv * fuzz) / fuzz;

    vec4 color = texture2D(tMap, uv);

    if (color.a < 0.6) discard;
   //if (vPos.z < 0.5) discard;
    
    gl_FragColor = color;
    gl_FragColor.a *= uAlpha;
}{@}HomeSkyShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor; //js { value: new Color('#0000ff') }
uniform float uAlpha; //js { value: 1 }
uniform float uTime; //js { value: 0 }
uniform float uIntro; //js { value: 0 }
uniform vec3 uPink; //js { value: new Color('#f67eb6') }

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(simplenoise.glsl)
#require(transformUV.glsl)

vec3 stroke(float dist, vec3 color, vec3 bg, float thickness, float aa) {
    float alpha = smoothstep(0.5 * (thickness + aa), 0.5 * (thickness - aa), abs(dist));
    return mix(bg, color, alpha);
}


vec3 renderGrid(vec2 pos) {
    vec3 axes = vec3(0.8);
    float subdiv = 22.;

    float thickness = 0.0003;
    float aa = length(fwidth(pos));

    vec2 toSubGrid = pos - round(pos*subdiv)/subdiv;
    vec3 color;
    color = stroke(min(abs(toSubGrid.x), abs(toSubGrid.y)), vec3(0.3), color, thickness, aa);

    subdiv *= 10.;
    vec2 toGrid = pos - round(pos*subdiv)/subdiv;
    color = stroke(min(abs(toGrid.x), abs(toGrid.y)), vec3(0.1), color, thickness, aa);

    return color;
}


void main() {
    vec2 uv = vUv;
    vec3 color = uColor;
    vec3 noisePos = vPos;
    noisePos += cnoise(vPos * 0.5+time*0.3) * 0.2;
    color -= smoothstep(0.0, 1.2, abs(noisePos.y)) * 0.25;

    vec2 size = vec2(80.0);

    vec2 checkerUV = uv;//rotateUV(uv, uTime * 0.1);
    float total = floor(checkerUV.x * float(size.x)) + floor(checkerUV.y * float(size.y) * 0.6);
    vec3 checkerColor = mix(uPink, uPink, step(0.6, uIntro));
    vec3 checker = mix(checkerColor+0.05, checkerColor, mod(total, 2.0));

    float wave = mod(- time * 0.02 + abs(vPos.y) * 0.4 + mod(total, 2.0), 0.2);
    color += renderGrid(vec2(uv.x, uv.y*0.5) * 2.0) * mix(0.8, 0.4, uIntro);// * mix(0.0, 5.0, wave);
    color += smoothstep(0.1, 0.2, wave) * 0.01;


    vec2 noiseUV = rotateUV(vPos.yz, length(vPos.zx) * 2.0);
    noiseUV += cnoise(noiseUV * 8.0 ) * 0.2;
    noiseUV = rotateUV(noiseUV, length(vPos.zx) * 2.0);
    color = mix(color, checker, step(min(uTime*3.0, uIntro*4.0), abs(noiseUV.y)) * smoothstep(0.0, 0.2, uTime));

    gl_FragColor = vec4(color, uAlpha);
}{@}WorldLinesShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec2 uv = vUv;
    vec3 color = vec3(0.0);

    color += step(0.99, fract(vPos.y*5.0));
    color *= (1.0-fract(vPos.z*5.0 + time * 0.5));
    color *= smoothstep(1.0, 0.0, abs(vPos.y));
    color *= 0.2;

    gl_FragColor = vec4(color, 1.0);
}{@}PathColorShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor; //js { value: new Color('#ff0000') }

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    vNormal = normalize(normalMatrix * normal);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec2 uv = vUv;
    vec3 color = uColor;
    color *= mix(0.6, 1.4, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    float alpha = 1.0;//;

    color += step(sin(-time * 1.0 + uv.y * 80.0) * 0.9, sin(time * 3.0 + uv.y * 160.0 - sin(length(uv-0.5)) * 1.0 * (1.0 + cos(time - uv.y * 5.0)))) * 0.03;

    if (step(0.5, vPos.y) > 0.0) discard;
    
    gl_FragColor = vec4(color, alpha);
}{@}PathCheerleaderShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

#require(rotation.glsl)

void main() {
    vUv = uv;

    vec3 pos = position;

    vec3 axis = cross(normalize(offset), vec3(0.0, 0.0, 0.0));
    float angle = (sin(length(offset * 1.4) - time) * 0.5 + 0.5) * 3.14159 + 3.14159;
    //angle *= 20.0;
    mat4 m = rotationMatrix(axis, angle * 0.05);
    //pos -= offset;
    pos = (m * vec4(pos.xyz, 1.0)).xyz;

    vPos = pos;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
    vec2 uv = vUv;
    vec4 color = texture2D(tMap, uv);
    
    gl_FragColor = color;
    gl_FragColor.a *= uAlpha;
}{@}HandShader.glsl{@}#!ATTRIBUTES
#ifndef SKINNED_MESH
attribute vec3 pinch;
#endif

#!UNIFORMS
uniform vec3 uColor;
uniform vec2 uFresnel;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;
uniform float uHover;
uniform float uActive;

#ifndef SKINNED_MESH
uniform float uPinch;
#endif

uniform float uVisible;
uniform vec2 uFade;


#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vPos;
varying vec3 vWorldPos;
varying float vFade;
varying vec3 vOPos;

#!SHADER: Vertex
#ifdef NUM_LIGHTS
#require(lighting.vs)
#endif
#ifdef SKINNED_MESH
#require(skinning.glsl)
#endif

void main() {
    vec3 pos = position;
    vOPos = pos;
    vec3 n = normal;
    vec3 prevPos = pos;
#ifdef SKINNED_MESH
    applySkin(pos, n);
#else
    pos = mix(pos, pinch, uPinch);
    pos *= mix(0.8, 1.0, uVisible);
#endif
#ifdef NUM_LIGHTS
    setupLight(pos);
#else
    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
#endif
    vUv = uv;

    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vFade = smoothstep(uFade.x, uFade.y, length(cameraPosition-vWorldPos));

    vPos = pos;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#ifdef NUM_LIGHTS
#require(lighting.fs)
#require(shadows.fs)
#endif
#require(fresnel.glsl)
void main() {
    vec3 color = vec3(1.0);
#ifdef NUM_LIGHTS
    setupLight();
    color *= mix(vec3(1.0), getPointLightColor(), uLightStrength);
    //color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);
#endif
    vec3 normal = vNormal;
    vec3 viewDir = normalize(vViewDir);
    float power = 1.0;
    float fresnel = 1.0 - getFresnel(normal, viewDir, 1.0);

    color *= mix(0.8, 0.97, pow(fresnel, 1.0));
    color *= mix(0.85, 1.1, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));
    color *= mix(1.0, 1.0 + sin(time * 5.0 - vNormal.x * 2.0) * 0.15, 1.0-uActive);

    float alpha = uVisible;
    alpha *= vFade;

    color *= mix(0.95, 0.85, smoothstep(1.2, 0.0, length(vOPos)));

    gl_FragColor = vec4(color, alpha);
}
{@}RoomObjectShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
#require(lighting.vs)
void main() {
    vec3 pos = position;
    setupLight(pos);
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(lighting.fs)
#require(shadows.fs)
void main() {
    setupLight();
    vec3 color = uColor * mix(vec3(1.0), getPointLightColor(), uLightStrength);
    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);
    gl_FragColor = vec4(color, 1.0);
}
{@}CandyShader.glsl{@}#!ATTRIBUTES
attribute float index;

#!UNIFORMS
uniform sampler2D tMap; // palette
uniform vec2 uPaletteSize;
uniform float uFresnelStrength;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vColor;

#!SHADER: Vertex
#require(instance.vs)

float rand(float n){return fract(sin(n) * 43758.5453123);}

void main() {
    vUv = uv;
    vec3 pos = transformPosition(position, offset, scale, orientation);
    vec3 n = normal;
    #ifdef INSTANCED
    n = transformPosition(normal, vec3(0.0), 1.0, orientation);
    #endif
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    
    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));

    int offset = int(rand(index / 200.) * uPaletteSize.x);
    vColor = texelFetch(tMap, ivec2(offset % int(uPaletteSize.x), 0), 0).rgb;
}

#!SHADER: Fragment
#require(fresnel.glsl)

void main() {
    vec3 color = vColor;
    vec3 light = vec3(1.0, 0.9804, 0.9176);

    float fresnel = 1. - getFresnel(vNormal, normalize(vViewDir), 4.0);
    color *= mix(0.95, 1.05, fresnel);
    
    gl_FragColor = vec4(color, 1.0);
}{@}PorterPinataShader.glsl{@}#!ATTRIBUTES
attribute vec3 vdata;

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tHurt;
uniform float uInflate;
uniform float uAnger;
uniform float uHit;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vViewDir;

#!SHADER: Vertex
#require(skinning.glsl)

void main() {
    vec3 pos = position;
    vec3 n = normal;
    vec3 prevPos = pos;
    applySkin(pos, n);

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);

    vUv = uv;
    vNormal = normalize(normalMatrix * n);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));

    modelViewPos.xyz += vNormal * 0.05 * uInflate; // puff him up on hit
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(fresnel.glsl)
#require(blendmodes.glsl)

void main() {
    vec3 color = texture2D(tMap, vUv).rgb;
    if (uInflate > 0.01) color = texture2D(tHurt, vUv).rgb;

    color = mix(color, vec3(0.6431, 0.0667, 0.0667), pow(max(uInflate, uAnger), 2.0));

    color += uHit * 0.2;

    // quick and dirty fake IBL lighting, s/o blackle
    // https://www.shadertoy.com/view/ttGfz1
    color *= pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 0.5);

    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color += pow(fresnel, 2.0) * 0.25;

    // mix in anger red

    color *= 1.2;

    gl_FragColor = vec4(color, 1.0);
}
{@}PromptShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform vec2 uSpriteMove;
uniform float uVisible;
uniform vec2 uColumnsRows;
uniform vec2 uBrightness;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;

    vec3 pos = position;

    //pos.z += (1.0-uVisible);

    vPos = pos;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(range.glsl)
#require(simplenoise.glsl)
#require(contrast.glsl)

void main() {
    vec2 uv = vUv;
    vec2 spriteUV = scaleUV(scaleUV(vUv, vec2(1.0)), vec2(uColumnsRows.x, uColumnsRows.y), uSpriteMove);
    vec4 color = texture2D(tMap, spriteUV);

    color.rgb = adjustContrast(color.rgb, uBrightness.x, uBrightness.y);

    color.a *= uAlpha;
    color.a *= uVisible;//1.0-step(uVisible*0.7, length(uv-0.5));

    if (color.a == 0.0) discard;

    gl_FragColor = color;
}{@}WiggleLogoShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform float uDelta;
uniform float uScroll;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vec3 pos = position;

    vec3 checkPos = pos;
    checkPos.y -= uScroll;

    pos.z -= uDelta * smoothstep(5.0, 0.0, abs(checkPos.y)) * 0.04;

    pos.z += smoothstep(-0.7, -3.0, checkPos.y) * 25.0;

    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vPos = pos;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
    vec2 uv = vUv;

   //uv.y += uDelta * 0.1 * smoothstep(0.5, 0.0, abs(uv.x-0.5));
    vec4 color = texture2D(tMap, uv);
    
    gl_FragColor = color;
    gl_FragColor.a *= uAlpha;
}{@}EndComposite.fs{@}uniform sampler2D tDiffuse;
uniform float uDrugs;
uniform vec3 uDrugColor;
uniform float uPhone;

varying vec2 vUv;

#require(UnrealBloom.fs)
#require(rgbshift.fs)
#require(transformUV.glsl)
#require(rgb2hsv.fs)

float intensity(in vec4 color){
	return sqrt((color.x*color.x)+(color.y*color.y)+(color.z*color.z));
}

vec3 sobel(float stepx, float stepy, vec2 center){
    float tleft = intensity(texture2D(tDiffuse,center + vec2(-stepx,stepy)));
    float left = intensity(texture2D(tDiffuse,center + vec2(-stepx,0)));
    float bleft = intensity(texture2D(tDiffuse,center + vec2(-stepx,-stepy)));
    float top = intensity(texture2D(tDiffuse,center + vec2(0,stepy)));
    float bottom = intensity(texture2D(tDiffuse,center + vec2(0,-stepy)));
    float tright = intensity(texture2D(tDiffuse,center + vec2(stepx,stepy)));
    float right = intensity(texture2D(tDiffuse,center + vec2(stepx,0)));
    float bright = intensity(texture2D(tDiffuse,center + vec2(stepx,-stepy)));
    float x = tleft + 2.0*left + bleft - tright - 2.0*right - bright;
    float y = -tleft - 2.0*top - tright + bleft + 2.0 * bottom + bright;
    float color = sqrt((x*x) + (y*y));
    return vec3(color,color,color);
 }

void main() {
    vec2 uv = vUv;
    vec3 texel = texture2D(tDiffuse, uv).rgb;

    if (uDrugs > 0.0) {
        float stepv = resolution.x / mix(1500.0, 750.0, uPhone);
        vec3 edge = sobel(stepv/resolution.x, stepv/resolution.y, uv);
        texel = mix(texel, pow(edge, vec3(1.5)), smoothstep(0.0, 0.5, uDrugs));
    }

    gl_FragColor = vec4(texel, 1.0);
}{@}WorldsComposite.fs{@}uniform sampler2D tDiffuse;
uniform float uScroll;
uniform float uScrollDelta;
uniform float uPhone;

varying vec2 vUv;

#require(UnrealBloom.fs)
#require(rgbshift.fs)
#require(transformUV.glsl)
#require(rgb2hsv.fs)


float intensity(in vec4 color){
	return sqrt((color.x*color.x)+(color.y*color.y)+(color.z*color.z));
}

vec3 sobel(float stepx, float stepy, vec2 center){
    float tleft = intensity(texture2D(tDiffuse,center + vec2(-stepx,stepy)));
    float left = intensity(texture2D(tDiffuse,center + vec2(-stepx,0)));
    float bleft = intensity(texture2D(tDiffuse,center + vec2(-stepx,-stepy)));
    float top = intensity(texture2D(tDiffuse,center + vec2(0,stepy)));
    float bottom = intensity(texture2D(tDiffuse,center + vec2(0,-stepy)));
    float tright = intensity(texture2D(tDiffuse,center + vec2(stepx,stepy)));
    float right = intensity(texture2D(tDiffuse,center + vec2(stepx,0)));
    float bright = intensity(texture2D(tDiffuse,center + vec2(stepx,-stepy)));
    float x = tleft + 2.0*left + bleft - tright - 2.0*right - bright;
    float y = -tleft - 2.0*top - tright + bleft + 2.0 * bottom + bright;
    float color = sqrt((x*x) + (y*y));
    return vec3(color,color,color);
 }

void main() {
    vec2 uv = vUv;

    float bend = pow(smoothstep(0.0, 1.0, abs(uv.y-0.5)), 6.0);
    uv = scaleUV(uv, vec2(1.0 + bend * 6.0, 1.0));
    uv = scaleUV(uv, vec2(1.0 + uScrollDelta * 0.02));
       
    vec3 texel = texture2D(tDiffuse, uv).rgb;//getRGB(tDiffuse, uv, radians(-90.0), uScrollDelta * 0.000).rgb;

    //texel += pow(getUnrealBloom(vUv), vec3(1.5)) * abs(uScrollDelta) * 0.02;
    //edge *= 0.25 + 0.75 * pow( 16.0 * uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y), 0.15 );

    if (abs(uScrollDelta) > 0.02) {
        float stepv = resolution.x / mix(3000.0, 1500.0, uPhone);
        vec3 edge = sobel(stepv/resolution.x, stepv/resolution.y, scaleUV(uv, vec2(1.001)));
        texel = mix(texel, edge, smoothstep(0.0, 2.0, abs(uScrollDelta)));
    }

    gl_FragColor = vec4(texel, 1.0);
}{@}WorldsBGShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;
uniform float uShadowBias;
uniform float uShadowStrength;
uniform float uLightStrength;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(position, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(fresnel.glsl)
#require(rgb2hsv.fs)
#require(shadows.fs)
#require(lighting.fs)

vec3 stroke(float dist, vec3 color, vec3 bg, float thickness, float aa) {
    float alpha = smoothstep(0.5 * (thickness + aa), 0.5 * (thickness - aa), abs(dist));
    return mix(bg, color, alpha);
}

vec3 renderGrid(vec2 pos) {
    vec3 axes = vec3(0.8);
    float subdiv = 22.;

    float thickness = 0.0002;
    float aa = length(fwidth(pos));

    vec2 toSubGrid = pos - round(pos*subdiv)/subdiv;
    vec3 color;
    color = stroke(min(abs(toSubGrid.x), abs(toSubGrid.y)), vec3(0.3), color, thickness, aa);

    subdiv *= 5.;
    vec2 toGrid = pos - round(pos*subdiv)/subdiv;
    color = stroke(min(abs(toGrid.x), abs(toGrid.y)), vec3(0.1), color, thickness, aa);

    return color;
}

void main() {
    vec2 uv = vUv;
    vec3 color = uColor;

    float fresnel = 1.0-getFresnel(vNormal, vViewDir, 1.0);
    fresnel = pow(fresnel, 1.2);
    color += mix(-1.0, 1.0, fresnel) * 0.4 * mix(-0.9, 1.0, step(-2.99999, vPos.z * 6.0));

    color += renderGrid(vWorldPos.zx * 0.01 * vec2(1.0, 2.0)) * 0.3;
    color += renderGrid(vWorldPos.zy * 0.01 * vec2(1.0, 2.0)) * 0.3;
    color += renderGrid(vWorldPos.xy * 0.01) * 0.3;

    color *= mix(1.0, getShadow(vPos, uShadowBias), uShadowStrength);

    gl_FragColor = vec4(color, uAlpha);
}
{@}WorldsImageShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform float uRotate;
uniform float uSpeed;
uniform vec3 uFogColor;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;

    vec3 pos = position;
    vPos = pos;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)

void main() {
    vec2 uv = rotateUV(vUv, (uRotate * 50.0 + time) * uSpeed);
    vec4 color = texture2D(tMap, uv);

    //color.rgb = mix(color.rgb, uFogColor, smoothstep(-5.0, -40.0, vWorldPos.z));
    

    color.a *= uAlpha;

    //color.a *= smoothstep(-50.0, -20.0, vWorldPos.z);

    if (color.a < 0.05) discard;
    
    gl_FragColor = color;
}{@}BackgroundShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    vec3 color = uColor;
    gl_FragColor = vec4(color, 1.0);
}{@}DynamicLogoShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tFluid;
uniform sampler2D tFluidMask;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec2 vSUv; // calculate screenspace uv as if its just a window into FSQuad

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 clipPos = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    vSUv = (clipPos.xy / clipPos.w) * vec2(.5) + vec2(.5);

    gl_Position = clipPos;
}

#!SHADER: Fragment
#require(transformUV.glsl)
#require(simplenoise.glsl)

void main() {
    vec3 color;
    vec2 logoUV = vUv;

    float fluid = texture2D(tFluid, vSUv).r;
    float amp = 0.01;
    float scale = 5.;
    float freq = 3.;
    vec2 offset = vec2(
        cnoise(vec2(vUv.x * scale, time / freq)),
        cnoise(vec2(vUv.y * scale, -time / freq))
    ) * amp * (1. + fluid * 0.1);

    logoUV += offset;

    float mask = texture2D(tMap, logoUV).r;
    mask = smoothstep(0.4, 0.6, mask);
    color = mix(uColor2, uColor1, mask);

    // color = vec3(offset, 0.);
    gl_FragColor = vec4(color, 1.0);
}{@}AnimatedBird.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tAnimation;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;

#!SHADER: Vertex
#require(range.glsl)


void main() {
    vec3 pos = position;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
    vUv = uv;
    vNormal = normal;
}

#!SHADER: Fragment
#require(range.glsl)

void main() {
    gl_FragColor.rgb = vec3(1.0) * (1.0 + dot(vec3(0.2, 1.0, 0.8), vNormal.xyz)) / 2.0 + vec3(0.0, 0.0, 0.3);
    gl_FragColor.a = 1.0;
}{@}InstancedBirdParticles.glsl{@}#!ATTRIBUTES
attribute vec3 lookup;
attribute vec4 random;

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tPos;
uniform sampler2D tPrevPos;
uniform sampler2D tAnimation;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uAltColor1;
uniform vec3 uAltColor2;
uniform float uEnabled;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec3 vVel;
// varying vec3 vPrevPos;

#!SHADER: Vertex
#require(range.glsl)
#require(instance.vs)

vec2 rotate(vec2 v, float a) {
    float s = sin(a);
    float c = cos(a);
    mat2 m = mat2(c, -s, s, c);
    return m * v;
  }

void main() {
    float scale = mix(0.15,0.2,random.z);
    vec3 offset = texture2D(tPos, lookup.xy).xyz;
    vec3 prevpos = texture2D(tPrevPos, lookup.xy).xyz;
    vec3 velocity = offset - prevpos;

    // Flap wings
    float upwardDirection = dot(vec3(0.0, 1.0, 0.0), velocity);
    vec3 localpos = position;
    float speed = 1.6 + random.y * 0.5;
    float frameCount = 12.0;
    float animationOffset = random.x * 400.0;

    float flapStrength = pow((sin(time + animationOffset) + 1.0) / 2.0, 2.0);
    float glideStrength = 0.3;
    
    vec3 flapAnimation = position;
    flapAnimation.y += sin(time * speed * 4.0 + animationOffset - abs(position.x) * 3.0) * 0.4;
    //wwflapAnimation.y -= sin(time * speed * 4.0 + animationOffset) * 0.4;
    flapAnimation.z *= 0.4;
    flapAnimation.x *= 0.5;

    vec3 glideAnimation = vec3(0.0, cos(position.x + time * speed + animationOffset) * (1.0 - flapStrength) * glideStrength + cos(offset.x + time * speed), 0.0);
    glideAnimation.z *= 0.4;
    glideAnimation.x *= 1.2;
    
    float flapFactor = clamp(pow(length(velocity), 2.0) * 2000.0, 0.0, 1.0);
    flapFactor = crange(flapFactor, 0.5, 1.0, 0.0, 1.0);

    float floatSin = 0.5 + sin(time * 0.5 + random.y * 20.0) * 0.5;
    flapFactor *= pow(floatSin, 2.0);

    localpos = localpos 
        + mix(glideAnimation, flapAnimation, flapFactor);

            localpos.y -= cos(time * speed * 2.0 + animationOffset) * 0.5;


    // Rotate in direction of flight
    float angle = atan(velocity.x, velocity.z);
    localpos.xz = rotate(localpos.xz, angle);

    vec3 pos = transformPosition(localpos, offset, scale);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);

    vUv = uv;
    vPos = pos;
    vNormal = normal;
    vVel = velocity;
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
}

#!SHADER: Fragment
#require(fresnel.glsl)

void main() {
    vec3 lightDir = vec3(0.5, 0.5, 0.5);
    float dp = dot(lightDir, vNormal);

    vec3 color = vec3(1.0);
    color = mix(uColor1, uColor2, dp);
    vec3 altColor = mix(uAltColor1, uAltColor2, dp);

    color = mix(color, altColor, uEnabled);

    float fresnel = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(0.8, 1.0, fresnel);

    color *= mix(0.6, 1.2, pow(length(sin(vNormal*2.)*.5+.5)/sqrt(3.), 1.0));

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}{@}BgShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform vec3 uHorizonColor;
uniform float uHorizonBlend;
uniform sampler2D tDither;

#!VARYINGS
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vec3 pos = position;
    vPos = pos;
    vUv = uv;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

vec3 stroke(float dist, vec3 color, vec3 bg, float thickness, float aa) {
    float alpha = smoothstep(0.5 * (thickness + aa), 0.5 * (thickness - aa), abs(dist));
    return mix(bg, color, alpha);
}

vec3 renderGrid(vec2 pos) {
    vec3 axes = vec3(0.8);
    float subdiv = 22.;

    float thickness = 0.0003;
    float aa = length(fwidth(pos));

    vec2 toSubGrid = pos - round(pos*subdiv)/subdiv;
    vec3 color;
    color = stroke(min(abs(toSubGrid.x), abs(toSubGrid.y)), vec3(0.3), color, thickness, aa);

    subdiv *= 10.;
    vec2 toGrid = pos - round(pos*subdiv)/subdiv;
    color = stroke(min(abs(toGrid.x), abs(toGrid.y)), vec3(0.1), color, thickness, aa);

    return color;
}

void main() {
    vec3 color = uColor;

    color += smoothstep(0.0, 0.3, vPos.y) * 0.1;

    vec2 gridUV = vec2(sin(vWorldPos.x - time * 0.1) + cos(vWorldPos.z - time * 0.1) * 5.0, vWorldPos.y * 0.5);
    color += renderGrid(gridUV * 0.005) * 0.3;


    float blendHorizon = smoothstep(0.08, -0.01, abs(vPos.y)) * uHorizonBlend;
    float dithered = step(1.0-pow(blendHorizon, 3.0) + sin(time - vUv.y*50.0) * 0.02, texture2D(tDither, vUv * 200.0).r);
    blendHorizon *= dithered;//mix(1.0, dithered, smoothstep(1.0, 0.8, blendHorizon));

    color = mix(color, uHorizonColor, step(0.5, blendHorizon));

    gl_FragColor = vec4(color, 1.0);
}
{@}SkyShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tMap2;
uniform vec2 uScale;
uniform vec3 uDepth;
uniform float uDarken;
uniform vec3 uSkyColor;
uniform vec2 uOffset;
uniform float uSaturation;
uniform float uContrast;
uniform float uSwitch;
uniform float uMovement;
uniform vec3 uHorizonBlend;
uniform float uHorizon;
uniform sampler2D tDither;
uniform float uHueShift;

#!VARYINGS
varying vec2 vUv;
varying vec3 vWorldPos;
varying vec3 vPos;
varying float vClouds;

#!SHADER: Vertex
#require(simplenoise.glsl)
#require(transformUV.glsl)

void main() {

    vec3 pos = position;
    
    vUv = scaleUV(uv, uScale);
    vUv += uOffset;

    vPos = pos;
    vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(simplenoise.glsl)
#require(rgb2hsv.fs)
#require(range.glsl)

void main() {
    vec2 uv = vUv;

    if (uSwitch > 0.0) {
        uv += cnoise(uv * 1.5 - uSwitch + time) * smoothstep(0.5, 0.25, abs(uSwitch-0.5)) * 0.1;
    }

    uv.x += time * 0.0025 * uMovement;
    //uv.y += time * 0.005 * uMovement;

    vec2 uv2 = uv;
    uv.y += uSwitch * 0.15;
    uv.x += uSwitch * 0.5;

    float pixels = mix(60.0, 61.0, cnoise(vPos*0.1 + time*0.02));
    uv = round(vec2(uv.x, uv.y*(uScale.y/uScale.x)) * pixels) / pixels;

    vec3 color = texture2D(tMap, uv).rgb;
    vec3 color2 = texture2D(tMap, scaleUV(vUv, vec2(100000.0), vec2(0.5 + sin(time * 0.002) * 0.1))).rgb;

    if (uSwitch > 0.0) {
        uv2.y -= (1.0-uSwitch) * 0.15;
        uv2.x -= (1.0-uSwitch) * 0.5;
        vec3 colorB = texture2D(tMap2, uv2).rgb;
        vec3 colorB2 = texture2D(tMap2, scaleUV(vUv, vec2(100000.0), vec2(0.5 + sin(time * 0.002) * 0.1))).rgb;

        float fade = crange(uSwitch, 0.0, 1.0, 1.0, -1.0);
        color = mix(color, colorB, smoothstep(fade-1.0, fade, vPos.y));
        color2 = mix(color2, colorB2, uSwitch);

        color *= 1.0 - smoothstep(0.5, 0.1, abs(uSwitch-0.5)) * 0.2;
    }

    color = rgb2hsv(color);
    color.x += uHueShift;
    color = hsv2rgb(color);

    float clouds = color.r;

    if (uMovement < 1.0) {
        color *= mix(0.0, 1.0, step(0.0, vPos.y));
    }

    color = mix(mix(color, uSkyColor, uDarken), color, step(0.0, vPos.y));
    //color += (0.5 + sin(time * 0.5 + vWorldPos.x * 0.001) * 0.5) * vClouds * 0.1;

    float saturation = rgb2hsv(color).y;
    //color *= 1.0 + (0.5 + cnoise(time * 0.2 + vPos * 1.0) * 0.5) * smoothstep(0.2, 1.0, saturation) * 0.25;

    float skyFade = smoothstep(0.6 + color.r * 0.2, 0.95, abs(vPos.y));
    color = mix(color, color2 * 0.9, skyFade);
    color *= mix(1.0, 1.02, smoothstep(0.5, 1.0, abs(vPos.y)));

    // color = rgb2hsv(color);
    // //color.x += cnoise(vWorldPos*0.0006 + time * 0.2) * 0.015;
    // color.y *= uSaturation;
    // color = hsv2rgb(color);

    color = pow(color, vec3(uContrast));

    float blendHorizon = smoothstep(0.02, -0.005, abs(vPos.y)) * uHorizon;
    float dithered = step(1.0-pow(blendHorizon, 3.0) + sin(time - vUv.y*250.0) * 0.1, texture2D(tDither, vUv * 25.0).r);
    blendHorizon *= dithered;//mix(1.0, dithered, smoothstep(1.0, 0.8, blendHorizon));

    color = mix(color, uHorizonBlend, step(0.5, blendHorizon));

    //color *= smoothstep(-1.0, 0.0, vPos.y);
    gl_FragColor = vec4(color, 1.0);
}
{@}GpuRaycast.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPositionData;
uniform float uTextureSize;
uniform vec2 uCameraFarNear;

uniform vec3 uRayOrigin;
uniform vec3 uRayDirection;

uniform float uMaxDistance;

#!VARYINGS
varying vec3 vData;

#!SHADER: Vertex
#require(getCoord.glsl)
#define EPS 0.0001
void main() {

    vec3 indicies = position.xyz; //position in this case contains the indivies that makes up a triangle
    float dist = uCameraFarNear.x - uCameraFarNear.y;
    float index = -1.0;
    float isHit = 0.0;

    vec3 v0 = texelFetch(tPositionData, getCoordI(indicies.x, uTextureSize), 0).xyz;
    vec3 v1 = texelFetch(tPositionData, getCoordI(indicies.y, uTextureSize), 0).xyz;
    vec3 v2 = texelFetch(tPositionData, getCoordI(indicies.z, uTextureSize), 0).xyz;

    vec3 e1 = v1 - v0;
    vec3 e2 = v2 - v0;

    vec3 P = cross(uRayDirection, e2);
    float det = dot(e1, P); //check if ray is parallale to triangle face's surface / plane
    if(abs(det) > EPS) {

        vec3 T = uRayOrigin - v0;
        float f = 1.0 / det;

        //barycentric corodinate u
        float u = dot(T, P) * f;

        if(u >= 0.0 && u <= 1.0) {

            vec3 Q = cross(T, e1);
            float v = dot(uRayDirection, Q) * f;

            if(v >= 0.0 && v <= 1.0 && u + v <= 1.0) {

                float t = f * dot(e2, Q);
                if(t > EPS) {

                    vec3 intersectionPoint = uRayOrigin + uRayDirection * t;
                    float intersection_distance = length(intersectionPoint - uRayOrigin);
                    if(((1.0 - u - v) >= u) && ((1.0 - u - v) >= v)) {
                        index = position.x;
                    } else if(u >= v) {
                        index = position.y;
                    } else {
                        index = position.z;
                    }
                    dist = intersection_distance;
                    isHit = 1.0;

                }

            }

        }


    }

    vData = vec3(index, dist, isHit);
    gl_Position = vec4(vec3(0.5, 0.5, clamp(dist / uMaxDistance, 0.0, 1.0)), 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vData, 1.0);
}
{@}meshData.glsl{@}#!ATTRIBUTES
attribute vec3 data;

#!UNIFORMS
uniform float uVertexCount;
uniform float uTextureSize;
uniform mat4 uMatrix;

#!VARYINGS
varying vec4 vPosition;
varying vec3 vNormal;
varying vec3 vData;

vec3 sinNoise(vec3 seed, float fallOff, int octaves) {

    vec3 noise = vec3(0.0);

    float amp = 1.0;
    float freq = 1.0;
    float totalAmp = 0.0;

    vec3 s = seed;

    mat3 mat = mat3(0.563152, 0.495996, 0.660945, -0.660945, 0.750435, 0.0, -0.495996, -0.436848, 0.750435);

    for(int i = 0; i < octaves; i++) {
        s = mat * s.yzx;
        noise += sin(s.yzx * freq) * amp;
        amp *= fallOff;
        freq /= fallOff;
        s += noise;
        totalAmp += amp;
    }

    return noise / totalAmp;
}

#!SHADER: Vertex
void main() {

    float index = float(gl_VertexID);
    float posX = mod(index, uTextureSize) + 0.5;
    float posY = floor(index / uTextureSize) + 0.5;
    vec2 coord = vec2(posX, posY)/ uTextureSize;

    vPosition = uMatrix * vec4(position, 1.0);
    vNormal = normal;

    //previous
//    vec3 noise = sinNoise(position.yzx*5.1, 0.87, 3);
//    float phase = dot(noise, vec3(0.333))*0.5+0.5;
//    vData = vec3(phase*phase);

    vec3 noise = sinNoise(position.yzx*8.1, 0.87, 5);
    float phase = dot(noise, vec3(0.333))*0.5+0.5;
    vData = vec3(phase);

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
layout(location = 2) out vec4 data3;
void main() {
    data1 = vPosition;
    data2 = vec4(vNormal, 1.0);
    data3 = vec4(vData, 1.0);
}
{@}OutputMesh.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPosition;
uniform sampler2D tNormal;

uniform float uTextureSize;

uniform vec3 uBoundsMin;
uniform vec3 uBoundsMax;
uniform vec3 uInputPos;
uniform vec3 uHitPoint;
uniform float uApplyInput;


#!VARYINGS
varying vec3 vNormal;
varying vec3 vPos;

#!SHADER: Vertex
#require(range.glsl)
void main() {

    float index = float(gl_VertexID);
    float posX = mod(index, uTextureSize) + 0.5;
    float posY = floor(index / uTextureSize) + 0.5;
    vec2 coord = vec2(posX, posY)/ uTextureSize;

    vec3 localPos = texture2D(tPosition, coord).xyz;
    vec3 norm = normalize(texture2D(tNormal, coord).xyz);

    vPos = localPos;
    vNormal = norm;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(localPos, 1.0);
}

    #!SHADER: Fragment
void main() {

    float light = dot(normalize(vNormal * 0.5 + vec3(0.0, 1.0, 0.0) - vPos), vNormal) * 0.25 + (1.0 - 0.25);
    gl_FragColor = vec4(vec3(light), 1.0);
}
{@}OutputMeshPBR.glsl{@}#!ATTRIBUTES
attribute vec3 _barycentriccoords;
attribute vec3 _barycentricindices;

#!UNIFORMS
uniform sampler2D tPosition;
uniform sampler2D tNormal;

uniform float uTextureSize;
uniform vec3 uLightColor;
uniform vec3 uLightPosition;

uniform float uVertexCount;
uniform float uInflation;
uniform vec3 uHitColor;
uniform float uHitColorBlend;
uniform float uTransition;

#!VARYINGS
varying vec3 vNormal;
varying vec3 vPos;
varying vec2 vUv;
varying vec3 vViewPos;
varying float vIndex;
varying vec3 vWeights;
varying vec3 vViewDir;

#!SHADER: Vertex
#require(range.glsl)
#require(pbr.vs)
#require(getCoord.glsl)

void main() {

    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vIndex = index;

    vec3 localPos = texture2D(tPosition, coord).xyz;
//    setupPBR(localPos);

    vec4 norm = texture2D(tNormal, coord);
//    norm = normalize(norm);
    if(norm.w > 0.0) norm /= norm.w;
    norm = normalize(norm);

    localPos += mix(vec3(0.0), norm.xyz, abs(uInflation) * 0.3);
    localPos *= crange(uTransition, 0.02, 0.0, 1.0, 0.0); // see ConstrainCollide.glsl

    vPos = localPos;
    vNormal = normalMatrix * norm.xyz;
    vUv = uv;

//    vec4 viewPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 viewPos = viewMatrix * vec4(localPos, 1.0);
    vViewDir = -viewPos.xyz;
//    vViewDir = -vec3(modelViewMatrix * vec4(localPos, 1.0));

    vWeights = _barycentriccoords;

    gl_Position = projectionMatrix * viewPos;
}

#!SHADER: Fragment

#require(pbr.fs)
#require(fresnel.glsl)

void main() {
//    // PBR Config
//    // this is the default config that can be tweaked
//    PBRConfig baseConfig;
//    baseConfig.clearcoat = 0.0;
//    baseConfig.reflection = 1.0;
//    baseConfig.color = vec3(1.0);
//    baseConfig.lightColor = uLightColor;

    vec4 baseColor = texture2D(tBaseColor, vUv);
    baseColor.xyz = mix(baseColor.xyz, vec3(0.5), vec3(0.0));
//    vec3 pbr = getPBR(baseColor.rgb, baseConfig).rgb;
    vec3 N = normalize(vNormal);
    vec3 L = uLightPosition;
    float diff = dot(normalize(L - vPos), N) * 0.3 + (1.0 - 0.3);
    float ambient = N.y * 0.5 + 0.5;

    vec3 E = cameraPosition - vPos;
    vec3 eyeDir = normalize(E);
    vec3 lightDir = normalize(L - vPos);
    vec3 H = normalize(eyeDir + lightDir);

    float spec = pow(max(0.0, dot(H, N)), 16.0);
    float fresnel = pow(1.0 - max(0.0, dot(eyeDir, N)), 2.0);
    float light = diff * 0.7 + spec * 0.1 + ambient * 0.2 + fresnel * 0.2;

    vec3 color = baseColor.xyz * light;

    float fresnel2 = getFresnel(vNormal, vViewDir, 1.0);
    color *= mix(1.15, 0.9, pow(fresnel2, 1.5));
    color += pow(fresnel2, 2.0) * 0.1;

    color = mix(color, mix(color, uHitColor, uHitColorBlend), smoothstep(0.0, 1.0, abs(uInflation)) * 0.2);
    gl_FragColor = vec4(color, 1.0);
}
{@}ApplyGoalPositions.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tInitRelativePosition;
uniform sampler2D tCurrentCenterOfMass;

uniform sampler2D tRotation;
uniform sampler2D tAColA;
uniform sampler2D tAColB;
uniform sampler2D tAColC;

uniform float uAlpha;
uniform float uBeta;

uniform float uTextureSize;
uniform float uVertexCount;
uniform float uDeltaTime;

#!VARYINGS
varying vec3 vPos;

#!SHADER: Vertex
#require(getCoord.glsl)
#require(quatToMat.glsl)

void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texelFetch(tSolvedPosition, iCoord, 0).xyz;

    vec3 centerOfMass = texelFetch(tCurrentCenterOfMass, ivec2(0.0), 0).xyz / uVertexCount;
    vec3 initRelativePosition = texelFetch(tInitRelativePosition, iCoord, 0).xyz;
    mat3 R = quatToMat3((texelFetch(tRotation, ivec2(0.0), 0)));

    mat3 A = mat3(
        texelFetch(tAColA, ivec2(0), 0).xyz,
        texelFetch(tAColB, ivec2(0), 0).xyz,
        texelFetch(tAColC, ivec2(0), 0).xyz
    );

    mat3 finalMatrix = 0.5 * A + (1.0 - 0.5) * R;
//    mat3 finalMatrix = uBeta * A + (1.0 - uBeta) * R;
    vec3 goalPosition = (finalMatrix * initRelativePosition) + centerOfMass;
    float compliance = 0.0000001 / uDeltaTime / uDeltaTime;
//    pos += uAlpha * (goalPosition - pos);
    pos += 0.01 * (goalPosition - pos);

    vPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vPos, 1.0);
}
{@}BlitInitPositions.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

    #!SHADER: Fragment
void main() {

    vec3 pos = texture2D(tMap, vUv).xyz;
    float restLength = length(pos);
    gl_FragColor = vec4(pos, restLength);
}
{@}CalculateMatrix.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tP;
uniform sampler2D tQ;
uniform float isQQ;

uniform float uTextureSize;

#!VARYINGS
varying vec3 vColA;
varying vec3 vColB;
varying vec3 vColC;

#!SHADER: Vertex
#require(getCoord.glsl)

void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 p = texelFetch(tP, iCoord, 0).xyz;
    vec3 q = texelFetch(tQ, iCoord, 0).xyz;

    mat3 pqT = outerProduct(p, q);
    vColA = pqT[0];
    vColB = pqT[1];
    vColC = pqT[2];

//    vColA = p * q.x;
//    vColB = p * q.y;
//    vColC = p * q.z;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
layout(location = 2) out vec4 data3;
void main() {
    data1 = vec4(vColA, 1.0);
    data2 = vec4(vColB, 1.0);
    data3 = vec4(vColC, 1.0);
}
{@}ConstrainCollide.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPredictedPosition;
uniform sampler2D tInitPositions;
uniform sampler2D tInteractionData;
uniform sampler2D tNormal;
uniform sampler2D tData;

uniform float uApplyInput;
uniform vec4 uInitPosConstraintParams;
uniform float uApplyAttachmentConstraint;

uniform vec3 uHitData;
uniform vec3 uRayOrigin;
uniform vec3 uRayDirection;

uniform float uPullRadius;

uniform vec3 uBoundsMin;
uniform vec3 uBoundsMax;

uniform float uTextureSize;
uniform float uVertexCount;

uniform float uDeltaTime;
uniform float uInflation;

uniform float uTransition;

#!VARYINGS
varying vec3 vCorrectedPos;

#!SHADER: Vertex
#require(getCoord.glsl)
#require(quatToMat.glsl)
#require(range.glsl)

float falloff(float distance, float radius) {
    float t = clamp(distance / radius, 0.0, 1.0);
//    return 1.0 - smoothstep(0.0, 1.0, t);
//    return max(0.0, 1.0 - pow((distance / radius), 2.0));
    float p = (distance / radius);
    return exp(-p * p);
}

vec3 rotateVectorWithQuaternion(vec4 quaternion, vec3 vector) {
    vec3 t = 2.0 * cross(quaternion.xyz, vector);
    vec3 result = vector + quaternion.w * t + cross(quaternion.xyz, t);
    return result;
}

void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texelFetch(tPredictedPosition, iCoord, 0).xyz;
    float data = texelFetch(tData, iCoord, 0).x;

    float compliance = 0.0001 / uDeltaTime / uDeltaTime;
    vec3 correction = vec3(0.0);

    vec4 initPositions = texelFetch(tInitPositions, iCoord, 0);
    float restLength = initPositions.w;

//    pos *= smoothstep(0.0, clamp(length(initPositions.xyz)*0.7 + data * 0.3, 0.1, 1.0), uTransition);
    //pos *= smoothstep(0.0, clamp(length(initPositions.xyz)*0.7 + data * 0.4, 0.1, 1.0), uTransition);
//    pos *= smoothstep(0.0, clamp(length(initPositions.xyz)*0.7 + data * 0.4, 0.1, 1.0), uTransition);

    vec3 dir = pos - initPositions.xyz;
    float len = length(dir);
    dir /= len;
    float r = uInitPosConstraintParams.x + (restLength * uInitPosConstraintParams.y);
    if(len > 0.0 && len > r) correction -= dir * (len - r) * (restLength * mix(uInitPosConstraintParams.z, uInitPosConstraintParams.w, 0.0)) * uApplyAttachmentConstraint;

    pos += correction;

    if(pos.x < uBoundsMin.x) pos.x = uBoundsMin.x;
    if(pos.x > uBoundsMax.x) pos.x = uBoundsMax.x;

    if(pos.y < uBoundsMin.y) pos.y = uBoundsMin.y;
    if(pos.y > uBoundsMax.y) pos.y = uBoundsMax.y;

    if(pos.z < uBoundsMin.z) pos.z = uBoundsMin.z;
    if(pos.z > uBoundsMax.z) pos.z = uBoundsMax.z;

    //previous
//    pos *= mix(1.0, smoothstep(0.0, clamp(length(pos.xyz)*0.7 + data * 0.9, 0.1, 1.0), uTransition), step(uTransition, 1.0));
    // never go all the way to zero, it ruins the buffers on some GPUs but haven’t figured out why.
    float transition = crange(uTransition, 0.0, 1.0, 0.02, 1.0);

    pos *= smoothstep(0.0, clamp(smoothstep(0.0, 1.0, length(pos.xyz)*0.7 + data * 0.4), 0.1, 1.0), transition);
    vCorrectedPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vCorrectedPos, 1.0);
}
{@}ConstructMatrix.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tAPQColA;
uniform sampler2D tAPQColB;
uniform sampler2D tAPQColC;

uniform sampler2D tAQQColA;
uniform sampler2D tAQQColB;
uniform sampler2D tAQQColC;

uniform sampler2D tPrevR;
uniform float uFirstTick;

uniform float uBeta;
uniform float uTextureSize;

#!VARYINGS
varying vec4 vRotation;
varying vec3 vAcolA;
varying vec3 vAcolB;
varying vec3 vAcolC;

#!SHADER: Vertex
#require(quatToMat.glsl)
#define EPS 1.0e-9

vec4 quaternionFromAngleAxis(in float angle, in vec3 axis) {
    float half_angle = angle * 0.5;
    float s = sin(half_angle);

    vec4 q;
    q.x = axis.x * s;
    q.y = axis.y * s;
    q.z = axis.z * s;
    q.w = cos(half_angle);

    return q;
}

vec4 multiplyQuaternions(in vec4 q1, in vec4 q2) {
    vec4 result;
    result.xyz = q2.xyz * q1.w + q1.xyz * q2.w + cross(q1.xyz, q2.xyz);
    result.w = q1.w * q2.w - dot(q1.xyz, q2.xyz);
    return (result);
}

void main() {

    mat3 Aqq = mat3(0.0);
    Aqq[0] = texelFetch(tAQQColA, ivec2(0.0), 0).xyz;
    Aqq[1] = texelFetch(tAQQColB, ivec2(0.0), 0).xyz;
    Aqq[2] = texelFetch(tAQQColC, ivec2(0.0), 0).xyz;

    mat3 Apq = mat3(0.0);
    Apq[0] = texelFetch(tAPQColA, ivec2(0.0), 0).xyz;
    Apq[1] = texelFetch(tAPQColB, ivec2(0.0), 0).xyz;
    Apq[2] = texelFetch(tAPQColC, ivec2(0.0), 0).xyz;

    mat3 A = Apq; //we are only interested in extracting the rotaional part from apq
    vec4 q = mix(texelFetch(tPrevR, ivec2(0.0), 0), normalize(mat3ToQuat(A)), uFirstTick);

    //src:
    //https://matthias-research.github.io/pages/publications/stablePolarDecomp.pdf
    for (int i = 0; i < 10; i++) {
        mat3 R = quatToMat3(q);
        vec3 numerator = cross(A[0], R[0]) + cross(A[1], R[1]) + cross(A[2], R[2]);
        float denom = abs(dot(A[0], R[0]) + dot(A[1], R[1]) + dot(A[2], R[2]));
        vec3 omega = (numerator / denom) + EPS;
        float w = length(omega);
        if(w < EPS) break;

        vec4 rotationQuaternion = quaternionFromAngleAxis(w, omega / w);
        q = multiplyQuaternions(q, rotationQuaternion);
        q = normalize(q);
    }

    gl_Position = vec4(vec2(0.5), 0.0, 1.0);
    gl_PointSize = 1.0;
    vRotation = q;

    mat3 ApqAqq = Apq * inverse(Aqq); //used for linear deformations..
    vAcolA = ApqAqq[0];
    vAcolB = ApqAqq[1];
    vAcolC = ApqAqq[2];

}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
layout(location = 2) out vec4 data3;
layout(location = 3) out vec4 data4;
void main() {
    data1 = normalize(vRotation);
    data2 = vec4(vAcolA, 1.0);
    data3 = vec4(vAcolB, 1.0);
    data4 = vec4(vAcolC, 1.0);

}
{@}GrabConstraint.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tInteractionData;

uniform float uApplyInput;

uniform vec3 uHitData;
uniform vec3 uRayOrigin;
uniform vec3 uRayDirection;

uniform float uPullRadius;

uniform float uTextureSize;
uniform float uVertexCount;

uniform float uDeltaTime;

#!VARYINGS
varying vec3 vCorrectedPos;

#!SHADER: Vertex
#require(getCoord.glsl)
#require(quatToMat.glsl)

float falloff(float distance, float radius) {
    float t = clamp(distance / radius, 0.0, 1.0);
    float p = (distance / radius);
    return exp(-p * p);
}

void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texelFetch(tSolvedPosition, iCoord, 0).xyz;

    vec3 correction = vec3(0.0);

    //TODO: decrease the hit ray based on distance
    if((uApplyInput > 0.0) && (uHitData.x > -1.0) && (uHitData.z >= 1.0)) {
        vec3 targetPosition = uRayOrigin + uRayDirection * (uHitData.y * 0.97);
        targetPosition = mix(targetPosition, (uRayOrigin + uRayDirection), smoothstep(0.0, 0.3, length(uRayDirection.xy)));
        vec3 grabDir = targetPosition - pos;
        float dist = length(grabDir);
        float restLen = texelFetch(tInteractionData, iCoord, 0).x;
        float falloffValue = falloff(restLen, uPullRadius);
        grabDir /= dist;
        if(dist > 0.0 && (dist > restLen)) correction += (dist - restLen) * grabDir * falloffValue;
    }

    pos += correction;

    vCorrectedPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vCorrectedPos, 1.0);
}
{@}InitConstraints.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPosition;
uniform sampler2D tInitPositions;
uniform float uTextureSize;

#!VARYINGS
varying vec3 vCorrectedPos;

#!SHADER: Vertex
#require(getCoord.glsl)

void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 correction = vec3(0.0);
    vec3 pos = texelFetch(tPosition, iCoord, 0).xyz;

    //    vec3 centerOfMass = texture2D(tCurrentCenterOfMass, vec2(0.5)).xyz / uVertexCount;
    //    vec3 initPositions = texture2D(tInitRelativePosition, coord).xyz;
    vec4 initPositions = texelFetch(tInitPositions, iCoord, 0);
    float restLength = initPositions.w;
    vec3 dir = initPositions.xyz - pos;
    float len = length(pos);
//    dir /= len;
    if(len > restLength) correction += dir * (len - restLength);
    pos += correction;

    vCorrectedPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vCorrectedPos, 1.0);
}
{@}PredictPosition.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tCurrentPosition;
uniform sampler2D tVelocity;
uniform sampler2D tData;
uniform sampler2D tInputForce;

uniform float uTextureSize;
uniform float uVertexCount;
uniform float uDeltaTime;
uniform float uHitForceStrength;

uniform float uHit;
uniform float uApplyHitting;

uniform mat4 uProjectionMatrix;
uniform mat4 uViewMatrix;

uniform float uGravity;

#!VARYINGS
varying vec3 vPredictedPos;
varying vec3 vCurrentPos;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texelFetch(tCurrentPosition, iCoord, 0).xyz;
    vCurrentPos = pos;

    vec3 vel = texelFetch(tVelocity, iCoord, 0).xyz;
    vel.y -= uGravity * uDeltaTime;

    pos += vel * uDeltaTime;

    if(uApplyHitting > 0.5) {
        vec4 clipPos = uProjectionMatrix * uViewMatrix * vec4(pos, 1.0);
        clipPos /= clipPos.w;

        vec2 inputForce = texture2D(tInputForce, clipPos.xy * 0.5 + 0.5).xy;

        vec3 dir = normalize(pos);
        float p = smoothstep(-0.8, 1.0, dot(vec3(0.0, 0.0, 1.0), dir));

        pos.xy += inputForce * uHitForceStrength * uDeltaTime * uHit;
    }

    vPredictedPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

#!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
void main() {

    data1 = vec4(vPredictedPos, 1.0);
    data2 = vec4(vCurrentPos, 1.0);

}
{@}RelativePosition.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPosition;
uniform sampler2D tCenterOfMass;

uniform float uTextureSize;
uniform float uVertexCount;
uniform float uIsQ;

#!VARYINGS
varying vec3 vPos;

#!SHADER: Vertex
#require(getCoord.glsl)

void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texelFetch(tPosition, iCoord, 0).xyz;
    vec3 centerOfMass = texelFetch(tCenterOfMass, ivec2(0), 0).xyz / uVertexCount;

    vPos = pos - centerOfMass;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vPos, 1.0);
}
{@}UpdateNormals.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNormal;
uniform sampler2D tRotation;
uniform float uTextureSize;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: Vertex
#require(quatToMat.glsl)
#require(getCoord.glsl)

vec3 rotateVectorWithQuaternion(vec4 quaternion, vec3 vector) {
    vec3 t = 2.0 * cross(quaternion.xyz, vector);
    vec3 result = vector + quaternion.w * t + cross(quaternion.xyz, t);
    return result;
}

void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    mat3 R = quatToMat3(texelFetch(tRotation, ivec2(0.0), 0));
    vec3 normal = texelFetch(tNormal, iCoord, 0).xyz;

    vNormal = R * normal;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(normalize(vNormal), 1.0);
}
{@}UpdateVelocity.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tPrevPosition;

uniform float uTextureSize;
uniform float uDeltaTime;
uniform float uInertia;
uniform float uVelocitySleepThreshold;
uniform float uApplyVelocitySleep;

#!VARYINGS
varying vec3 vVelocity;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 currentPos = texelFetch(tSolvedPosition, iCoord, 0).xyz;
    vec3 prevPos = texelFetch(tPrevPosition, iCoord, 0).xyz;

    vVelocity = (currentPos - prevPos) / uDeltaTime;
    vVelocity *= uInertia;
    if((length(vVelocity) <= uVelocitySleepThreshold) && (uApplyVelocitySleep > 0.5)) vVelocity *= 0.9;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vVelocity, 1.0);
}
{@}ApplyGoalPositionsClustered.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tInitRelativePosition;
uniform sampler2D tCurrentCenterOfMass;

uniform sampler2D tRotationMatrixColA;
uniform sampler2D tRotationMatrixColB;
uniform sampler2D tRotationMatrixColC;

uniform float uAlpha;

uniform float uTextureSize;
uniform float uDeltaTime;

uniform float uTileCount;
uniform float uTileSize;
uniform float uBucketCount;

#!VARYINGS
varying vec3 vPos;

#!SHADER: Vertex
#require(getCoord.glsl)

vec3 getGoalPosition(float vertexIndex, float bucketIndex, in vec3 pos, out float inCluster) {

    vec2 localTileCoord = getCoord(vertexIndex, uTextureSize) * (1.0 / uTileCount);

    float offsetX = mod(bucketIndex, uTileCount) / uTileCount;
    float offsetY = floor(bucketIndex / uTileCount) / uTileCount;
    vec2 tileCoord = vec2(offsetX, offsetY);

    vec2 coord = localTileCoord + tileCoord;
    vec4 centerOfMass = texture2D(tCurrentCenterOfMass, getCoord(bucketIndex, uTileCount));

    //w contains cluster count
    if((centerOfMass.w - 1.0) <= 0.0) {
        inCluster = 0.0;
        return vec3(0.0);
    }

    centerOfMass /=  max(1.0, (centerOfMass.w - 1.0));

    vec4 initRelativePosition = texture2D(tInitRelativePosition, coord); //w contains cluster count

    //check if there is any data present, if not: return no goal position
    if(dot(initRelativePosition.xyz, initRelativePosition.xyz) <= 0.0) {
        inCluster = 0.0;
        return vec3(0.0);
    }
    tileCoord = getCoord(bucketIndex, uTileCount);

    mat3 rotationMatrix = mat3(0.0);
    rotationMatrix[0] = texture2D(tRotationMatrixColA, tileCoord).xyz;
    rotationMatrix[1] = texture2D(tRotationMatrixColB, tileCoord).xyz;
    rotationMatrix[2] = texture2D(tRotationMatrixColC, tileCoord).xyz;
    vec3 goalPosition = (rotationMatrix * initRelativePosition.xyz) + centerOfMass.xyz;

    inCluster = 1.0;
    return uAlpha * (goalPosition - pos);
}

void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texture2D(tSolvedPosition, coord).xyz;
    vec3 finalGoalPos = vec3(0.0);
    float clusterCountSum = 0.0;
    float clusterCount = 0.0;
    for(float i = 0.0; i < uBucketCount; i++) {
        float inCluster;
        finalGoalPos += getGoalPosition(index, i, pos, inCluster);
        clusterCount += inCluster;
    }
    float compliance = 1.0 / (1.0 + 30.0);
    if(clusterCount > 0.0) pos += finalGoalPos * (1.0 / clusterCount) * compliance;
//    if(clusterCount > 0.0) pos += finalGoalPos * compliance;

    vPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vPos, 1.0);
}
{@}CalculateMatrixClustered.glsl{@}#!ATTRIBUTES
//x: local texture coordinate along x
//y: local texture coordinate along y
//z: vertex ID
//w: bucket index;
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tP;
uniform sampler2D tQ;
uniform float isQQ;

#!VARYINGS
varying vec3 vColA;
varying vec3 vColB;
varying vec3 vColC;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {

    vec3 p = texture2D(tP, data.xy).xyz;
    vec3 q = texture2D(tQ, data.xy).xyz;

//    mat3 pqT = outerProduct(p, q);
//    vColA = pqT[0];
//    vColB = pqT[1];
//    vColC = pqT[2];
    vColA = p * q.x;
    vColB = p * q.y;
    vColC = p * q.z;


    gl_Position = vec4(data.xy * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
layout(location = 2) out vec4 data3;
void main() {
    data1 = vec4(vColA, 1.0);
    data2 = vec4(vColB, 1.0);
    data3 = vec4(vColC, 1.0);
}
{@}ClusterTest.glsl{@}#!ATTRIBUTES
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tPositions;
uniform float uTextureSize;

#!VARYINGS
//varying vec2 vData;
varying vec3 vData;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(data.xy * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;

    float posX = mod(data.z, uTextureSize) + 0.5;
    float posY = floor(data.z / uTextureSize) + 0.5;
    vec2 coord = vec2(posX, posY)/ uTextureSize;

    vec3 pos = texture2D(tPositions, coord).xyz;

    vData = pos;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vData, 1.0);
}
{@}ConstructMatrixClustered.glsl{@}#!ATTRIBUTES
//x: local texture coordinate along x
//y: local texture coordinate along y
//z: vertex ID
//w: bucket index;
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tAPQColA;
uniform sampler2D tAPQColB;
uniform sampler2D tAPQColC;

uniform sampler2D tAQQColA;
uniform sampler2D tAQQColB;
uniform sampler2D tAQQColC;

uniform float uBeta;
uniform float uTileCount;

#!VARYINGS
varying vec3 vMatrixColA;
varying vec3 vMatrixColB;
varying vec3 vMatrixColC;

#!SHADER: Vertex
#require(getCoord.glsl)

mat3 DB_sqrtm(mat3 A) {
    mat3 Y = A;
    mat3 Z = mat3(1.0);

    int num_iterations = 20;

    for (int i = 0; i < num_iterations; i++) {
        mat3 Y_old = Y;
        Y = 0.5 * (Y_old + inverse(Z));
        Z = 0.5 * (Z + inverse(Y_old));
    }

    return Y;
}


void main() {

    vec2 bucketCoord = getCoord(float(gl_VertexID), uTileCount);

    mat3 Apq = mat3(0.0);
    Apq[0] = texture2D(tAPQColA, bucketCoord).xyz;
    Apq[1] = texture2D(tAPQColB, bucketCoord).xyz;
    Apq[2] = texture2D(tAPQColC, bucketCoord).xyz;

    mat3 Aqq = mat3(0.0);
    Aqq[0] = texture2D(tAQQColA, bucketCoord).xyz;
    Aqq[1] = texture2D(tAQQColB, bucketCoord).xyz;
    Aqq[2] = texture2D(tAQQColC, bucketCoord).xyz;

    Aqq = inverse(Aqq);
    mat3 A = Apq * Aqq; //note the inverse of AQQ can be pre-computed
//    float det = determinant(A);
//    if(abs(det) > 0.0) A /= pow(det, 1.0 / 3.0);
//    A /= pow(det, 1.0 / 3.0);

    mat3 ATpq = transpose(Apq);
    mat3 S = ATpq * Apq;
    mat3 Z = mat3(1.0);

    float _k = 0.5;
    //denman-beavers iterative solver for square root matrices
    for(int i = 0; i < 60; i++) {
        mat3 sPrev = S;
        S = _k * (sPrev + inverse(Z));
        Z = _k * (Z + inverse(sPrev));
    }

    mat3 R = Apq * inverse(S);

    float det = determinant(A);
    A /= pow(det, 1.0 / 3.0);
//    A *= 1.0/pow(det, 1.0 / 3.0);
    mat3 finalMatrix = uBeta * A + (1.0 - uBeta) * R;

    //hack to manually re-orient matrix to be positive if it manages to get inverted..
    float determinantFinal = determinant(finalMatrix);
    if (determinantFinal < 0.0) finalMatrix = -finalMatrix;
//    float det = determinant(finalMatrix);
//    if(abs(det) > 0.0) finalMatrix /= pow(det, 1.0 / 3.0);

    vec3 c = vec3(data.xy, 0.0);

    vMatrixColA = finalMatrix[0];
    vMatrixColB = finalMatrix[1];
    vMatrixColC = finalMatrix[2];

    gl_Position = vec4(2.0 * data.xy - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
layout(location = 2) out vec4 data3;
void main() {
    data1 = vec4(vMatrixColA, 1.0);
    data2 = vec4(vMatrixColB, 1.0);
    data3 = vec4(vMatrixColC, 1.0);
}

{@}RelativePositionClustered.glsl{@}#!ATTRIBUTES
//x: local texture coordinate along x
//y: local texture coordinate along y
//z: vertex ID of bucket element
//w: bucket index;
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tPosition;
uniform sampler2D tCenterOfMass;

uniform float uTextureSize;
uniform float uTileCount;

#!VARYINGS
varying vec3 vPos;
varying float vClusterSize;

#!SHADER: Vertex
#require(getCoord.glsl)

void main() {

    gl_Position = vec4(data.xy * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;

    vec3 pos = texture2D(tPosition, data.xy).xyz;

    vec2 tileCoord = getCoord(data.w, uTileCount);
    vec4 centerOfMass = texture2D(tCenterOfMass, tileCoord); //alpha contains the amount of particles in a given cluster
    centerOfMass /= max(1.0, (centerOfMass.w - 1.0));

    vPos = pos - centerOfMass.xyz;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vPos, 1.0);
}
{@}UpdateClusterData.glsl{@}#!ATTRIBUTES
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uTextureSize;

#!VARYINGS
//varying vec2 vData;
varying vec3 vData;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    gl_Position = vec4(data.xy * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;

    vec2 coord = getCoord(data.z, uTextureSize);
    vec3 pos = texture2D(tMap, coord).xyz;
    vData = pos;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vData, 1.0);
}
{@}UpdateNormalsClustered.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNormal;

uniform sampler2D tRotationMatrixColA;
uniform sampler2D tRotationMatrixColB;
uniform sampler2D tRotationMatrixColC;

uniform float uTextureSize;

uniform float uTileCount;
uniform float uTileSize;
uniform float uBucketCount;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: Vertex
#require(getCoord.glsl)

vec3 getRotatedNormal(in float vertexIndex, in float bucketIndex, out float inCluster) {

    vec2 localTileCoord = getCoord(vertexIndex, uTextureSize) * (1.0 / uTileCount);

    float offsetX = mod(bucketIndex, uTileCount) / uTileCount;
    float offsetY = floor(bucketIndex / uTileCount) / uTileCount;
    vec2 tileCoord = vec2(offsetX, offsetY);

    vec2 coord = localTileCoord + tileCoord;

    vec3 relativeNormal = texture2D(tNormal, coord).xyz;
    if(dot(relativeNormal, relativeNormal) <= 0.0) {
        inCluster = 0.0;
        return vec3(0.0);
    }

    tileCoord = getCoord(bucketIndex, uTileCount);

    mat3 R = mat3(0.0);
    R[0] = texture2D(tRotationMatrixColA, tileCoord).xyz;
    R[1] = texture2D(tRotationMatrixColB, tileCoord).xyz;
    R[2] = texture2D(tRotationMatrixColC, tileCoord).xyz;

    inCluster = 1.0;
    return R * relativeNormal;

}

void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    float clusterCount = 0.0;
    vec3 normal = vec3(0.0);

    for(float i = 0.0; i < uBucketCount; i++) {
        float inCluster;
        normal += getRotatedNormal(index, i, inCluster);
        clusterCount += inCluster;
    }

//    if(clusterCount > 0.0) normal * (1.0 / clusterCount);
//    if(clusterCount > 0.0) normal;
    vNormal = clusterCount > 0.0 ? normalize(normal) : vec3(0.0);

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vNormal, 1.0);
}
{@}interaction.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPositionData;
uniform float uTextureSize;

uniform vec3 uHitData;
uniform vec3 uRayOrigin;
uniform vec3 uRayDirection;

#!VARYINGS
varying vec3 vData;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {

    float index = float(gl_VertexID);
    ivec2 iCoord = getCoordI(index, uTextureSize);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texelFetch(tPositionData, iCoord, 0).xyz;

    vec3 interactionPos = uRayOrigin + uRayDirection * uHitData.y;

    float dist = length(interactionPos - pos);
    vData = vec3(dist, 0.0, 0.0);

    gl_Position = vec4(coord * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vData, 1.0);
}
{@}rotoationMatrixIrving.glsl{@}////credits to - Irving et al.
////src: https://matthias-research.github.io/pages/publications/stablePolarDecomp.pdf
#define FLT_MAX 1e37

void jacobiRotate(inout mat3 A, inout mat3 R, int p, int q)
{
    if (A[p][q] == 0.0)
    return;

    float d = (A[p][p] - A[q][q]) / (2.0 * A[p][q]);
    float t = 1.0 / (abs(d) + sqrt(d * d + 1.0));
    if (d < 0.0)
    t = -t;

    float c = 1.0 / sqrt(t * t + 1.0);
    float s = t * c;

    A[p][p] += t * A[p][q];
    A[q][q] -= t * A[p][q];
    A[p][q] = A[q][p] = 0.0;

    for (int k = 0; k < 3; k++)
    {
        if (k != p && k != q)
        {
            float Akp = c * A[k][p] + s * A[k][q];
            float Akq = -s * A[k][p] + c * A[k][q];
            A[k][p] = A[p][k] = Akp;
            A[k][q] = A[q][k] = Akq;
        }
    }

    for (int k = 0; k < 3; k++)
    {
        float Rkp = c * R[k][p] + s * R[k][q];
        float Rkq = -s * R[k][p] + c * R[k][q];
        R[k][p] = Rkp;
        R[k][q] = Rkq;
    }
}

void eigenDecomposition(mat3 A, mat3 eigenvecs, vec3 eigenvals)
{
    const int numJacobiIterations = 10;
    const float epsilon = 1e-15;
    mat3 D = A;
    eigenvecs = mat3(1.0);
    int iter = 0;

    while (iter < numJacobiIterations)
    {
        int p, q;
        float a, max;
        max = abs(D[0][1]);
        p = 0;
        q = 1;
        a = abs(D[0][2]);

        if (a > max)
        {
            p = 0;
            q = 2;
            max = a;
        }

        a = abs(D[1][2]);

        if (a > max)
        {
            p = 1;
            q = 2;
            max = a;
        }

        if (max < epsilon)
        break;

        jacobiRotate(D, eigenvecs, p, q);
        iter++;
    }

    eigenvals[0] = D[0][0];
    eigenvals[1] = D[1][1];
    eigenvals[2] = D[2][2];
}

mat3 rotationMatrixIrving(in mat3 A)
{
    mat3 AT_A = transpose(A) * A;
    mat3 V;
    vec3 S;
    eigenDecomposition(AT_A, V, S);

    float detV = determinant(V);
    if (detV < 0.0)
    {
        float minLambda = (FLT_MAX);
        int pos = 0;

        for (int l = 0; l < 3; l++)
        {
            if (S[l] < minLambda)
            {
                pos = l;
                minLambda = S[l];
            }
        }

        V[0][pos] = -V[0][pos];
        V[1][pos] = -V[1][pos];
        V[2][pos] = -V[2][pos];
    }

    for (int i = 0; i < 3; i++)
    {
        if (S[i] < 0.0)
        S[i] = 0.0;
    }

    vec3 sigma = sqrt(S);

    int chk = 0;
    int pos = 0;
    mat3 U;

    for (int l = 0; l < 3; l++)
    {
        if (abs(sigma[l]) < 1.0e-4)
        {
            pos = l;
            chk++;
        }
    }

    if (chk > 0)
    {
        if (chk > 1)
        {
            U = mat3(1.0);
        }
        else
        {
            U = A * V;

            for (int l = 0; l < 3; l++)
            {
                if (l != pos)
                {
                    for (int m = 0; m < 3; m++)
                    {
                        U[m][l] *= 1.0 / sigma[l];
                    }
                }
            }

            vec3 v[2];
            int index = 0;

            for (int l = 0; l < 3; l++)
            {
                if (l != pos)
                {
                    v[index++] = vec3(U[0][l], U[1][l], U[2][l]);
                }
            }

            vec3 vec = cross(v[0], v[1]);
            vec = normalize(vec);
            U[0][pos] = vec[0];
            U[1][pos] = vec[1];
            U[2][pos] = vec[2];
        }
    }
    else
    {
        vec3 sigmaInv = vec3(1.0 / sigma[0], 1.0 / sigma[1], 1.0 / sigma[2]);
        U = A * V;

        for (int l = 0; l < 3; l++)
        {
            for (int m = 0; m < 3; m++)
            {
                U[m][l] *= sigmaInv[l];
            }
        }
    }

    float detU = determinant(U);
    if (detU < 0.0)
    {
        float minLambda = (FLT_MAX);
        int pos = 0;

        for (int l = 0; l < 3; l++)
        {
            if (sigma[l] < minLambda)
            {
                pos = l;
                minLambda = sigma[l];
            }
        }

        sigma[pos] = -sigma[pos];
        U[0][pos] = -U[0][pos];
        U[1][pos] = -U[1][pos];
        U[2][pos] = -U[2][pos];
    }

    return U * transpose(V);
}
{@}CopyData.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
}
{@}Reduce.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uSize;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

    #!SHADER: Fragment
void main() {

    vec2 coord = floor(vUv * uSize) / uSize;
    float stp = (1.0 / uSize)*0.5;

    vec3 a = texture2D(tMap, coord + vec2(0.0)).xyz;
    vec3 b = texture2D(tMap, coord + vec2(stp, 0.0)).xyz;
    vec3 c = texture2D(tMap, coord + vec2(0.0, stp)).xyz;
    vec3 d = texture2D(tMap, coord + vec2(stp)).xyz;

    gl_FragColor.xyz = a + b + c + d;
    gl_FragColor.a = 1.0;
}
{@}ReduceMrt.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tX;
uniform sampler2D tY;
uniform sampler2D tZ;
uniform float uSize;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
layout(location = 2) out vec4 data3;
void main() {

    vec2 coord = floor(vUv * uSize) / uSize;
    float stp = (1.0 / uSize) * 0.5;

    vec3 ax = texture2D(tX, coord + vec2(0.0)).xyz;
    vec3 bx = texture2D(tX, coord + vec2(stp, 0.0)).xyz;
    vec3 cx = texture2D(tX, coord + vec2(0.0, stp)).xyz;
    vec3 dx = texture2D(tX, coord + vec2(stp)).xyz;

    data1.xyz = ax + bx + cx + dx;
    data1.w = 1.0;

    vec3 ay = texture2D(tY, coord + vec2(0.0)).xyz;
    vec3 by = texture2D(tY, coord + vec2(stp, 0.0)).xyz;
    vec3 cy = texture2D(tY, coord + vec2(0.0, stp)).xyz;
    vec3 dy = texture2D(tY, coord + vec2(stp)).xyz;

    data2.xyz = ay + by + cy + dy;
    data2.w = 1.0;

    vec3 az = texture2D(tZ, coord + vec2(0.0)).xyz;
    vec3 bz = texture2D(tZ, coord + vec2(stp, 0.0)).xyz;
    vec3 cz = texture2D(tZ, coord + vec2(0.0, stp)).xyz;
    vec3 dz = texture2D(tZ, coord + vec2(stp)).xyz;

    data3.xyz = az + bz + cz + dz;
    data3.w = 1.0;

}
{@}Sum.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uTextureSize;

#!VARYINGS
varying vec4 vData;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    gl_Position = vec4(vec2(0.5), 0.0, 1.0);
    vec2 coord = getCoord(float(gl_VertexID), uTextureSize);
    vData = texelFetch(tMap, ivec2(coord * uTextureSize), 0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vData;
}
{@}SumBuckets.glsl{@}#!ATTRIBUTES
//x: local texture coordinate along x
//y: local texture coordinate along y
//z: vertex ID of bucket element
//w: bucket index;
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uTileCount;
uniform float uTextureSize;

#!VARYINGS
varying vec4 vData;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {

    vec2 coord = getCoord(data.w, uTileCount);
    gl_Position = vec4(coord * 2.0 - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    vData = texture2D(tMap, data.xy);
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vData;
//    gl_FragColor.a = dot(vData, vData) > 0.0 ? 1.0 : 0.0;
    gl_FragColor.a = 1.0;
}
{@}getCoord.glsl{@}vec2 getCoord(float i, float size) {
    float posX = mod(i, size) + 0.5;
    float posY = floor(i / size) + 0.5;
    return vec2(posX, posY) / size;
}

ivec2 getCoordI(float i, float size) {
    float posX = mod(i, size);
    float posY = floor(i / size);
    return ivec2(posX, posY);
}
{@}quatToMat.glsl{@}mat3 quatToMat3(in vec4 q) {
    float x2 = q.x + q.x;
    float y2 = q.y + q.y;
    float z2 = q.z + q.z;

    float xx = q.x * x2;
    float xy = q.x * y2;
    float xz = q.x * z2;

    float yy = q.y * y2;
    float yz = q.y * z2;
    float zz = q.z * z2;

    float wx = q.w * x2;
    float wy = q.w * y2;
    float wz = q.w * z2;

    mat3 result;
    result[0] = vec3(1.0 - (yy + zz), xy - wz, xz + wy);
    result[1] = vec3(xy + wz, 1.0 - (xx + zz), yz - wx);
    result[2] = vec3(xz - wy, yz + wx, 1.0 - (xx + yy));

    return result;
}

vec4 mat3ToQuat(mat3 m) {
    float tr = m[0][0] + m[1][1] + m[2][2];
    float h;
    vec4 q;

    if (tr >= 0.0) {
        h = sqrt(tr + 1.0);
        q.w = 0.5 * h;
        h = 0.5 / h;

        q.x = (m[2][1] - m[1][2]) * h;
        q.y = (m[0][2] - m[2][0]) * h;
        q.z = (m[1][0] - m[0][1]) * h;
    } else {
        int i = 0;
        if (m[1][1] > m[0][0]) i = 1;
        if (m[2][2] > m[i][i]) i = 2;

        if (i == 0) {
            h = sqrt((m[0][0] - (m[1][1] + m[2][2])) + 1.0);
            q.x = 0.5 * h;
            h = 0.5 / h;

            q.y = (m[0][1] + m[1][0]) * h;
            q.z = (m[2][0] + m[0][2]) * h;
            q.w = (m[2][1] - m[1][2]) * h;
        } else if (i == 1) {
            h = sqrt((m[1][1] - (m[2][2] + m[0][0])) + 1.0);
            q.y = 0.5 * h;
            h = 0.5 / h;

            q.z = (m[1][2] + m[2][1]) * h;
            q.x = (m[0][1] + m[1][0]) * h;
            q.w = (m[0][2] - m[2][0]) * h;
        } else {
            h = sqrt((m[2][2] - (m[0][0] + m[1][1])) + 1.0);
            q.z = 0.5 * h;
            h = 0.5 / h;

            q.x = (m[2][0] + m[0][2]) * h;
            q.y = (m[1][2] + m[2][1]) * h;
            q.w = (m[1][0] - m[0][1]) * h;
        }
    }

    return q;
}

{@}ApplyEdgeConstraints.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tCorrections;
uniform float uTextureSize;

#!VARYINGS
varying vec3 vCorrectedPos;

#!SHADER: Vertex
#require(getCoord.glsl)

void main() {

    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texture2D(tSolvedPosition, coord).xyz;
    vec4 corrections = texture2D(tCorrections, coord);

    if(corrections.w > 0.0) pos += (corrections.xyz / corrections.w);
    vCorrectedPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vCorrectedPos, 1.0);
}
{@}AttachmentConstraints.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tPredictedPosition;
uniform sampler2D tAttachmentPoints;
uniform sampler2D tInitPosition;
uniform float uTextureSize;
uniform float uRadius;

#!VARYINGS
varying vec3 vCorrectedPos;

#!SHADER: Vertex
#require(getCoord.glsl)

void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texture2D(tPredictedPosition, coord).xyz;
    vec3 attachmentPoint = texture2D(tAttachmentPoints, coord).xyz;

    vec3 correction = vec3(0.0);

    vec3 dir = attachmentPoint - pos;
    float dist = length(dir);
    dir /= dist;

    float restLen = length(texture2D(tInitPosition, coord).xyz);
//    float r = 0.0043;
//    float r = 0.0083;
//    float r = 0.0001;
//    float r = 0.005912090088251226;
    float r = 0.001;
//    float r = 0.009690047290831961 * 0.35;
//    float r = restLen * 0.015;


//    float r = 0.0043*0.5;
//    float r = 0.0025 + restLen * 0.001;

//    if(dist > r) correction += dir * (dist - r) * 0.5;
//    if(dist > r) correction += dir * (dist - r) * mix(0.25, 0.5, restLen);
    if(dist > r) correction += dir * (dist - r) * 0.5;
    vCorrectedPos = pos + correction;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vCorrectedPos, 1.0);
}
{@}AttachmentPoints.glsl{@}#!ATTRIBUTES
attribute vec3 indicies;
attribute vec3 weights;

#!UNIFORMS
uniform sampler2D tPositions;
uniform sampler2D tNormals;

uniform sampler2D tIndex;
uniform sampler2D tWeights;

uniform float uTextureSize;
uniform float uRefMeshTextureSize;

#!VARYINGS
varying vec3 vPos;
varying float vScale;

#!SHADER: Vertex
#require(getCoord.glsl)

//PN Triangle mapping based on Alex Vlachos paper "Curved PN Triangles"
//this is process is required to smoothen out the surfaces on the wrinkle mesh
void main() {

    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 bIndex = texture2D(tIndex, coord).xyz;
//    vec3 bIndex = indicies;

    vec2 iCoord = getCoord(bIndex.x, uRefMeshTextureSize);
    vec2 jCoord = getCoord(bIndex.y, uRefMeshTextureSize);
    vec2 kCoord = getCoord(bIndex.z, uRefMeshTextureSize);

    vec3 b300 = texture2D(tPositions, kCoord).xyz; //P1
    vec3 b030 = texture2D(tPositions, iCoord).xyz; //P2
    vec3 b003 = texture2D(tPositions, jCoord).xyz; //P3

//    vec3 b300 = texture2D(tPositions, iCoord).xyz; //P1
//    vec3 b030 = texture2D(tPositions, jCoord).xyz; //P2
//    vec3 b003 = texture2D(tPositions, kCoord).xyz; //P3

    vec3 P1 = b300;
    vec3 P2 = b030;
    vec3 P3 = b003;

    vec3 N1 = texture2D(tNormals, kCoord).xyz;
    vec3 N2 = texture2D(tNormals, iCoord).xyz;
    vec3 N3 = texture2D(tNormals, jCoord).xyz;

//    vec3 N1 = texture2D(tNormals, iCoord).xyz;
//    vec3 N2 = texture2D(tNormals, jCoord).xyz;
//    vec3 N3 = texture2D(tNormals, kCoord).xyz;

    float oneOverThree = 1.0 / 3.0;

    vec3 b210 = (2.0 * P1 + P2 - N1 * dot(P2 - P1, N1)) * oneOverThree;
    vec3 b120 = (2.0 * P2 + P1 - N2 * dot(P1 - P2, N2)) * oneOverThree;

    vec3 b021 = (2.0 * P2 + P3 - N2 * dot(P3 - P2, N2)) * oneOverThree;
    vec3 b012 = (2.0 * P3 + P2 - N3 * dot(P2 - P3, N3)) * oneOverThree;

    vec3 b102 = (2.0 * P3 + P1 - N3 * dot(P1 - P3, N3)) * oneOverThree;
    vec3 b201 = (2.0 * P1 + P3 - N1 * dot(P3 - P1, N1)) * oneOverThree;

    vec3 E = (b210 + b120 + b021 + b012 + b102 + b201) / 6.0;
    vec3 V = (P1 + P2 + P3) * oneOverThree;

    vec3 b111 = E + (E - V) * 0.5;

//    vec3 bWeights = texture2D(tWeights, coord).xyz;
    vec3 bWeights = weights;
    float u = bWeights.x;
    float v = bWeights.y;
    float w = bWeights.z;

    float u2 = u * u;
    float v2 = v * v;
    float w2 = w * w;

    float u3 = u * u * u;
    float v3 = v * v * v;
    float w3 = w * w * w;

    vPos = b300 * w3 + b030 * u3 + b003 * v3 +
    b210 * 3.0 * w2 * u + b120 * 3.0 * w * u2 + b201 * 3.0 * w2 * v +
    b021 * 3.0 * u2 * v + b102 * 3.0 * w * v2 + b012 * 3.0 * u * v2 +
    b111 * 6.0 * w * u * v;

//    vPos = (P1 * u) + (P2 * v) + (P3 * w);

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vPos, 1.0);
}
{@}BlitData.glsl{@}#!ATTRIBUTES
attribute vec3 indicies;
attribute vec3 weights;

#!UNIFORMS
uniform float uRenderWeights;
uniform float uTextureSize;

#!VARYINGS
varying vec3 vData;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {

    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vData = mix(indicies, weights, uRenderWeights);

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vData, 1.0);
}
{@}CalcNormalsWrinkle.glsl{@}#!ATTRIBUTES
attribute vec4 data;
//attribute vec3 indicies;
//attribute vec3 weights;

#!UNIFORMS
uniform sampler2D tPositions;
uniform sampler2D tNormals;

uniform sampler2D tIndex;
uniform sampler2D tWeights;

uniform float uTextureSize;
uniform float uRefMeshTextureSize;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: Vertex
#require(getCoord.glsl)

float vij(in vec3 pi, in vec3 pj, in vec3 ni, in vec3 nj) {

    float denom = dot(pj - pi, pj - pi);
    return 2.0 * dot(pj - pi, ni + nj) / denom;

}

void main() {

    float indexA = position.x;
    float indexB = position.y;
    float indexC = position.z;

    vec2 coord = getCoord(indexA, uTextureSize);
    vec2 coordB = getCoord(indexB, uTextureSize);
    vec2 coordC = getCoord(indexC, uTextureSize);

    vec3 vA = texture2D(tPositions, coord).xyz;
    vec3 vB = texture2D(tPositions, coordB).xyz;
    vec3 vC = texture2D(tPositions, coordC).xyz;

    vec3 v0 = (vB - vA);
    vec3 v1 = (vC - vA);

    vNormal = (cross(v0, v1));
    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(normalize(vNormal), 1.0);
}
{@}ConstrainEdges.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform float uTextureSize;

#!VARYINGS
varying vec3 vCorrection;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {

    float indexA = position.x;
    float indexB = position.y;
    float restLength = position.z;

    float index = indexA;
    vec2 coord = getCoord(index, uTextureSize);

    vec3 p = texture2D(tSolvedPosition, coord).xyz;
    vec3 otherPos = texture2D(tSolvedPosition, getCoord(indexB, uTextureSize)).xyz;

    vec3 correction = vec3(0.0);
    float d = restLength;
    vec3 dir = otherPos - p;
    float dist = length(dir);
    dir /= dist;
    if(dist > d) correction = dir * (dist - d) * 0.5;
    vCorrection = correction;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vCorrection, 1.0);
}
{@}PredictPositionWrinkle.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tCurrentPosition;
uniform sampler2D tVelocity;

uniform float uTextureSize;
uniform float uDeltaTime;

#!VARYINGS
varying vec3 vPredictedPos;
varying vec3 vCurrentPos;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 pos = texture2D(tCurrentPosition, coord).xyz;
    vCurrentPos = pos;

    vec3 vel = texture2D(tVelocity, coord).xyz;

    pos += vel * uDeltaTime;
    vPredictedPos = pos;

    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;

}

    #!SHADER: Fragment
layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;
void main() {

    data1 = vec4(vPredictedPos, 1.0);
    data2 = vec4(vCurrentPos, 1.0);

}
{@}UpdatePositionWrinkle.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tAttachmentPosition;

uniform float uTextureSize;
uniform float uDeltaTime;

#!VARYINGS
varying vec3 vPos;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 p = texture2D(tSolvedPosition, coord).xyz;
    vec3 a = texture2D(tAttachmentPosition, coord).xyz;

    vec3 o = p - a;
    vPos = a + o;


    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vPos, 1.0);
}
{@}UpdateVelocityWrinkle.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tSolvedPosition;
uniform sampler2D tPrevPosition;

uniform float uTextureSize;
uniform float uDeltaTime;

#!VARYINGS
varying vec3 vVelocity;

#!SHADER: Vertex
#require(getCoord.glsl)
void main() {
    float index = float(gl_VertexID);
    vec2 coord = getCoord(index, uTextureSize);

    vec3 currentPos = texture2D(tSolvedPosition, coord).xyz;
    vec3 prevPos = texture2D(tPrevPosition, coord).xyz;

    vVelocity = (currentPos - prevPos) / uDeltaTime;
    vVelocity *= 0.9997;
    gl_Position = vec4(2.0 * coord - 1.0, 0.0, 1.0);
    gl_PointSize = 1.0;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vVelocity, 1.0);
}
{@}VFXComposite.fs{@}#test Tests.renderSSAOPlus()
uniform sampler2D tSSAOPlus;
#require(tridither.glsl)
#endtest
uniform sampler2D tDither;

#test Tests.renderSSAO()
#require(ssao.glsl)
#endtest
#require(blendmodes.glsl)


void main() {
    float ssao = 1.0;

    #test Tests.renderSSAO()
		  ssao = getSSAO(vUv);
    #endtest
    #test Tests.renderSSAOPlus()
		ssao = texture2D(tSSAOPlus, vUv).r;
        ssao = dither1(ssao, gl_FragCoord.xy, time);
    #endtest

    vec4 tex = texture2D(tDiffuse, vUv);
    tex.rgb *= pow(ssao*1.05, 1.2);

    vec2 ditherUV = vUv;
    ditherUV.x *= resolution.x * 0.2;
    ditherUV.y *= resolution.y * 0.2;
    float dither = texture2D(tDither, ditherUV).r;
    tex.rgb = blendOverlay(tex.rgb, vec3(dither), 0.6);


    gl_FragColor = tex;
}
{@}SkinShader.glsl{@}#!ATTRIBUTES
attribute vec3 vdata;

#!UNIFORMS
uniform vec3 uColor;
uniform vec3 uColor2;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vWorldPos;
varying vec3 vViewDir;
varying vec3 vNormal2;
varying vec3 vPos;

#!SHADER: Vertex
#require(skinning.glsl)

void main() {
    vec3 pos = position;
    vec3 n = normal;
    vec3 prevPos = pos;
    applySkin(pos, n);

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    vWorldPos = vec3(modelViewMatrix * vec4(pos, 1.0));
    vNormal2 = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(pos, 1.0));
    vPos = pos;

    gl_Position = projectionMatrix * modelViewPos;
    vUv = uv;
    vNormal = normalMatrix * n * vWorldPos;
}

#!SHADER: Fragment

#require(fresnel.glsl)
#require(range.glsl)
#require(simplenoise.glsl)

void main() {
    vec3 color = uColor;//vec3(vNormal.x + vNormal.y, 0.0, 0.5);

    float fresnel = getFresnel(vNormal2, normalize(vViewDir), 1.0);
    //color = mix(color, uColor2, step(0.8, fresnel));

    float lighting = mix(1.0-vNormal2.z, vWorldPos.z, 0.01);
    color = mix(color, uColor2, step(0.0, vPos.z));


    color += vNormal2.x * 0.05;
    color -= vNormal2.y * 0.05;
    color += vNormal2.z * 0.01;

    gl_FragColor = vec4(color, 1.0);
}
{@}SolidColorShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uAlpha;
uniform vec3 uColor; //js new Color()

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vPos = position;
    vWorldPos = vec3(modelMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(lighting.fs)
#require(shadows.fs)
#require(tridither.glsl)
#require(range.glsl)
#require(eases.glsl)

void main() {
    vec2 uv = vUv;
    
    gl_FragColor = vec4(uColor, uAlpha);
}{@}AntimatterSpawn.fs{@}uniform float uMaxCount;
uniform float uSetup;
uniform float decay;
uniform vec2 decayRandom;
uniform sampler2D tLife;
uniform sampler2D tAttribs;
uniform float HZ;

#require(range.glsl)

void main() {
    vec2 uv = vUv;
    #test !window.Metal
    uv = gl_FragCoord.xy / fSize;
    #endtest

    vec4 data = texture2D(tInput, uv);

    if (vUv.x + vUv.y * fSize > uMaxCount) {
        gl_FragColor = vec4(9999.0);
        return;
    }

    vec4 life = texture2D(tLife, uv);
    vec4 random = texture2D(tAttribs, uv);
    if (life.x > 0.5) {
        data.xyz = life.yzw;
        data.x -= 999.0;
    } else {
        if (data.x < -500.0) {
            data.x = 1.0;
        } else {
            data.x -= 0.005 * decay * crange(random.w, 0.0, 1.0, decayRandom.x, decayRandom.y) * HZ;
        }
    }

    if (uSetup > 0.5) {
        data = vec4(0.0);
    }

    gl_FragColor = data;
}{@}curve3d.vs{@}uniform sampler2D tCurve;
uniform float uCurveSize;

vec2 getCurveUVFromIndex(float index) {
    float size = uCurveSize;
    vec2 ruv = vec2(0.0);
    float p0 = index / size;
    float y = floor(p0);
    float x = p0 - y;
    ruv.x = x;
    ruv.y = y / size;
    return ruv;
}

vec3 transformAlongCurve(vec3 pos, float idx) {
    vec3 offset = texture2D(tCurve, getCurveUVFromIndex(idx * (uCurveSize * uCurveSize))).xyz;
    vec3 p = pos;
    p.xz += offset.xz;
    return p;
}
{@}advectionManualFilteringShader.fs{@}varying vec2 vUv;
uniform sampler2D uVelocity;
uniform sampler2D uSource;
uniform vec2 texelSize;
uniform vec2 dyeTexelSize;
uniform float dt;
uniform float dissipation;
vec4 bilerp (sampler2D sam, vec2 uv, vec2 tsize) {
    vec2 st = uv / tsize - 0.5;
    vec2 iuv = floor(st);
    vec2 fuv = fract(st);
    vec4 a = texture2D(sam, (iuv + vec2(0.5, 0.5)) * tsize);
    vec4 b = texture2D(sam, (iuv + vec2(1.5, 0.5)) * tsize);
    vec4 c = texture2D(sam, (iuv + vec2(0.5, 1.5)) * tsize);
    vec4 d = texture2D(sam, (iuv + vec2(1.5, 1.5)) * tsize);
    return mix(mix(a, b, fuv.x), mix(c, d, fuv.x), fuv.y);
}
void main () {
    vec2 coord = vUv - dt * bilerp(uVelocity, vUv, texelSize).xy * texelSize;
    gl_FragColor = dissipation * bilerp(uSource, coord, dyeTexelSize);
    gl_FragColor.a = 1.0;
}{@}advectionShader.fs{@}varying vec2 vUv;
uniform sampler2D uVelocity;
uniform sampler2D uSource;
uniform vec2 texelSize;
uniform float dt;
uniform float dissipation;
void main () {
    vec2 coord = vUv - dt * texture2D(uVelocity, vUv).xy * texelSize;
    gl_FragColor = dissipation * texture2D(uSource, coord);
    gl_FragColor.a = 1.0;
}{@}backgroundShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
uniform float aspectRatio;
#define SCALE 25.0
void main () {
    vec2 uv = floor(vUv * SCALE * vec2(aspectRatio, 1.0));
    float v = mod(uv.x + uv.y, 2.0);
    v = v * 0.1 + 0.8;
    gl_FragColor = vec4(vec3(v), 1.0);
}{@}clearShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
uniform float value;
void main () {
    gl_FragColor = value * texture2D(uTexture, vUv);
}{@}colorShader.fs{@}uniform vec4 color;
void main () {
    gl_FragColor = color;
}{@}curlShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uVelocity;
void main () {
    float L = texture2D(uVelocity, vL).y;
    float R = texture2D(uVelocity, vR).y;
    float T = texture2D(uVelocity, vT).x;
    float B = texture2D(uVelocity, vB).x;
    float vorticity = R - L - T + B;
    gl_FragColor = vec4(0.5 * vorticity, 0.0, 0.0, 1.0);
}{@}displayShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
void main () {
    vec3 C = texture2D(uTexture, vUv).rgb;
    float a = max(C.r, max(C.g, C.b));
    gl_FragColor = vec4(C, a);
}{@}divergenceShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uVelocity;
void main () {
    float L = texture2D(uVelocity, vL).x;
    float R = texture2D(uVelocity, vR).x;
    float T = texture2D(uVelocity, vT).y;
    float B = texture2D(uVelocity, vB).y;
    vec2 C = texture2D(uVelocity, vUv).xy;
   if (vL.x < 0.0) { L = -C.x; }
   if (vR.x > 1.0) { R = -C.x; }
   if (vT.y > 1.0) { T = -C.y; }
   if (vB.y < 0.0) { B = -C.y; }
    float div = 0.5 * (R - L + T - B);
    gl_FragColor = vec4(div, 0.0, 0.0, 1.0);
}
{@}fluidBase.vs{@}varying vec2 vUv;
varying vec2 vL;
varying vec2 vR;
varying vec2 vT;
varying vec2 vB;
uniform vec2 texelSize;

void main () {
    vUv = uv;
    vL = vUv - vec2(texelSize.x, 0.0);
    vR = vUv + vec2(texelSize.x, 0.0);
    vT = vUv + vec2(0.0, texelSize.y);
    vB = vUv - vec2(0.0, texelSize.y);
    gl_Position = vec4(position, 1.0);
}{@}gradientSubtractShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uPressure;
uniform sampler2D uVelocity;
vec2 boundary (vec2 uv) {
    return uv;
    // uv = min(max(uv, 0.0), 1.0);
    // return uv;
}
void main () {
    float L = texture2D(uPressure, boundary(vL)).x;
    float R = texture2D(uPressure, boundary(vR)).x;
    float T = texture2D(uPressure, boundary(vT)).x;
    float B = texture2D(uPressure, boundary(vB)).x;
    vec2 velocity = texture2D(uVelocity, vUv).xy;
    velocity.xy -= vec2(R - L, T - B);
    gl_FragColor = vec4(velocity, 0.0, 1.0);
}{@}pressureShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uPressure;
uniform sampler2D uDivergence;
vec2 boundary (vec2 uv) {
    return uv;
    // uncomment if you use wrap or repeat texture mode
    // uv = min(max(uv, 0.0), 1.0);
    // return uv;
}
void main () {
    float L = texture2D(uPressure, boundary(vL)).x;
    float R = texture2D(uPressure, boundary(vR)).x;
    float T = texture2D(uPressure, boundary(vT)).x;
    float B = texture2D(uPressure, boundary(vB)).x;
    float C = texture2D(uPressure, vUv).x;
    float divergence = texture2D(uDivergence, vUv).x;
    float pressure = (L + R + B + T - divergence) * 0.25;
    gl_FragColor = vec4(pressure, 0.0, 0.0, 1.0);
}{@}splatShader.fs{@}varying vec2 vUv;
uniform sampler2D uTarget;
uniform float aspectRatio;
uniform vec3 color;
uniform vec3 bgColor;
uniform vec2 point;
uniform vec2 prevPoint;
uniform float radius;
uniform float canRender;
uniform float uAdd;

float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}

float l(vec2 uv, vec2 point1, vec2 point2) {
    vec2 pa = uv - point1, ba = point2 - point1;
    pa.x *= aspectRatio;
    ba.x *= aspectRatio;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

float cubicOut(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

void main () {
    vec3 splat = (1.0 - cubicOut(clamp(l(vUv, prevPoint.xy, point.xy) / radius, 0.0, 1.0))) * color;
    vec3 base = texture2D(uTarget, vUv).xyz;
    base *= canRender;

    vec3 outColor = mix(blendScreen(base, splat), base + splat, uAdd);
    gl_FragColor = vec4(outColor, 1.0);
}{@}vorticityShader.fs{@}varying vec2 vUv;
varying vec2 vL;
varying vec2 vR;
varying vec2 vT;
varying vec2 vB;
uniform sampler2D uVelocity;
uniform sampler2D uCurl;
uniform float curl;
uniform float dt;
void main () {
    float L = texture2D(uCurl, vL).x;
    float R = texture2D(uCurl, vR).x;
    float T = texture2D(uCurl, vT).x;
    float B = texture2D(uCurl, vB).x;
    float C = texture2D(uCurl, vUv).x;
    vec2 force = 0.5 * vec2(abs(T) - abs(B), abs(R) - abs(L));
    force /= length(force) + 0.0001;
    force *= curl * C;
    force.y *= -1.0;
//    force.y += 400.3;
    vec2 vel = texture2D(uVelocity, vUv).xy;
    gl_FragColor = vec4(vel + force * dt, 0.0, 1.0);
}{@}FXScrollTransition.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap1;
uniform sampler2D tMap2;
uniform float uTransition;
uniform float uAngle;
uniform float uVelocity;
uniform float uAngleVelocity;
uniform float uRatio;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;

    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
#require(range.glsl)

float aastep(float threshold, float value) {
    float signedDist = threshold - value;
    float d = fwidth(signedDist);
    return 1.0 - smoothstep(-d, d, signedDist);
}

float aastep(float threshold, float value, float padding) {
    return smoothstep(threshold - padding, threshold + padding, value);
}

vec2 aastep(vec2 threshold, vec2 value) {
    return vec2(
        aastep(threshold.x, value.x),
        aastep(threshold.y, value.y)
    );
}

void main() {
    vec2 uv = vUv;

    vec3 color1 = texture2D(tMap1, uv).rgb;
    vec3 color2 = texture2D(tMap2, uv).rgb;

    float inclination = -0.2 * uAngle * uRatio;
    // inclination += -0.2 * uVelocity * uAngleVelocity * uRatio;

    float cut = aastep(uv.y + (uv.x * inclination), crange(uTransition, 0.0, 1.0, inclination, 1.0));
    vec3 color = mix(color1, color2, cut);

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}
{@}AreaLights.glsl{@}mat3 transposeMat3(  mat3 m ) {
	mat3 tmp;
	tmp[ 0 ] = vec3( m[ 0 ].x, m[ 1 ].x, m[ 2 ].x );
	tmp[ 1 ] = vec3( m[ 0 ].y, m[ 1 ].y, m[ 2 ].y );
	tmp[ 2 ] = vec3( m[ 0 ].z, m[ 1 ].z, m[ 2 ].z );
	return tmp;
}

// Real-Time Polygonal-Light Shading with Linearly Transformed Cosines
// by Eric Heitz, Jonathan Dupuy, Stephen Hill and David Neubelt
// code: https://github.com/selfshadow/ltc_code/
vec2 LTC_Uv(  vec3 N,  vec3 V,  float roughness ) {
	float LUT_SIZE  = 64.0;
	float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
	float LUT_BIAS  = 0.5 / LUT_SIZE;
	float dotNV = clamp( dot( N, V ), 0.0, 1.0 );
	// texture parameterized by sqrt( GGX alpha ) and sqrt( 1 - cos( theta ) )
	vec2 uv = vec2( roughness, sqrt( 1.0 - dotNV ) );
	uv = uv * LUT_SCALE + LUT_BIAS;
	return uv;
}

float LTC_ClippedSphereFormFactor(  vec3 f ) {
	// Real-Time Area Lighting: a Journey from Research to Production (p.102)
	// An approximation of the form factor of a horizon-clipped rectangle.
	float l = length( f );
	return max( ( l * l + f.z ) / ( l + 1.0 ), 0.0 );
}

vec3 LTC_EdgeVectorFormFactor(  vec3 v1,  vec3 v2 ) {
	float x = dot( v1, v2 );
	float y = abs( x );
	// rational polynomial approximation to theta / sin( theta ) / 2PI
	float a = 0.8543985 + ( 0.4965155 + 0.0145206 * y ) * y;
	float b = 3.4175940 + ( 4.1616724 + y ) * y;
	float v = a / b;
	float theta_sintheta = ( x > 0.0 ) ? v : 0.5 * inversesqrt( max( 1.0 - x * x, 1e-7 ) ) - v;
	return cross( v1, v2 ) * theta_sintheta;
}

vec3 LTC_Evaluate(  vec3 N,  vec3 V,  vec3 P,  mat3 mInv,  vec3 rectCoords[ 4 ] ) {
	// bail if point is on back side of plane of light
	// assumes ccw winding order of light vertices
	vec3 v1 = rectCoords[ 1 ] - rectCoords[ 0 ];
	vec3 v2 = rectCoords[ 3 ] - rectCoords[ 0 ];
	vec3 lightNormal = cross( v1, v2 );
	if( dot( lightNormal, P - rectCoords[ 0 ] ) < 0.0 ) return vec3( 0.0 );
	// construct orthonormal basis around N
	vec3 T1, T2;
	T1 = normalize( V - N * dot( V, N ) );
	T2 = - cross( N, T1 ); // negated from paper; possibly due to a different handedness of world coordinate system
	// compute transform
	mat3 mat = mInv * transposeMat3( mat3( T1, T2, N ) );
	// transform rect
	vec3 coords[ 4 ];
	coords[ 0 ] = mat * ( rectCoords[ 0 ] - P );
	coords[ 1 ] = mat * ( rectCoords[ 1 ] - P );
	coords[ 2 ] = mat * ( rectCoords[ 2 ] - P );
	coords[ 3 ] = mat * ( rectCoords[ 3 ] - P );
	// project rect onto sphere
	coords[ 0 ] = normalize( coords[ 0 ] );
	coords[ 1 ] = normalize( coords[ 1 ] );
	coords[ 2 ] = normalize( coords[ 2 ] );
	coords[ 3 ] = normalize( coords[ 3 ] );
	// calculate vector form factor
	vec3 vectorFormFactor = vec3( 0.0 );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 0 ], coords[ 1 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 1 ], coords[ 2 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 2 ], coords[ 3 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 3 ], coords[ 0 ] );
	// adjust for horizon clipping
	float result = LTC_ClippedSphereFormFactor( vectorFormFactor );

	return vec3( result );
}{@}Lighting.glsl{@}#!ATTRIBUTES

#!UNIFORMS
struct LightConfig {
    vec3 normal;
    bool phong;
    bool areaToPoint;
    float phongAttenuation;
    float phongShininess;
    vec3 phongColor;
    vec3 lightColor;
    bool overrideColor;
};

uniform sampler2D tLTC1; //ignoreUIL
uniform sampler2D tLTC2; //ignoreUIL

#!VARYINGS
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec3 vViewDir;

#!SHADER: lighting.vs

void setupLight(vec3 p0, vec3 p1) { //inlinemain
    vPos = p0;
    vNormal = normalize(normalMatrix * p1);
    vWorldPos = vec3(modelMatrix * vec4(p0, 1.0));
    vViewDir = -vec3(modelViewMatrix * vec4(p0, 1.0));
}

#test !window.Metal
void setupLight(vec3 p0) {
    setupLight(p0, normal);
}
#endtest

#!SHADER: lighting.fs

#require(LightingCommon.glsl)

void setupLight() {

}
vec3 getCombinedColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = config.overrideColor ? config.lightColor : lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w < 1.0) continue;

        if (lProps.w < 1.1) {
            color += lightDirectional(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 2.1) {
            color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 3.1) {
            color += lightCone(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 4.1) {
            color += lightArea(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
        }
    }

    return lclamp(color);
}

vec3 getCombinedColor(LightConfig config) {
    #test !window.Metal
    return getCombinedColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
    #endtest
    return vec3(0.0);
}

vec3 getCombinedColor() {
    LightConfig config;
    config.normal = vNormal;
    return getCombinedColor(config);
}

vec3 getCombinedColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getCombinedColor(config);
}

vec3 getCombinedColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    LightConfig config;
    config.normal = normal;
    return getCombinedColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
}

vec3 getPointLightColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = config.overrideColor ? config.lightColor : lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w > 1.9 && lProps.w < 2.1) {
            color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getPointLightColor(LightConfig config) {
    #test !window.Metal
    return getPointLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getPointLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getPointLightColor(config);
}

vec3 getPointLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getPointLightColor(config);
}

vec3 getPointLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = normal;
    return getPointLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}

vec3 getAreaLightColor(float roughness, LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    vec3 color = vec3(0.0);

    #test Lighting.fallbackAreaToPointTest()
    config.areaToPoint = true;
    #endtest

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = config.overrideColor ? config.lightColor : lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        lData.w *= roughness;

        if (lProps.w > 3.9 && lProps.w < 4.1) {
            if (config.areaToPoint) {
                color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
            } else {
                color += lightArea(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
            }
        }
    }

    return lclamp(color);
}

vec3 getAreaLightColor(float roughness, LightConfig config) {
    #test !window.Metal
    return getAreaLightColor(roughness, config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
    #endtest
    return vec3(0.0);
}


vec3 getAreaLightColor(float roughness) {
    LightConfig config;
    config.normal = vNormal;
    return getAreaLightColor(roughness, config);
}

vec3 getAreaLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getAreaLightColor(1.0, config);
}

vec3 getAreaLightColor(LightConfig config) {
    return getAreaLightColor(1.0, config);
}

vec3 getAreaLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getAreaLightColor(1.0, config);
}

vec3 getAreaLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    LightConfig config;
    config.normal = normal;
    return getAreaLightColor(1.0, config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
}


vec3 getSpotLightColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = config.overrideColor ? config.lightColor : lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w > 2.9 && lProps.w < 3.1) {
            color += lightCone(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getSpotLightColor(LightConfig config) {
    #test !window.Metal
    return getSpotLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getSpotLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getSpotLightColor(config);
}

vec3 getSpotLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getSpotLightColor(config);
}

vec3 getSpotLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = normal;
    return getSpotLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}


vec3 getDirectionalLightColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = config.overrideColor ? config.lightColor : lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w > 0.9 && lProps.w < 1.1) {
            color += lightDirectional(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getDirectionalLightColor(LightConfig config) {
    #test !window.Metal
    return getDirectionalLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getDirectionalLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getDirectionalLightColor(config);
}

vec3 getDirectionalLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getDirectionalLightColor(config);
}

vec3 getDirectionalLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = vNormal;
    return getDirectionalLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}

vec3 getStandardColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = config.overrideColor ? config.lightColor : lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w < 1.0) continue;

        if (lProps.w < 1.1) {
            color += lightDirectional(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 2.1) {
            color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getStandardColor(LightConfig config) {
    #test !window.Metal
    return getStandardColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getStandardColor() {
    LightConfig config;
    config.normal = vNormal;
    return getStandardColor(config);
}

vec3 getStandardColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getStandardColor(config);
}

vec3 getStandardColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = normal;
    return getStandardColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}
{@}LightingCommon.glsl{@}#require(AreaLights.glsl)

vec3 lworldLight(vec3 lightPos, vec3 localPos, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec4 mvPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(lightPos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}

float lrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    vec3 sub = vec3(oldValue, newMax, oldMax) - vec3(oldMin, newMin, oldMin);
    return sub.x * sub.y / sub.z + newMin;
}

vec3 lclamp(vec3 v) {
    return clamp(v, vec3(0.0), vec3(1.0));
}

float lcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(lrange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

#require(Phong.glsl)

vec3 lightDirectional(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 lDir = lworldLight(lPos, vPos, modelViewMatrix, viewMatrix);
    float volume = dot(normalize(lDir), config.normal);

    return lColor * lcrange(volume, 0.0, 1.0, lProps.z, 1.0);
}

vec3 lightPoint(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    float dist = length(vWorldPos - lPos);
    if (dist > lProps.y) return vec3(0.0);

    vec3 color = vec3(0.0);

    vec3 lDir = lworldLight(lPos, vPos, modelViewMatrix, viewMatrix);
    float falloff = pow(lcrange(dist, 0.0, lProps.y, 1.0, 0.0), 2.0);

    if (config.phong) {
        color += falloff * phong(lProps.x, lColor, config.phongColor, config.phongShininess, config.phongAttenuation, config.normal, normalize(lDir), vViewDir, lProps.z);
    } else {
        float volume = dot(normalize(lDir), config.normal);
        volume = lcrange(volume, 0.0, 1.0, lProps.z, 1.0);
        color += lColor * volume * lProps.x * falloff;
    }

    return color;
}

vec3 lightCone(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    float dist = length(vWorldPos - lPos);
    if (dist > lProps.y) return vec3(0.0);

    vec3 lDir = lworldLight(lPos, vPos, modelViewMatrix, viewMatrix);
    vec3 sDir = degrees(-lData.xyz);
    float radius = lData.w;
    vec3 surfacePos = vWorldPos;
    vec3 surfaceToLight = normalize(lPos - surfacePos);
    float lightToSurfaceAngle = degrees(acos(dot(-surfaceToLight, normalize(sDir))));
    float attenuation = 1.0;

    vec3 nColor = lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);

    float featherMin = 1.0 - lData2.x*0.1;
    float featherMax = 1.0 + lData2.x*0.1;

    attenuation *= smoothstep(lightToSurfaceAngle*featherMin, lightToSurfaceAngle*featherMax, radius);

    nColor *= attenuation;
    return nColor;
}

vec3 lightArea(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    float dist = length(vWorldPos - lPos);
    if (dist > lProps.y) return vec3(0.0);

    vec3 color = vec3(0.0);

    vec3 normal = config.normal;
    vec3 viewDir = normalize(vViewDir);
    vec3 position = -vViewDir;
    float roughness = lData.w;
    vec3 mPos = lData.xyz;
    vec3 halfWidth = lData2.xyz;
    vec3 halfHeight = lData3.xyz;

    float falloff = pow(lcrange(dist, 0.0, lProps.y, 1.0, 0.0), 2.0);

    vec3 rectCoords[ 4 ];
    rectCoords[ 0 ] = mPos + halfWidth - halfHeight;
    rectCoords[ 1 ] = mPos - halfWidth - halfHeight;
    rectCoords[ 2 ] = mPos - halfWidth + halfHeight;
    rectCoords[ 3 ] = mPos + halfWidth + halfHeight;

    vec2 uv = LTC_Uv( normal, viewDir, roughness );

    #test !!window.Metal
    uv.y = 1.0 - uv.y;
    #endtest

    vec4 t1 = texture2D(tLTC1, uv);
    vec4 t2 = texture2D(tLTC2, uv);

    mat3 mInv = mat3(
    vec3( t1.x, 0, t1.y ),
    vec3(    0, 1,    0 ),
    vec3( t1.z, 0, t1.w )
    );

    vec3 fresnel = ( lColor * t2.x + ( vec3( 1.0 ) - lColor ) * t2.y );
    color += lColor * fresnel * LTC_Evaluate( normal, viewDir, position, mInv, rectCoords ) * falloff * lProps.x;
    color += lColor * LTC_Evaluate( normal, viewDir, position, mat3( 1.0 ), rectCoords ) * falloff * lProps.x;

    return color;
}{@}LitMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;

#!SHADER: Vertex

#require(lighting.vs)

void main() {
    vUv = uv;
    vPos = position;
    setupLight(position);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(lighting.fs)
#require(shadows.fs)

void main() {
    setupLight();

    vec3 color = texture2D(tMap, vUv).rgb;
    color *= getShadow(vPos);

    color += getCombinedColor();

    gl_FragColor = vec4(color, 1.0);
}{@}Phong.glsl{@}float pclamp(float v) {
    return clamp(v, 0.0, 1.0);
}

float dPhong(float shininess, float dotNH) {
    return (shininess * 0.5 + 1.0) * pow(dotNH, shininess);
}

vec3 schlick(vec3 specularColor, float dotLH) {
    float fresnel = exp2((-5.55437 * dotLH - 6.98316) * dotLH);
    return (1.0 - specularColor) * fresnel + specularColor;
}

vec3 calcBlinnPhong(vec3 specularColor, float shininess, vec3 normal, vec3 lightDir, vec3 viewDir) {
    vec3 halfDir = normalize(lightDir + viewDir);
    
    float dotNH = pclamp(dot(normal, halfDir));
    float dotLH = pclamp(dot(lightDir, halfDir));

    vec3 F = schlick(specularColor, dotLH);
    float G = 0.85;
    float D = dPhong(shininess, dotNH);
    
    return F * G * D;
}

vec3 calcBlinnPhong(vec3 specularColor, float shininess, vec3 normal, vec3 lightDir, vec3 viewDir, float minTreshold) {
    vec3 halfDir = normalize(lightDir + viewDir);

    float dotNH = pclamp(dot(normal, halfDir));
    float dotLH = pclamp(dot(lightDir, halfDir));

    dotNH = lrange(dotNH, 0.0, 1.0, minTreshold, 1.0);
    dotLH = lrange(dotLH, 0.0, 1.0, minTreshold, 1.0);

    vec3 F = schlick(specularColor, dotLH);
    float G = 0.85;
    float D = dPhong(shininess, dotNH);

    return F * G * D;
}

vec3 phong(float amount, vec3 diffuse, vec3 specular, float shininess, float attenuation, vec3 normal, vec3 lightDir, vec3 viewDir, float minThreshold) {
    float cosineTerm = pclamp(lrange(dot(normal, lightDir), 0.0, 1.0, minThreshold, 1.0));
    vec3 brdf = calcBlinnPhong(specular, shininess, normal, lightDir, viewDir, minThreshold);
    return brdf * amount * diffuse * attenuation * cosineTerm;
}{@}Line.glsl{@}#!ATTRIBUTES
attribute vec3 previous;
attribute vec3 next;
attribute float side;
attribute float width;
attribute float lineIndex;
attribute vec2 uv2;

#!UNIFORMS
uniform float uLineWidth;
uniform float uBaseWidth;
uniform float uOpacity;
uniform vec3 uColor;

#!VARYINGS
varying float vLineIndex;
varying vec2 vUv;
varying vec2 vUv2;
varying vec3 vColor;
varying float vOpacity;
varying float vWidth;
varying float vDist;
varying float vFeather;
varying float vLengthScale;


#!SHADER: Vertex

//params

vec2 fix(vec4 i, float aspect) {
    vec2 res = i.xy / i.w;
    res.x *= aspect;
    return res;
}

void main() {
#test RenderManager.type == RenderManager.VR
    float aspect = (resolution.x / 2.0) / resolution.y;
#endtest
#test RenderManager.type != RenderManager.VR
    float aspect = resolution.x / resolution.y;
#endtest

    vUv = uv;
    vUv2 = uv2;
    vLineIndex = lineIndex;
    vColor = uColor;
    vOpacity = uOpacity;
    vFeather = 0.1;

    vec3 pos = position;
    vec3 prevPos = previous;
    vec3 nextPos = next;
    float lineWidth = 1.0;
    //main

    //startMatrix
    mat4 m = projectionMatrix * modelViewMatrix;
    vec4 finalPosition = m * vec4(pos, 1.0);
    vec4 pPos = m * vec4(prevPos, 1.0);
    vec4 nPos = m * vec4(nextPos, 1.0);
    //endMatrix

    vec2 currentP = fix(finalPosition, aspect);
    vec2 prevP = fix(pPos, aspect);
    vec2 nextP = fix(nPos, aspect);

    float w = uBaseWidth * uLineWidth * width * lineWidth;
    vWidth = w;

    vec4 temp1 = vec4(0.0, 0.0, pos.z, 1.0);
    temp1 = m * temp1;
    vec4 temp2 = vec4(1.0, 0.0, pos.z, 1.0);
    temp2 = m * temp2;
    vLengthScale = abs(temp2.x - temp1.x);

    vec2 dirNC = currentP - prevP;
    vec2 dirPC = nextP - currentP;
    if (length(dirNC) >= 0.0001) dirNC = normalize(dirNC);
    if (length(dirPC) >= 0.0001) dirPC = normalize(dirPC);
    vec2 dir = normalize(dirNC + dirPC);

    //direction
    vec2 normal = vec2(-dir.y, dir.x);
    normal.x /= aspect;
    normal *= 0.5 * w;

    vDist = finalPosition.z / 10.0;

    finalPosition.xy += normal * side;
    gl_Position = finalPosition;
}

#!SHADER: Fragment

//fsparams

void main() {
    float d = (1.0 / (5.0 * vWidth + 1.0)) * vFeather * (vDist * 5.0 + 0.5);
    vec2 uvButt = vec2(0.0, vUv.y);
    float buttLength = 0.5 * vWidth;
    uvButt.x = min(0.5, vUv2.x * vLengthScale / buttLength) + (0.5 - min(0.5, (vUv2.y - vUv2.x) * vLengthScale / buttLength));
    float round = length(uvButt - 0.5);
    float alpha = 1.0 - smoothstep(0.45, 0.5, round);

    /*
        If you're having antialiasing problems try:
        Remove line 93 to 98 and replace with
        `
            float signedDist = tri(vUv.y) - 0.5;
            float alpha = clamp(signedDist/fwidth(signedDist) + 0.5, 0.0, 1.0);

            if (w <= 0.3) {
                discard;
                return;
            }

            where tri function is

            float tri(float v) {
                return mix(v, 1.0 - v, step(0.5, v)) * 2.0;
            }
        `

        Then, make sure your line has transparency and remove the last line
        if (gl_FragColor.a < 0.1) discard;
    */

    vec3 color = vColor;

    gl_FragColor.rgb = color;
    gl_FragColor.a = alpha;
    gl_FragColor.a *= vOpacity;

    //fsmain

    if (gl_FragColor.a < 0.1) discard;
}
{@}MediaPipeIrisTestShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;
uniform float uSize;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
float circle(vec2 coord, float radius) {
    float dist = length(coord);
    float delta = fwidth(dist);
    return 1.0 - smoothstep(-delta, delta, dist - radius);
}

float ring(vec2 coord, float radius, float thickness) {
    float outerCircle = circle(coord, radius);
    float innerCircle = circle(coord, radius - thickness);
    return outerCircle - innerCircle;
}

void main() {
    vec2 uv = vUv - 0.5;
    float alpha = uAlpha * ring(uv, 0.5, 2.0 / uSize);
    gl_FragColor = vec4(uColor, alpha);
}
{@}mousefluid.fs{@}uniform sampler2D tFluid;
uniform sampler2D tFluidMask;

vec2 getFluidVelocity() {
    float fluidMask = smoothstep(0.1, 0.7, texture2D(tFluidMask, vUv).r);
    return texture2D(tFluid, vUv).xy * fluidMask;
}

vec3 getFluidVelocityMask() {
    float fluidMask = smoothstep(0.1, 0.7, texture2D(tFluidMask, vUv).r);
    return vec3(texture2D(tFluid, vUv).xy * fluidMask, fluidMask);
}{@}PhysicsSceneVisualizerShader.glsl{@}#!ATTRIBUTES
attribute vec3 color;

#!UNIFORMS
uniform float uAlpha;

#!VARYINGS
varying vec3 vColor;

#!SHADER: Vertex
void main() {
    vColor = color;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vColor, uAlpha);
}
{@}ProtonAntimatter.fs{@}uniform sampler2D tOrigin;
uniform sampler2D tAttribs;
uniform float uMaxCount;
//uniforms

#require(range.glsl)
//requires

void main() {
    vec2 uv = vUv;
    #test !window.Metal
    uv = gl_FragCoord.xy / fSize;
    #endtest

    vec3 origin = texture2D(tOrigin, uv).xyz;
    vec4 inputData = texture2D(tInput, uv);
    vec3 pos = inputData.xyz;
    vec4 random = texture2D(tAttribs, uv);
    float data = inputData.w;

    if (vUv.x + vUv.y * fSize > uMaxCount) {
        gl_FragColor = vec4(9999.0);
        return;
    }

    //code

    gl_FragColor = vec4(pos, data);
}{@}ProtonAntimatterLifecycle.fs{@}uniform sampler2D tOrigin;
uniform sampler2D tAttribs;
uniform sampler2D tSpawn;
uniform float uMaxCount;
//uniforms

#require(range.glsl)
//requires

void main() {
    vec3 origin = texture2D(tOrigin, vUv).rgb;
    vec4 inputData = texture2D(tInput, vUv);
    vec3 pos = inputData.xyz;
    vec4 random = texture2D(tAttribs, vUv);
    float data = inputData.w;

    if (vUv.x + vUv.y * fSize > uMaxCount) {
        gl_FragColor = vec4(9999.0);
        return;
    }

    vec4 spawn = texture2D(tSpawn, vUv);
    float life = spawn.x;

    if (spawn.x < -500.0) {
        pos = spawn.xyz;
        pos.x += 999.0;
        spawn.x = 1.0;
        gl_FragColor = vec4(pos, data);
        return;
    }

    //abovespawn
    if (spawn.x <= 0.0) {
        pos.x = 9999.0;
        gl_FragColor = vec4(pos, data);
        return;
    }

    //abovecode
    //code

    gl_FragColor = vec4(pos, data);
}{@}ProtonNeutrino.fs{@}//uniforms

#require(range.glsl)
//requires

void main() {
    //code
}{@}SceneLayout.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vec3 pos = position;
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}GLUIShape.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS

#!SHADER: Vertex
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(uColor, uAlpha);
}{@}GLUIShapeBitmap.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tMask;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv) * texture2D(tMask, vUv).a;
    gl_FragColor.a *= uAlpha;
}{@}PrevPosCapture.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

    #!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
}
{@}SkinData.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS
varying vec3 vWorldPosition;
varying vec3 vNormal;

#!SHADER: Vertex
#require(skinning.glsl)
void main() {

    vNormal = normalize(normal);
    mat4 boneMatX = getBoneMatrix(skinIndex.x);
    mat4 boneMatY = getBoneMatrix(skinIndex.y);
    mat4 boneMatZ = getBoneMatrix(skinIndex.z);
    mat4 boneMatW = getBoneMatrix(skinIndex.w);

    // update normal
    mat4 skinMatrix = mat4(0.0);
    skinMatrix += skinWeight.x * boneMatX;
    skinMatrix += skinWeight.y * boneMatY;
    skinMatrix += skinWeight.z * boneMatZ;
    skinMatrix += skinWeight.w * boneMatW;
    vNormal = vec4(skinMatrix * vec4(vNormal, 0.0)).xyz;

    // Update position
    vec4 bindPos = vec4(position, 1.0);
    vec4 transformed = vec4(0.0);
    transformed += boneMatX * bindPos * skinWeight.x;
    transformed += boneMatY * bindPos * skinWeight.y;
    transformed += boneMatZ * bindPos * skinWeight.z;
    transformed += boneMatW * bindPos * skinWeight.w;
    vec3 localPos = transformed.xyz;

    vec4 worldPosition = modelMatrix * vec4(localPos, 1.0);
    vWorldPosition = worldPosition.xyz;
    gl_Position = vec4(2.0 * uv - 1.0, 0.0, 1.0);
}

    #!SHADER: Fragment

layout(location = 0) out vec4 data1;
layout(location = 1) out vec4 data2;

void main() {
    data1 = vec4(vWorldPosition, 1.0);
    data2 = vec4(vNormal, 1.0);
}
{@}SkinVelocity.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tVel;
uniform sampler2D tCurrentPos;
uniform sampler2D tPrevPos;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

    #!SHADER: Fragment
void main() {

    vec3 vel = texture2D(tVel, vUv).xyz;
    vec3 currentPos = texture2D(tCurrentPos, vUv).xyz;
    vec3 prevPos = texture2D(tPrevPos, vUv).xyz;
    vel += currentPos - prevPos;

    vel *= 0.9998;

    gl_FragColor = vec4(vel, 1.0);
}
{@}ssao.glsl{@}uniform highp sampler2D tDepth;
uniform float uNear;
uniform float uFar;
uniform float uAOClamp;
uniform float uAOLumInfluence;
uniform float uAORadius;
uniform float uAOSamples;
uniform float uAODisplace;
uniform float uAODiffArea;
uniform float uAOAdjustment;
uniform float uAOStrength;
uniform float uAOMaxDist;

#define DL 2.399963229728653
#define EULER 2.718281828459045

const bool useNoise = true;
const float noiseAmount = 0.0003;

vec2 rand(const vec2 coord) {
    vec2 noise;
    if (useNoise) {
        float nx = dot(coord, vec2(12.9898, 78.233));
        float ny = dot(coord, vec2(12.9898, 78.233) * 2.0);
        noise = clamp(fract(43758.5453 * sin(vec2(nx, ny))), 0.0, 1.0);
    } else {
        float ff = fract(1.0 - coord.s * (resolution.x / 2.0));
        float gg = fract(coord.t * (resolution.y / 2.0));
        noise = vec2(0.25, 0.75) * vec2(ff) + vec2(0.75, 0.25) * gg;
    }
    return (noise * 2.0 - 1.0) * noiseAmount;
}

float readDepth(const in vec2 uv) {
    float f = uFar;
    float n = uNear;
    vec4 depth = texture2D(tDepth, uv);
    return (2.0 * n) / (f + n - depth.x * (f - n));
}

float compareDepths(const in float depth1,
                    const in float depth2, inout int far) {
    float garea = 2.0;
    float diff = (depth1 - depth2) * 100.0;
    float udisp = uAODisplace * 0.01;
    float udiff = uAODiffArea * 0.01;
    if (diff < udisp) {
        garea = udiff;
    } else {
        far = 1;
    }
    float dd = diff - udisp;
    float gauss = pow(EULER, -2.0 * dd * dd / (garea * garea));
    return gauss;
}

float calcAO(float depth, float dw, float dh) {
    float dd = uAORadius - depth * uAORadius;
    vec2 vv = vec2(dw, dh);
    vec2 coord1 = vUv + dd * vv;
    vec2 coord2 = vUv - dd * vv;
    float temp1 = 0.0;
    float temp2 = 0.0;
    int far = 0;
    temp1 = compareDepths(depth, readDepth(coord1), far);
    if (far > 0) {
        temp2 = compareDepths(readDepth(coord2), depth, far);
        temp1 += (1.0 - temp1) * temp2;
    }
    return temp1;
}

float aorange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    vec3 sub = vec3(oldValue, newMax, oldMax) - vec3(oldMin, newMin, oldMin);
    return sub.x * sub.y / sub.z + newMin;
}

float aocrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(aorange(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

float getSSAO(vec2 vUv) {
    vec2 noise = rand(vUv);
    float depth = readDepth(vUv);
    float tt = clamp(depth, uAOClamp, 1.0);
    float w = (1.0 / resolution.x) / tt + (noise.x * (1.0 - noise.x));
    float h = (1.0 / resolution.y) / tt + (noise.y * (1.0 - noise.y));
    float ao = 0.0;
    float dz = 1.0 / uAOSamples;
    float z = 1.0 - dz / 2.0;
    float l = 0.0;
    for (int i = 0; i <= 10; i++) {
        float r = sqrt(1.0 - z);
        float pw = cos(l) * r;
        float ph = sin(l) * r;
        ao += calcAO(depth, pw * w, ph * h);
        z = z - dz;
        l = l + DL;
    }
    ao /= uAOSamples;
    ao = 1.0 - ao;
    vec3 color = texture2D(tDiffuse, vUv).rgb;
    vec3 lumcoeff = vec3(0.299, 0.587, 0.114);
    float lum = dot(color.rgb, lumcoeff);
    vec3 luminance = vec3(lum);
    vec3 final = vec3(mix(vec3(ao), vec3(1.0), luminance * uAOLumInfluence));

    float o = aocrange(final.r, 0.0, uAOAdjustment, 0.0, 1.0);
    o = mix(o, 1.0, step(uAOMaxDist, depth));

    return o = mix(1.0, o, uAOStrength);
}
{@}calcnormalfromdepth.glsl{@}vec3 uvToEyePos(in sampler2D depth, in vec2 uv) {
    float linearDepth = getDepthValue(depth, uv, 0.1, 1000.0);
    return (vec3(2.0 * uv - 1.0, -1.0) * uFrustum * linearDepth);
}

vec3 uvToEyePos(in float depth, in vec2 uv) {
    float linearDepth = getDepthValue(depth, 0.1, 1000.0);
    return (vec3(2.0 * uv - 1.0, -1.0) * uFrustum * linearDepth);
}

//if we trivialy accept differences between depths, there can be cases
//where the shortest difference does not belong to the same edge, and because of that
//a second depth is used to extrapolate the nearest depth value.
//points that are on the same surface should (based on the diagram) more or less
//end up at the same depth as the sampled one.
//this is explained here: https://atyuwen.github.io/posts/normal-reconstruction/

vec3 calcNormalFromDepth(in float _depth, in vec2 _uv) {
    vec2 texSize = 1.0 / uResolution;
    ivec2 uv = ivec2(_uv * uResolution);

    if (abs(_depth) >= 1.0) {
        return vec3(0.0);
    }

    vec3 posEye = uvToEyePos(_depth, _uv);

    //find best depth along x...
    float dr = texelFetch(tDepth, uv + ivec2(1, 0), 0).x;
    float dr2 = texelFetch(tDepth, uv + ivec2(2, 0), 0).x;
    float dl = texelFetch(tDepth, uv - ivec2(1, 0), 0).x;
    float dl2 = texelFetch(tDepth, uv - ivec2(2, 0), 0).x;

    vec3 ddx = uvToEyePos(dr, _uv + vec2(texSize.x, 0.0)) - posEye;
    vec3 ddx2 = posEye - uvToEyePos(dl, _uv - vec2(texSize.x, 0.0));

    float horizontalEdgeRight = abs((2.0*dr - dr2) - _depth);
    float horizontalEdgeLeft = abs((2.0*dl - dl2) - _depth);
    vec3 deltaX = horizontalEdgeRight < horizontalEdgeLeft ? ddx : ddx2;

    //find best depth along y...
    float dt = texelFetch(tDepth, uv + ivec2(0, 1), 0).x;
    float dt2 = texelFetch(tDepth, uv + ivec2(0, 2), 0).x;
    float db = texelFetch(tDepth, uv - ivec2(0, 1), 0).x;
    float db2 = texelFetch(tDepth, uv - ivec2(0, 2), 0).x;

    vec3 ddy = uvToEyePos(dt, _uv + vec2(0.0, texSize.y)) - posEye;
    vec3 ddy2 = posEye - uvToEyePos(db, _uv - vec2(0.0, texSize.y));

    float verticalEdgeTop = abs((2.0 * dt - dt2) - _depth);
    float verticalEdgeBottom = abs((2.0 * db - db2) - _depth);

    vec3 deltaY = verticalEdgeTop < verticalEdgeBottom ? ddy : ddy2;

    return normalize(cross(deltaX, deltaY));
}
{@}deNoiseSSAO.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tDepth;
uniform vec2 uDirection;
uniform float uDepthSigma;

uniform float uSpatialSigma;
uniform float uNormalSigma;


#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#define BILATERAL_BLUR

#define PI 3.14159265359
#define TAU 3.14159265359 * 2.0

float gaussianWeight(in float sigma, in float x) {
    float sigma2 = sigma * sigma;
    return exp(-(x * x) / (2.0 * sigma2));
}

void main() {

    float result = 0.0;
    vec2 snapUv = (floor(vUv * resolution.xy) + 0.5) / resolution.xy;
    vec2 aoDepthP = texelFetch(tMap, ivec2(snapUv * resolution.xy), 0).xy;
    vec3 normP = texelFetch(tDepth, ivec2(snapUv * resolution.xy), 0).xyz;

    #ifdef BILATERAL_BLUR

    if (abs(aoDepthP.y) >= (1000.0 - 0.1)) {
        gl_FragColor = vec4(aoDepthP, 0.0, 1.0);
        return;
    }

    vec2 blurDirection = uDirection * (1.0 / resolution.xy);
    float wsum = 0.0;
    float filterRadius = 5.0;
    float spatialWeight = 0.0;
    float normWeight = 0.0;
    float rangeWeight = 0.0;

    for(float x=-filterRadius; x<=filterRadius; x+=1.0) {

        vec2 offset = blurDirection * x;
        vec2 coord = snapUv + offset;
        vec2 aoDepthQ = texelFetch(tMap, ivec2(coord * resolution.xy), 0).xy;
        vec3 normQ = texelFetch(tDepth, ivec2(coord * resolution.xy), 0).xyz;

        spatialWeight = gaussianWeight(uSpatialSigma, abs(x));
        rangeWeight = gaussianWeight(uDepthSigma, abs(aoDepthQ.y - aoDepthP.y));
//        normWeight = gaussianWeight(uNormalSigma, 1.0 - dot(normP, normQ));
        normWeight =  max(0.0, dot(normP, normQ));
        result += aoDepthQ.x * spatialWeight * rangeWeight * normWeight;
        wsum += spatialWeight * rangeWeight * normWeight;

    }

    if(wsum > 0.0) {
        result /= wsum;
    } else {
        result = aoDepthP.x;
    }

    gl_FragColor = vec4(result, aoDepthP.y, 0.0, 1.0);

    #else

    float weight = 0.0;

    for(float i = -2.0; i < 2.0; i++) {
        for(float j = -2.0; j < 2.0; j++) {
            vec2 coord = vUv + (vec2(j, i) * (1.0/resolution.xy));
            result += texture2D(tMap, coord).x;
        }
    }

    result /= 16.0;
    gl_FragColor = vec4(result, aoDepthP.y, 0.0, 1.0);
    #endif
}
{@}depthDownNormalCalc.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDepth;
uniform sampler2D tNormals;
uniform vec2 uResolution;
uniform vec2 uCameraNearFar;
uniform vec3 uFrustum;

uniform mat4 uInverseProjectionMatrix;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)
//    #define USE_CHECKERBOARD_DEPTH

//if we trivialy accept differences between depths, there can be cases
//where the shortest difference does not belong to the same edge, and because of that
//a second depth is used to extrapolate the nearest depth value.
//points that are on the same surface should (based on the diagram) more or less
//end up at the same depth as the sampled one.
//this is explained here: https://atyuwen.github.io/posts/normal-reconstruction/

vec3 calcNormalFromDepth(in float _depth, in vec2 _uv) {
    vec2 texSize = 1.0 / uResolution;
    ivec2 uv = ivec2(_uv * uResolution);

    if (abs(_depth) >= 1.0) {
        return vec3(0.0);
    }

    vec3 posEye = eyePosFromDepth(_depth, 0.1, 1000.0, _uv * uResolution, false);

    //find best depth along x...
    float dr = texelFetch(tDepth, uv + ivec2(1, 0), 0).x;
    float dr2 = texelFetch(tDepth, uv + ivec2(2, 0), 0).x;
    float dl = texelFetch(tDepth, uv - ivec2(1, 0), 0).x;
    float dl2 = texelFetch(tDepth, uv - ivec2(2, 0), 0).x;

    vec3 ddx = eyePosFromDepth(dr, 0.1, 1000.0, (_uv + vec2(texSize.x, 0.0))*uResolution, false) - posEye;
    vec3 ddx2 = posEye - eyePosFromDepth(dl, 0.1, 1000.0, (_uv - vec2(texSize.x, 0.0)) * uResolution, false);

    float horizontalEdgeRight = abs((2.0*dr - dr2) - _depth);
    float horizontalEdgeLeft = abs((2.0*dl - dl2) - _depth);
    vec3 deltaX = horizontalEdgeRight < horizontalEdgeLeft ? ddx : ddx2;

    //find best depth along y...
    float dt = texelFetch(tDepth, uv + ivec2(0, 1), 0).x;
    float dt2 = texelFetch(tDepth, uv + ivec2(0, 2), 0).x;
    float db = texelFetch(tDepth, uv - ivec2(0, 1), 0).x;
    float db2 = texelFetch(tDepth, uv - ivec2(0, 2), 0).x;

    vec3 ddy = eyePosFromDepth(dt, 0.1, 1000.0, (_uv + vec2(0.0, texSize.y)) * uResolution, false) - posEye;
    vec3 ddy2 = posEye - eyePosFromDepth(db, 0.1, 1000.0, (_uv - vec2(0.0, texSize.y)) * uResolution, false);

    float verticalEdgeTop = abs((2.0 * dt - dt2) - _depth);
    float verticalEdgeBottom = abs((2.0 * db - db2) - _depth);

    vec3 deltaY = verticalEdgeTop < verticalEdgeBottom ? ddy : ddy2;

    return normalize(cross(deltaX, deltaY));
}

void main() {

    vec2 snapUV = (floor(vUv * uResolution) + 0.5) / uResolution;
    vec2 texSize = 1.0 / uResolution;

    vec2 desiredCoord = vec2(0.0);

    vec2 bl = snapUV;
    vec2 br = snapUV + vec2(texSize.x, 0.0);
    vec2 tl = snapUV + vec2(0.0, texSize.y);
    vec2 tr = snapUV + vec2(texSize);

    ivec2 fullResCoord = ivec2(vUv * uResolution);
    float bld = texelFetch(tDepth, fullResCoord, 0).x;
    float brd = texelFetch(tDepth, fullResCoord + ivec2(1, 0), 0).x;
    float tld = texelFetch(tDepth, fullResCoord + ivec2(0, 1), 0).x;
    float trd = texelFetch(tDepth, fullResCoord + ivec2(1, 1), 0).x;

    float depth;
    float maxDepth = max(max(bld, brd), max(tld, trd));

    #ifdef USE_CHECKERBOARD_DEPTH
        float minDepth = min(min(bld, brd), min(tld, trd));
        depth = mix(maxDepth, minDepth, float(int(gl_FragCoord.x) & 1 * int(gl_FragCoord.y) & 1));
    #else
        depth = maxDepth;
    #endif

    int index = 0;
    float[] samples = float[4](bld, brd, tld, trd);
    vec2[] coords = vec2[4](bl, br, tl, tr);
    for(int i = 0; i < 4; ++i) {
        if (samples[i] == depth) {
            index = i;
            break;
        }
    }
    vec3 normal = calcNormalFromDepth(samples[index], coords[index]);
//    vec3 normal = calcNormalFromDepth(samples[0], coords[0]);
    gl_FragColor = vec4(normal, getEyeZ(samples[index], 0.1, 1000.0));

}
{@}ssaoplus.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNormal;
uniform sampler2D tRotations;
uniform sampler2D tBlueNoise;
uniform vec3[24] uSampleOffsets;
uniform vec3 uFrustum;

uniform float uSampleRadius;
uniform float uBias;
uniform float uIntensity;
uniform float uContrast;
uniform float uProjectionScale;

uniform float uTau;
uniform float uQuality;
uniform mat4 uInverseProjectionMatrix;

uniform vec2 uCameraNearFar;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)
#require(tridither.glsl)

//#define USE_BLUE_NOISE
//#define USE_PROJECTED_OFFSET
#define PI 3.14159265359
#define TAU 3.14159265359 * 2.0

float alchemyHash(in vec2 c) {
    ivec2 iC = ivec2(c);
    return float(30 * iC.x ^ iC.y + iC.x * iC.y * 10);
}

vec2 getSampleOffset(in float i, in vec2 coord, in float r, float omega) {
    float alpha = (i + 0.5) * (1.0/uQuality);
    float hPrime = r * alpha;
    float turn = floor(uTau);
    float theta = alpha * (TAU * turn) + omega;
    return vec2(cos(theta), sin(theta)) * hPrime;
}

//sources:
//https://casual-effects.com/research/McGuire2011AlchemyAO/VV11AlchemyAO.pdf
//https://casual-effects.com/research/McGuire2012SAO/index.html
//https://learnopengl.com/Advanced-Lighting/SSAO

void main() {
    //vec2 coord = (floor(vUv * resolution.xy) + 0.5) / resolution.xy;
    vec2 coord = gl_FragCoord.xy;
    vec4 normalDepth = texelFetch(tNormal, ivec2(coord + 0.5), 0);
    vec3 normal = normalDepth.xyz;
    float depth = normalDepth.w;

    if (abs(depth) >= (uCameraNearFar.y - uCameraNearFar.x)) {
        gl_FragColor = vec4(1.0, depth, 0.0, 1.0);
        return;
    }

    vec3 viewPos = eyePosFromDepth(depth, uCameraNearFar.x, uCameraNearFar.y, coord, true);

    vec3 rVec;
    #ifdef USE_BLUE_NOISE
        rVec = vec3(2.0 * texture2D(tBlueNoise, gl_FragCoord.xy / 64.0) - 1.0) * vec3(1.0, 1.0, 0.0);
    #else
        rVec = normalize(texture2D(tRotations, gl_FragCoord.xy / 4.0).xyz);
    #endif

    #ifdef USE_PROJECTED_OFFSET

        vec3 tangent = normalize(rVec - (normal * dot(rVec, normal)));
        vec3 bitangent = cross(normal, tangent);
        mat3 tbn = mat3(tangent, bitangent, normal);

    #endif

    float occluded = 0.0;

    float quality = uQuality;
    float sampleRadius = -uSampleRadius * uProjectionScale / viewPos.z;
    float radius2 = uSampleRadius * uSampleRadius;
    float omega = alchemyHash(coord);

    for (float i = 0.0; i < quality; i++) {

        #ifdef USE_PROJECTED_OFFSET

            vec3 sampleDirection = tbn * uSampleOffsets[int(i)];
            vec3 samplePos = viewPos + sampleDirection * sampleRadius;
            vec4 offset = projectionMatrix * vec4(samplePos, 1.0);
            offset.xyz /= offset.w;
            offset.xyz = offset.xyz * 0.5 + 0.5;
            offset.xy = (floor(offset.xy * resolution.xy) + 0.5) / resolution.xy;

            vec3 sampledPos = uvToEyePos(texelFetch(tNormal, ivec2(offset.xy * resolution.xy), 0).w, offset.xy);

        #else

            vec2 sampleOffset = getSampleOffset(i, coord, sampleRadius, omega);
            vec2 c = coord + sampleOffset;
            vec3 sampledPos = eyePosFromDepth(texelFetch(tNormal, ivec2(c+0.5), 0).w, uCameraNearFar.x, uCameraNearFar.y, c, true);

        #endif

        vec3 delta = sampledPos - viewPos;
        float nDotv = dot(delta, normal);
        float eps = 0.01;
        float denom = dot(delta, delta);

        float f = max(radius2 - denom, 0.0);
        //float bias = viewPos.z * uBias * 0.01;
        float bias = uBias * 0.01;
        occluded += max(0.0, (nDotv - bias) / (denom + eps)) * f * f * f;
    }

    float tmp = radius2 * uSampleRadius;
    occluded /= tmp * tmp;

    float a = pow(max(0.0, 1.0 - (((2.0 * uIntensity) / quality) * occluded)), uContrast);
//    gl_FragColor = vec4(a, getDepthValue(depth, uCameraNearFar.x, uCameraNearFar.y), 0.0 , 1.0);
//    a = dither1(a, gl_FragCoord.xy, time);
    gl_FragColor = vec4(a, depth, 0.0 , 1.0);

}

{@}upSampleSSAO.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tDepth;
uniform vec2 uDownSampledDepthResolution;
uniform vec2 uCameraNearFar;
uniform float uSigma;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)
//#define BILTERIAL_UPSAMPLE


float gaussianWeight(in float sigma, in float x) {
    float sigma2 = sigma * sigma;
    return exp(-(x * x) / (2.0 * sigma2));
}

void main() {
    vec2 depthCoord = floor(vUv * uDownSampledDepthResolution)/uDownSampledDepthResolution;
    vec2 desiredCoord = vec2(0.0);
    vec2 texSizeDepth = vec2(1.0 / uDownSampledDepthResolution.xy);
    vec2 texSize = vec2(1.0 / resolution.xy);

    float col = 0.0;

    vec2[4] coords;
    coords[0] = depthCoord;
    coords[1] = depthCoord + vec2(texSizeDepth.x, 0.0);
    coords[2] = depthCoord + vec2(0.0, texSizeDepth.y);
    coords[3] = depthCoord + vec2(texSizeDepth);

    vec2 fullResDepthCoord = floor(vUv * resolution.xy)/resolution.xy;
    float currentDepth = getEyeZ(texelFetch(tDepth, ivec2(gl_FragCoord.xy), 0).x, uCameraNearFar.x, uCameraNearFar.y);

    float[4] distances;
    distances[0] = abs(currentDepth - texelFetch(tMap, ivec2(coords[0]), 0).y);
    distances[1] = abs(currentDepth - texelFetch(tMap, ivec2(coords[1]), 0).y);
    distances[2] = abs(currentDepth - texelFetch(tMap, ivec2(coords[2]), 0).y);
    distances[3] = abs(currentDepth - texelFetch(tMap, ivec2(coords[3]), 0).y);

    #ifdef BILTERIAL_UPSAMPLE

    vec2 bfCoord = vUv * uDownSampledDepthResolution - 0.5;
    vec2 fCoord = fract(bfCoord);
    bfCoord = (floor(bfCoord) + 0.5) / uDownSampledDepthResolution;

    float a = texture2D(tMap, bfCoord).x;
    float b = texture2D(tMap, bfCoord + vec2(texSizeDepth.x, 0.0)).x;
    float c = texture2D(tMap, bfCoord + vec2(0.0, texSizeDepth.y)).x;
    float d = texture2D(tMap, bfCoord + texSizeDepth).x;

    float weightA = gaussianWeight(uSigma, distances[0]);
    float weightB = gaussianWeight(uSigma, distances[1]);
    float weightC = gaussianWeight(uSigma, distances[2]);
    float weightD = gaussianWeight(uSigma, distances[3]);

    col = mix(mix(a * weightA, b * weightB, fCoord.x), mix(c * weightC, d * weightD, fCoord.x), fCoord.y);

    #else

    //bilinearly sample SSAO texture if all depth samples are more or less on the same surface
    float depthThreshold = 0.0001;

    if( distances[0] < depthThreshold &&
    distances[1] < depthThreshold &&
    distances[2] < depthThreshold &&
    distances[3] < depthThreshold
    ) {

        vec2 bfCoord = vUv * uDownSampledDepthResolution - 0.5;
        vec2 fCoord = fract(bfCoord);
        bfCoord = (floor(bfCoord) + 0.5) / uDownSampledDepthResolution;

        float a = texture2D(tMap, bfCoord).x;
        float b = texture2D(tMap, bfCoord + vec2(texSizeDepth.x, 0.0)).x;
        float c = texture2D(tMap, bfCoord + vec2(0.0, texSizeDepth.y)).x;
        float d = texture2D(tMap, bfCoord + texSizeDepth).x;

        col = mix(mix(a, b, fCoord.x), mix(c, d, fCoord.x), fCoord.y);

    } else {

        float minDist = distances[0];
        desiredCoord = coords[0];

        if(distances[1] < minDist) {
            minDist = distances[1];
            desiredCoord = coords[1];
        }

        if(distances[2] < minDist) {
            minDist = distances[2];
            desiredCoord = coords[2];
        }

        if(distances[3] < minDist) {
            minDist = distances[3];
            desiredCoord = coords[3];
        }

        col = texture2D(tMap, desiredCoord).x;

    }

    #endif

    gl_FragColor = vec4(col, 0.0, 0.0, 1.0);
}

{@}worldposdebug.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDepth;
uniform vec3 uFrustum;
uniform vec2 uCameraNearFar;

#!VARYINGS
varying vec3 vRay;
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    //vRay = (inverse(mat3(viewMatrix)) * vec3(position.xy, -1.0) * uFrustum);
//    vec4 r = inverse(projectionMatrix) * vec4(position.xy, 1.0, 1.0);
//    r /= r.w;
//    vRay = r.xyz;
    //vRay = (viewMatrix[0].xyz * uFrustum.x * position.x) + (viewMatrix[1].xyz * uFrustum.y * position.y) + (viewMatrix[3].xyz * uCameraNearFar.y);
    vRay = mat3(viewMatrix) * vec3(position.xy, -1.0) * uFrustum;
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)

vec3 uvToEye(in sampler2D depth, in vec2 uv) {
    vec4 mvPos = inverse(projectionMatrix) * vec4(2.0 * uv - 1.0, 2.0 * texture2D(depth, uv).x - 1.0, 1.0);
    mvPos /= mvPos.w;
    return mvPos.xyz;
}

vec3 uvToEye(in float depth, in vec2 uv) {
    vec4 mvPos = inverse(projectionMatrix) * vec4(2.0 * uv - 1.0, 2.0 * depth - 1.0, 1.0);
    mvPos /= mvPos.w;
    return mvPos.xyz;
}

float LinearizeDepth(float depth, float near, float far)
{
    float z = depth * 2.0 - 1.0; // back to NDC
    return (2.0 * near * far) / (far + near - z * (far - near));
}

void main() {

//    float linearDepth = getDepthValue(texelFetch(tDepth, ivec2(gl_FragCoord.xy + 0.5), 0).x, uCameraNearFar.x, uCameraNearFar.y);
    float linearDepth = LinearizeDepth(texelFetch(tDepth, ivec2(gl_FragCoord.xy + 0.5), 0).x, uCameraNearFar.x, uCameraNearFar.y);
    //vec3 worldPos = (vec3(2.0 * vUv - 1.0, -1.0) * uFrustum * linearDepth);
    float x = (1.0 - projectionMatrix[2][0]) / projectionMatrix[0][0] - (2.0 * (gl_FragCoord.x + 0.5) / (resolution.x * projectionMatrix[0][0]));
    float y = (1.0 + projectionMatrix[2][1]) / projectionMatrix[1][1] - (2.0 * (gl_FragCoord.y + 0.5) / (resolution.y * projectionMatrix[1][1]));


    gl_FragColor = vec4(vec2(x,y)*-linearDepth, -linearDepth, 1.0);
//    gl_FragColor = vec4(uvToEye(tDepth, vUv), 1.0);
}
{@}SSGI.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tColor;
uniform sampler2D tPosition;
uniform sampler2D tNormal;
uniform sampler2D tRandom;

uniform float uMaxDistance;
uniform float uThreshold1;
uniform float uThreshold2;
uniform float uSteps;
uniform float uDecay;
uniform float uConcentration;

#!VARYINGS
varying vec2 vUv;


#!SHADER: SSGI.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}


#!SHADER: SSGI.fs

const float PI = 3.14159265359;

vec3 getHemisphereRandomDirection(vec3 normal, vec2 rand) {

  vec3 zAxis = normalize(normal);
  vec3 xAxis = vec3(1., 0., 0.);
  vec3 yAxis = vec3(0., 1., 0.);
  vec3 UP = vec3(0., 1., 0.);
  mat3 rot = mat3(0.);

  if(abs(dot(UP, normal)) < 0.99) {
    xAxis = normalize(cross(UP, zAxis));
    yAxis = normalize(cross(zAxis, xAxis));  
    rot = mat3(xAxis, yAxis, zAxis);
 
  } else {
    zAxis = vec3(0., 0., 1.);
    rot = mat3(xAxis, zAxis, yAxis);

  }



  float alpha = PI * 0.5 * pow(rand.x, max(uConcentration, 1.));
  float beta = 2. * PI * rand.y;

  vec3 n = vec3(
                sin(alpha) * sin(beta), 
                
                sin(alpha) * cos(beta),
                
                cos(alpha)
                );

  return  rot * n;

}

vec3 indirectDiffuse(vec3 normal, vec2 random, float mask) {

  vec2 uv = vec2(0.);

  vec2 texSize  = resolution.xy;
  vec2 texCoord = gl_FragCoord.xy / texSize;

  vec4 positionFrom = texture(tPosition, texCoord);

  if (mask <= .0) return vec3(0.);

  vec3 unitPositionFrom = normalize(positionFrom.xyz);

  vec3 pivot            = getHemisphereRandomDirection(normal, random);

  vec4 positionTo = positionFrom;

  float maxDistance = uMaxDistance;
  int steps = int(uSteps);

  vec4 startView = vec4(positionFrom.xyz + pivot * 0.01, 1.0);
  vec4 endView = vec4(positionFrom.xyz + pivot * maxDistance, 1.0);;
  

  vec4 startFrag      = startView;
  startFrag      = projectionMatrix * startFrag;
  startFrag.xyz /= startFrag.w;
  startFrag.xy   = startFrag.xy * 0.5 + 0.5;
  startFrag.xy  *= texSize;

  vec4 endFrag      = endView;
  endFrag      = projectionMatrix * endFrag;
  endFrag.xyz /= endFrag.w;
  endFrag.xy   = endFrag.xy * 0.5 + 0.5;
  endFrag.xy  *= texSize;

  vec2 frag  = startFrag.xy;
  uv.xy = frag / texSize;

  float deltaX    = endFrag.x - startFrag.x;
  float deltaY    = endFrag.y - startFrag.y;
  float useX      = abs(deltaX) >= abs(deltaY) ? 1.0 : 0.0;
  float delta     = mix(abs(deltaY), abs(deltaX), useX) * clamp(uThreshold2, 0.0, 1.0);
  vec2  increment = vec2(deltaX, deltaY) / max(delta, 0.0001);

  float search0 = 0.;
  float search1 = 0.;

  int hit0 = 0;
  int hit1 = 0;

  float viewDistance = startView.z;
  float depth        = uThreshold1;
  float decay = 1.;

  for (int i = 0; i < min(int(delta), 40); ++i) {
      frag      += increment;
      uv.xy      = frag / texSize;
      positionTo = texture(tPosition, uv.xy);

      search1 =
      mix
          ( (frag.y - startFrag.y) / deltaY
          , (frag.x - startFrag.x) / deltaX
          , useX
          );

      search1 = clamp(search1, 0.0, 1.0);

      viewDistance = (startView.z * endView.z) / mix(endView.z, startView.z, search1);
      depth        = - viewDistance + positionTo.z;

      if (depth > 0. && depth < uThreshold1) {

        hit0 = 1;
        break;

      } else search0 = search1;
  }

  search1 = search0 + ((search1 - search0) / 2.0);

  steps *= hit0;

  for (int i = 0; i < steps; ++i) {

      frag       = mix(startFrag.xy, endFrag.xy, search1);
      uv.xy      = frag / texSize;
      positionTo = texture(tPosition, uv.xy);

      viewDistance = (startView.z * endView.z) / mix(endView.z, startView.z, search1);
      depth        = - viewDistance + positionTo.z;

      if (depth > 0. && depth < uThreshold1) {

          hit1 = 1;
          break;
          
      } else {

          float temp = search1;
          search1 = search1 + ((search1 - search0) / 2.);
          search0 = temp;

      }
  }

  float visibility = float(hit1)
    //* max( dot(normal, pivot), 0.)
    * (1. - clamp (length(positionTo - positionFrom) * uDecay / maxDistance, 0., 1.))
    * (uv.x < 0. || uv.x > 1. ? 0. : 1.)
    * (uv.y < 0. || uv.y > 1. ? 0. : 1.);

  visibility = clamp(visibility, 0., 1.);

  return vec3(uv, visibility);

}



void main() {


  vec4 data = vec4(0.);
  vec4 random = vec4(0.);
  vec3 color = vec3(0.);
  vec3 normal = vec3(0.);
  vec3 indirect = vec3(0.);
  vec3 partial = vec3(0.);
  vec2 uv = vUv;
  float mask = 0.;

  //Multiple bounces
  const int amountOfBounces = 4;
  int result = 0;
  for(int i = 0; i < amountOfBounces; i ++) {
    data = texture(tNormal, uv);
    color = texture2D(tColor, uv).rgb;
    normal = data.xyz;
    mask = data.a;
    random = texture2D(tRandom, uv);

    partial = indirectDiffuse(normal, random.xy, mask);
    uv = partial.xy;
    indirect += partial.z * texture(tColor, uv).rgb / float(amountOfBounces);
    if(partial.z > 0.) result ++;
  }
  
  if(result == 0) gl_FragColor = vec4(0.);
  if(result == 1) gl_FragColor = vec4(1., 0., 0., 1.);
  if(result == 2) gl_FragColor = vec4(0., 1., 0., 1.);
  if(result == 3) gl_FragColor = vec4(0., 0., 1., 1.);
  if(result == 4) gl_FragColor = vec4(1.);

  gl_FragColor = vec4(indirect, 1.);


}{@}SSR.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tReflectivity;
uniform sampler2D tColor;
uniform sampler2D tPosition;
uniform sampler2D tNormal;
uniform sampler2D tRandom;

uniform vec2 uThresholdRef;
uniform vec2 uThresholdGI;

uniform float uMaxDistanceRef;
uniform float uMaxDistanceGI;

uniform float uStepsRef;
uniform float uStepsGI;

uniform float uDecay;
uniform float uConcentration;

#!VARYINGS
varying vec2 vUv;


#!SHADER: SSR.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}


#!SHADER: SSR.fs


layout(location=0) out vec4 reflectionsData;
layout(location=1) out vec4 giData;

const float PI = 3.14159265359;


vec3 getHemisphereRandomDirection(vec3 normal, vec2 rand) {

  vec3 zAxis = normalize(normal);
  vec3 xAxis = vec3(1., 0., 0.);
  vec3 yAxis = vec3(0., 1., 0.);
  vec3 UP = vec3(0., 1., 0.);
  mat3 rot = mat3(0.);

  if(abs(dot(UP, normal)) < 0.99) {
    xAxis = normalize(cross(UP, zAxis));
    yAxis = normalize(cross(zAxis, xAxis));  
    rot = mat3(xAxis, yAxis, zAxis);
 
  } else {
    zAxis = vec3(0., 0., 1.);
    rot = mat3(xAxis, zAxis, yAxis);

  }



  float alpha = PI * 0.5 * pow(rand.x, max(uConcentration, 1.));
  float beta = 2. * PI * rand.y;

  vec3 n = vec3(
                sin(alpha) * sin(beta), 
                
                sin(alpha) * cos(beta),
                
                cos(alpha)
                );

  return  rot * n;

}



vec3 indirectDiffuse(vec4 positionFrom, 
                     vec3 pivot, float mask, 
                     vec2 uThreshold, 
                     float maxDistance, 
                     float _steps, 
                     int maxSteps, 
                     vec2 visibilityMask) {

  vec2 uv = vec2(0.);

  vec2 texSize  = resolution.xy;
  vec2 texCoord = gl_FragCoord.xy / texSize;

  if (mask <= .0) return vec3(0.);

  vec3 unitPositionFrom = normalize(positionFrom.xyz);

  vec4 positionTo = positionFrom;

  int steps = int(_steps);

  vec4 startView = vec4(positionFrom.xyz, 1.0);
  vec4 endView = vec4(positionFrom.xyz + pivot * maxDistance, 1.0);;
  
  vec4 startFrag      = startView;
  startFrag      = projectionMatrix * startFrag;
  startFrag.xyz /= startFrag.w;
  startFrag.xy   = startFrag.xy * 0.5 + 0.5;
  startFrag.xy  *= texSize;

  vec4 endFrag      = endView;
  endFrag      = projectionMatrix * endFrag;
  endFrag.xyz /= endFrag.w;
  endFrag.xy   = endFrag.xy * 0.5 + 0.5;
  endFrag.xy  *= texSize;

  vec2 frag  = startFrag.xy;
  uv.xy = frag / texSize;

  float deltaX    = endFrag.x - startFrag.x;
  float deltaY    = endFrag.y - startFrag.y;
  float useX      = abs(deltaX) >= abs(deltaY) ? 1.0 : 0.0;
  float delta     = mix(abs(deltaY), abs(deltaX), useX) * clamp(uThreshold.y, 0.0, 1.0);
  vec2  increment = vec2(deltaX, deltaY) / max(delta, 0.0001);

  float search0 = 0.;
  float search1 = 0.;

  int hit0 = 0;
  int hit1 = 0;

  float viewDistance = startView.z;
  float depth        = uThreshold.x;
  float decay = 1.;

  for (int i = 0; i < min(int(delta), maxSteps); ++i) {
      frag      += increment;
      uv.xy      = frag / texSize;
      positionTo = texture(tPosition, uv.xy);

      search1 =
      mix
          ( (frag.y - startFrag.y) / deltaY
          , (frag.x - startFrag.x) / deltaX
          , useX
          );

      search1 = clamp(search1, 0.0, 1.0);

      viewDistance = (startView.z * endView.z) / mix(endView.z, startView.z, search1);
      depth        = - viewDistance + positionTo.z;

      if (depth > 0. && depth < uThreshold.x) {

        hit0 = 1;
        break;

      } else search0 = search1;
  }

  search1 = search0 + ((search1 - search0) / 2.0);

  steps *= hit0;

  for (int i = 0; i < steps; ++i) {

      frag       = mix(startFrag.xy, endFrag.xy, search1);
      uv.xy      = frag / texSize;
      positionTo = texture(tPosition, uv.xy);

      viewDistance = (startView.z * endView.z) / mix(endView.z, startView.z, search1);
      depth        = - viewDistance + positionTo.z;

      if (depth > 0. && depth < uThreshold.x) {

          hit1 = 1;
          break;
          
      } else {

          float temp = search1;
          search1 = search1 + ((search1 - search0) / 2.);
          search0 = temp;

      }
  }

  float visibility = 1.
    * float(hit1)
    * positionTo.w
    * max((1. - max( dot(-unitPositionFrom.rgb, pivot), 0.)), visibilityMask.x)
    * max((1. - clamp (length(positionTo - positionFrom) / maxDistance, 0., 1.)), visibilityMask.y)
    * (uv.x < 0. || uv.x > 1. ? 0. : 1.)
    * (uv.y < 0. || uv.y > 1. ? 0. : 1.);

  visibility = clamp(visibility, 0., 1.);

  return vec3(uv, visibility);

}



void main() {


  vec4 data = vec4(0.);
  vec4 random = vec4(0.);
  vec3 color = vec3(0.);
  vec3 reflectivity = vec3(0.);
  vec3 normal = vec3(0.);
  vec3 indirect = vec3(0.);
  vec3 partial = vec3(0.);
  vec2 uv = vUv;
  float giIntensity = 1.;
  float mask = 0.;
  float R = 0.;
  float IOR = 0.;
  int result = 0;


  //===================================================================================
  //Global Illumination
  //===================================================================================


  //Multiple bounces for global illumination, not enabled yet
  const int amountOfGIBounces = 1;

  data = texture(tNormal, uv);
  color = texture2D(tColor, uv).rgb;
  vec4 positionData = texture(tPosition, uv);

  for(int i = 0; i < amountOfGIBounces; i ++) {

    normal = data.xyz;
    mask = data.a;
    random = texture2D(tRandom, uv);
    giIntensity = texture2D(tReflectivity, uv).a;

    vec2 rand = vec2(0.);
    if(i == 0) rand = random.xy;
    if(i == 1) rand = random.zw;
    if(i == 2) rand = random.xz;
    if(i == 3) rand = random.yw;

    vec3 pivot = getHemisphereRandomDirection(normal, rand);
    pivot = normalize(pivot);

    partial = giIntensity * indirectDiffuse(positionData, 
                                            pivot, 
                                            mask, 
                                            uThresholdGI, 
                                            uMaxDistanceGI, 
                                            uStepsGI, 
                                            200,
                                            vec2(1.));
    uv = partial.xy;

    indirect += partial.z * texture(tColor, uv).rgb / float(amountOfGIBounces);
  }


  giData = vec4(indirect, 1.);


  //===================================================================================
  //Reflection
  //===================================================================================


  uv = vUv;
  indirect = vec3(0.);
  partial = vec3(0.);

  //Multiple bounces for reflection, not enabled yet
  const int amountOfReflectionBounces = 1;
  for(int i = 0; i < amountOfReflectionBounces; i ++) {

    data = texture(tNormal, uv);
    color = texture2D(tColor, uv).rgb;
    reflectivity = texture2D(tReflectivity, uv).rgb;

    vec4 positionData = texture(tPosition, uv);
    vec3 positionFrom = positionData.rgb;
    normal = data.xyz;
    mask = data.a;

    //Hack to avoid noise
    if(abs(dot(normal, normalize(cameraPosition))) > 0.) {
      normal += vec3(0.001);
    }

    vec3 pivot = reflect(normalize(positionFrom), normal);
    pivot = normalize(pivot);

    partial = indirectDiffuse(positionData, 
                              pivot, 
                              mask, 
                              uThresholdRef, 
                              uMaxDistanceRef, 
                              uStepsRef, 
                              500,
                              vec2(0.));
    uv = partial.xy;

    //for fresnel
    IOR = reflectivity.x;
    float R0 = pow( (1. - IOR) / (1. + IOR), 2.);
    float NdV = dot(normalize(normal), normalize(-positionFrom));
    R = R0 + (1. - R0) * pow( (1. - NdV), 5.);
    R = 1. - clamp(R, 0., 1.);

    indirect += R * reflectivity.y * partial.z * texture(tColor, uv).rgb / float(amountOfReflectionBounces);
    if(partial.z > 0.) result ++;
  }
  
  reflectionsData = vec4(indirect, 1.);

}{@}SeparableBlur.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tColor;
uniform sampler2D tReflectivity;
uniform sampler2D tPosition;
uniform sampler2D tNormal;
uniform float uFragments;
uniform float uFixedFragments;

uniform float uAngleThreshold;
uniform float uFragments;
uniform float uDepthThreshold;

uniform float uDir;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs

void main() {

    vUv = uv;
    gl_Position = vec4(position, 1.0);

}

#!SHADER: Fragment.fs


void main() {

    vec3 color = vec3(0.);
    vec2 size = vec2(textureSize(tColor, 0).xy);

    float halfFragments = uFragments * 0.5;

    float fragments = clamp(texture(tReflectivity, vUv).z, 0., 1.) * 40.;
    vec3 normal = texture(tNormal, vUv).xyz;
    float depth = texture(tPosition, vUv).z;
    color += texture(tColor, vUv).rgb;
    float divider = 1.;

    if(uFixedFragments > 0.5) fragments = uFragments;

    for(float i = -fragments; i < fragments; i ++) {

        vec2 dir = uDir > 0.? vec2(1., 0.) : vec2(0., 1.);
        vec2 st = i * dir;
        st /= size;
        st += vUv;

        vec3 nNormal = texture(tNormal, st).xyz;
        float nDepth = texture(tPosition, st).z;

        float cosAng = dot(normalize(normal), normalize(nNormal));
        float depthDiff = abs(depth - nDepth);

        if(cosAng > uAngleThreshold && depthDiff < uDepthThreshold && i != 0.) {

            color += texture(tColor, st).rgb;
            divider ++;

        }

    }

    color /= max(divider, 1.);

    gl_FragColor = vec4(color, 1.);
}{@}Text3D.glsl{@}#!ATTRIBUTES
attribute vec3 animation;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uOpacity;
uniform vec3 uTranslate;
uniform vec3 uRotate;
uniform float uTransition;
uniform float uWordCount;
uniform float uLineCount;
uniform float uLetterCount;
uniform float uByWord;
uniform float uByLine;
uniform float uZMove;
uniform float uPadding;
uniform vec3 uBoundingMin;
uniform vec3 uBoundingMax;
uniform float uScrollDelta;
uniform vec2 uMouse;
uniform sampler2D tFluid;
uniform sampler2D tFluidMask;
uniform float uRainbow;

#!VARYINGS
varying float vTrans;
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;
varying float vWarp;

#!SHADER: Vertex

#require(range.glsl)
#require(eases.glsl)
#require(rotation.glsl)
#require(conditionals.glsl)

void main() {
    vUv = uv;
    vTrans = 1.0;

    vec3 pos = position;

    if (uTransition > 0.0 && uTransition < 1.0) {
        float padding = uPadding;
        float letter = (animation.x + 1.0) / uLetterCount;
        float word = (animation.y + 1.0) / uWordCount;
        float line = (animation.z + 1.0) / uLineCount;

        float letterTrans = rangeTransition(uTransition, letter, padding);
        float wordTrans = rangeTransition(uTransition, word, padding);
        float lineTrans = rangeTransition(uTransition, line, padding);

        vTrans = mix(cubicOut(letterTrans), cubicOut(wordTrans), uByWord);
        vTrans = mix(vTrans, cubicOut(lineTrans), uByLine);

        float invTrans = (1.0 - vTrans);
        vec3 nRotate = normalize(uRotate);
        vec3 axisX = vec3(1.0, 0.0, 0.0);
        vec3 axisY = vec3(0.0, 1.0, 0.0);
        vec3 axisZ = vec3(0.0, 0.0, 1.0);
        vec3 axis = mix(axisX, axisY, when_gt(nRotate.y, nRotate.x));
        axis = mix(axis, axisZ, when_gt(nRotate.z, nRotate.x));
        pos = vec3(vec4(position, 1.0) * rotationMatrix(axis, radians(max(max(uRotate.x, uRotate.y), uRotate.z) * invTrans)));
        pos += uTranslate * invTrans;
    }

    vWarp = 0.5 + sin(time + length(pos.xy-0.5) * 4.0) * 0.5;
    pos.z += uZMove + vWarp * uZMove * mix(1.0, 3.0, uRainbow);
    pos.z += uRainbow * 0.2;

    vPos = pos;
	vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(msdf.glsl)
#require(simplenoise.glsl)
#require(transformUV.glsl)
#require(rgb2hsv.fs)

vec2 getBoundingUV() {
    vec2 uv;
    uv.x = crange(vPos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0);
    uv.y = crange(vPos.y, uBoundingMin.y, uBoundingMax.y, 0.0, 1.0);
    return uv;
}

void main() {
    vec2 uv = vUv;

    float pixels = mix(20.0, 50.0, uOpacity);
    vec2 pixeluv = round(uv * pixels) / pixels;
    uv = mix(uv, pixeluv, max(smoothstep(1.0, 0.0, uOpacity), smoothstep(0.5, 0.2, abs(uRainbow-0.5))));


    vec2 screenuv = gl_FragCoord.xy / resolution;
    vec2 squareScreenuv = scaleUV(screenuv, vec2(1.0, resolution.x/resolution.y));
    float alpha = msdf(tMap, uv);

    alpha *= mix(mix(0.8, 1.0, uRainbow), 1.0, vWarp);
    alpha *= smoothstep(3.0, 6.0, length(cameraPosition-vWorldPos));

    if (alpha == 0.0) discard;

    //float noise = 0.5 + smoothstep(-1.0, 1.0, cnoise(vec3(vUv*50.0, time* 0.3))) * 0.5;

    vec4 color = vec4(uColor, alpha * uAlpha * uOpacity * vTrans);

    vec3 hsv = rgb2hsv(vec3(1.0, 0.6, 0.6));
    hsv.x += uv.x - time * 0.3 + uv.y * 0.5;
    hsv.x = floor(hsv.x*5.0)/5.0;
    color.rgb = mix(color.rgb, hsv2rgb(hsv), uRainbow);

    #drawbuffer Color gl_FragColor = color;
    #drawbuffer Refraction gl_FragColor = color;
}
{@}textureanimation.vs{@}attribute vec2 uv2;

uniform highp sampler2D uAnimationTexture;
uniform float uTextureHeight;
uniform float uAnimationLength[10];
uniform float uOffsets[10];
uniform float uSpeed[10];
uniform float uHzMultiplier;
uniform float speedMultiplier;

vec3 rotate(vec3 v, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return mat3(c, 0., -s,
                0., 1., 0.,
                s, 0, c) * v;
}

vec3 rotate(vec3 vec, vec4 quat) {
    float angle = atan(quat.w, quat.y) + 3.14159265359;
    vec4 yQuat = vec4(0., sin(angle), 0., cos(angle));
    return vec + 2.0 * cross( cross( vec, yQuat.xyz ) + yQuat.w * vec, yQuat.xyz );
}

vec3 getAnimatedPosition(int animationIndex, float blend) {
    float frames = uAnimationLength[animationIndex];
    float offset = uOffsets[animationIndex];
    float speed = uSpeed[animationIndex];
    float phaseY = fract(speed * time * speedMultiplier * uHzMultiplier) * max(frames - 1., 0.);
    
    vec2 frameOffsetY = vec2(0.0, (offset + floor(phaseY) + 0.5) / uTextureHeight);
    vec3 animationA = texture2D(uAnimationTexture, vec2(uv2.x, 0.) + frameOffsetY).rgb;

    frameOffsetY = vec2(0.0, (offset + ceil(phaseY) + 0.5) / uTextureHeight);
    vec3 animationB = texture2D(uAnimationTexture, vec2(uv2.x, 0.) + frameOffsetY).rgb;

    vec3 animation = mix(animationA, animationB, vec3(fract(phaseY)));

    return mix(position, animation, blend);
}

vec3 getAnimatedPositionRaw(int animationIndex) {
    float frames = uAnimationLength[animationIndex];
    float offset = uOffsets[animationIndex];
    float speed = uSpeed[animationIndex];
    float phaseY = fract(speed * time * speedMultiplier * uHzMultiplier) * max(frames - 1., 0.);
    
    vec2 frameOffsetY = vec2(0.0, (offset + floor(phaseY) + 0.5) / uTextureHeight);
    vec3 animationA = texture2D(uAnimationTexture, vec2(uv2.x, 0.) + frameOffsetY).rgb;

    frameOffsetY = vec2(0.0, (offset + ceil(phaseY) + 0.5) / uTextureHeight);
    vec3 animationB = texture2D(uAnimationTexture, vec2(uv2.x, 0.) + frameOffsetY).rgb;
    vec3 animation = mix(animationA, animationB, vec3(fract(phaseY)));

    return animation;
}
{@}TweenUILPathFallbackShader.glsl{@}#!ATTRIBUTES
attribute float speed;

#!UNIFORMS
uniform vec3 uColor;
uniform vec3 uColor2;
uniform float uOpacity;

#!VARYINGS
varying vec3 vColor;

#!SHADER: Vertex

void main() {
    vColor = mix(uColor, uColor2, speed);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vColor, uOpacity);
}
{@}TweenUILPathShader.glsl{@}#!ATTRIBUTES
attribute float speed;

#!UNIFORMS
uniform vec3 uColor2;

#!VARYINGS

#!SHADER: Vertex

void main() {
    vColor = mix(uColor, uColor2, speed);
}

void customDirection() {
    // Use screen space coordinates for final position, so line thickness is
    // independent of camera.
    finalPosition = vec4(currentP.x / aspect, currentP.y, min(0.0, finalPosition.z), 1.0);
}

#!SHADER: Fragment
float tri(float v) {
    return mix(v, 1.0 - v, step(0.5, v)) * 2.0;
}

void main() {
    float signedDist = tri(vUv.y) - 0.5;
    gl_FragColor.a *= clamp(signedDist/fwidth(signedDist) + 0.5, 0.0, 1.0);
}
{@}UnrealBloom.fs{@}uniform sampler2D tUnrealBloom;

vec3 getUnrealBloom(vec2 uv) {
    return texture2D(tUnrealBloom, uv).rgb;
}{@}UnrealBloomComposite.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D blurTexture1;
uniform float bloomStrength;
uniform float bloomRadius;
uniform vec3 bloomTintColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

float lerpBloomFactor(const in float factor) {
    float mirrorFactor = 1.2 - factor;
    return mix(factor, mirrorFactor, bloomRadius);
}

void main() {
    gl_FragColor = bloomStrength * (lerpBloomFactor(1.0) * vec4(bloomTintColor, 1.0) * texture2D(blurTexture1, vUv));
}{@}UnrealBloomGaussian.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D colorTexture;
uniform vec2 texSize;
uniform vec2 direction;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

float gaussianPdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

void main() {
    vec2 invSize = 1.0 / texSize;
    float fSigma = float(SIGMA);
    float weightSum = gaussianPdf(0.0, fSigma);
    vec3 diffuseSum = texture2D( colorTexture, vUv).rgb * weightSum;
    for(int i = 1; i < KERNEL_RADIUS; i ++) {
        float x = float(i);
        float w = gaussianPdf(x, fSigma);
        vec2 uvOffset = direction * invSize * x;
        vec3 sample1 = texture2D( colorTexture, vUv + uvOffset).rgb;
        vec3 sample2 = texture2D( colorTexture, vUv - uvOffset).rgb;
        diffuseSum += (sample1 + sample2) * w;
        weightSum += 2.0 * w;
    }
    gl_FragColor = vec4(diffuseSum/weightSum, 1.0);
}{@}UnrealBloomLuminosity.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDiffuse;
uniform vec3 defaultColor;
uniform float defaultOpacity;
uniform float luminosityThreshold;
uniform float smoothWidth;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

#require(luma.fs)

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    float v = luma(texel.xyz);
    vec4 outputColor = vec4(defaultColor.rgb, defaultOpacity);
    float alpha = smoothstep(luminosityThreshold, luminosityThreshold + smoothWidth, v);
    gl_FragColor = mix(outputColor, texel, alpha);
}{@}UnrealBloomPass.fs{@}#require(UnrealBloom.fs)

void main() {
    vec4 color = texture2D(tDiffuse, vUv);
    color.rgb += getUnrealBloom(vUv);
    gl_FragColor = color;
}{@}luma.fs{@}float luma(vec3 color) {
  return dot(color, vec3(0.299, 0.587, 0.114));
}

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}