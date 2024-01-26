shader_type canvas_item;
uniform vec3 top_color = vec3(1.0, 0.0, 0.0);
uniform vec3 top_color2 = vec3(1.0, 0.0, 0.0);
uniform vec3 bottom_color = vec3(0.0, 0.0, 0.0);
uniform vec3 bottom_color2 = vec3(0.0, 0.0, 0.0);
void vertex() {
	// Called for every vertex the material is visible on.
}
const float cloudscale = 1.5;
const float speed = 0.03;
const float clouddark = 0.5;
const float cloudlight = 0.3;
const float cloudcover = 0.2;
const float cloudalpha = 8.0;
const float skytint = 0.5;
const vec3 skycolour1 = vec3(0.2, 0.4, 0.6);
const vec3 skycolour2 = vec3(0.4, 0.7, 1.0);

//const mat2 m = mat2( 1.6,  1.2, -1.2,  1.6 );
const vec4 m = vec4( 1.6,  1.2, -1.2,  1.6 );
vec2 hash( vec2 p ) {
	p = vec2(dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)));
	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float noise( in vec2 p ) {
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;
	vec2 i = floor(p + (p.x+p.y)*K1);	
    vec2 a = p - i + (i.x+i.y)*K2;
    vec2 o = (a.x>a.y) ? vec2(1.0,0.0) : vec2(0.0,1.0); //vec2 of = 0.5 + 0.5*vec2(sign(a.x-a.y), sign(a.y-a.x));
    vec2 b = a - o + K2;
	vec2 c = a - 1.0 + 2.0*K2;
    vec3 h = max(0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
	vec3 n = h*h*h*h*vec3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));
    return dot(n, vec3(70.0));	
}

//float fbm(vec2 n) {
	//float total = 0.0, amplitude = 0.1;
	//for (int i = 0; i < 7; i++) {
		//total += noise(n) * amplitude;
		//n = m * n;
		//amplitude *= 0.4;
	//}
	//return total;
//}


void fragment() {	
	// Called for every pixel the material is visible on.
      // Normalized screen space coordinates of the sun controlled by mouse
    vec2 sunPosition = vec2(0.5);
    //sunPosition = (iMouse.xy/iResolution.xy);
    
    // Interpolate between midday and evening sky colors based on sun height
    vec3 sky_horizonColor = mix(bottom_color,bottom_color2,pow(sunPosition.y,0.3));
    vec3 sky_Color = mix(top_color,top_color2,pow(sunPosition.y,0.3));
    
    // Sky gradient
    vec3 skyGradient = mix(top_color,bottom_color,pow(UV.y,0.5));
    
    // Simple sun disc
    vec3 sun_color = vec3(1.0,1.0,0.3);
    //vec3 sunDisc = sun_color *(length(FRAGCOORD - (sunPosition * iResolution.xy)) < (iResolution.x/50.0) ? 1.0 : 0.0);
    
    // Compute sun halo for horizon and zenit
    //float sunHaloFactor = (length(fragCoord.xy - sunPosition * iResolution.xy)-(iResolution.x/50.0))/length(iResolution.xy);
    //float sunHaloPoly = (1.0 - pow(sunHaloFactor,0.15+(1.0-sunPosition.y)*0.2)) * (1.0-uv.y);
    //float sunHaloExp = exp(-pow(sunHaloFactor,2.0)/(2.0*pow(0.02,2.0)));
    //// Interpolate sun halo
    //vec3 sunHalo = sun_color * mix(sunHaloPoly,sunHaloExp,pow(sunPosition.y,0.6));
    //
    // Combine sky gradient, sun disc and sun halo for final color
    COLOR = vec4(skyGradient,1.0);
    


  //COLOR = sky_color; 
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
