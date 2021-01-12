shader_type canvas_item;







//Other bits than noise made by vaingald
//Noise made by Ian McEwan, Ashima Arts


// Description : Array and textureless GLSL 2D simplex noise function.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : stegu
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
//               https://github.com/stegu/webgl-noise
// 

vec3 mod289_3(vec3 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289_2(vec2 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
    return mod289_3(((x*34.0)+1.0)*x);
}

float snoise(vec2 v) {
    vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                  0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                 -0.577350269189626,  // -1.0 + 2.0 * C.x
                  0.024390243902439); // 1.0 / 41.0
    // First corner
    vec2 i  = floor(v + dot(v, C.yy) );
    vec2 x0 = v -   i + dot(i, C.xx);
    
    // Other corners
    vec2 i1;
    //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
    //i1.y = 1.0 - i1.x;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    // x0 = x0 - 0.0 + 0.0 * C.xx ;
    // x1 = x0 - i1 + 1.0 * C.xx ;
    // x2 = x0 - 1.0 + 2.0 * C.xx ;
    vec4 x12 = vec4(x0.xy, x0.xy) + C.xxzz;
    x12.xy -= i1;
    
    // Permutations
    i = mod289_2(i); // Avoid truncation effects in permutation
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
    	+ i.x + vec3(0.0, i1.x, 1.0 ));
    
    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), vec3(0.0));
    m = m*m ;
    m = m*m ;
    
    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)
    
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    
    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
    
    // Compute final noise value at P
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

void fragment() {
	
	vec2 uv = vec2(SCREEN_UV.x * sin(SCREEN_UV.x + 1.0), SCREEN_UV.y * sin(SCREEN_UV.y + 1.0));
	//vec2 uv = vec2(SCREEN_UV);
	vec3 originalcolor = textureLod(SCREEN_TEXTURE, uv * 1.0, 0.0).rgb;
	
	float overlaytexture = snoise(vec2((UV.x * 0.5 + (TIME * 2.12)), (UV.y * 4.0 + (TIME * 2.134))) * 100.0) * 0.5 + 0.5;
	
	vec3 c = textureLod(SCREEN_TEXTURE, uv * 1.0, 0.0).rgb / 4.0;
	
	vec3 c2 = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb * 4.0;
	
	float saturationamount = 0.75;
	
	float exposure = 0.0; //0 is no additional exposure
	
	float contrast = 0.75;
	
	float overlayamount = 0.03;
	
	//grayscale
	float gray = dot(c2.rgb, vec3(0.299, 0.587, 0.114));
	
	vec3 grayscale = vec3(gray, gray, gray);
	
	float filtermix = 0.6;
	
	 //blurring the color layer
	
	float radius = 0.002;
	
	c+= textureLod(SCREEN_TEXTURE, uv+vec2(radius,0), 0.0).rgb;
	c+= textureLod(SCREEN_TEXTURE, uv+vec2(-radius,0), 0.0).rgb;

	c+= textureLod(SCREEN_TEXTURE, uv+vec2(0,-radius / 4.0), 0.0).rgb;
	c+= textureLod(SCREEN_TEXTURE, uv+vec2(0,radius / 4.0), 0.0).rgb;
	
	//saturating the color layer
	vec3 saturated = c - vec3(gray, gray, gray);
	
	//interpolating the blurred color layer with sharp grayscale layer
	vec3 filter = mix(mix(grayscale, saturated, saturationamount), vec3(gray, gray, gray), 0.1);
	
	vec3 vhscolored = mix(originalcolor, filter, filtermix) * contrast + exposure;
	
	COLOR.xyz = vhscolored + (overlaytexture * overlayamount);

}