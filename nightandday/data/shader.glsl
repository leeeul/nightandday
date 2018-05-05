#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture1; //cloud
uniform sampler2D texture2; //day
uniform sampler2D texture3; //night

uniform float rotate;

uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 coord1 = vertTexCoord.xy;
    coord1.x += rotate;
    coord1.x = mod(coord1.x, 1.);
    
    float colC= texture2D(texture1, coord1).r;
    
    vec2 coord2 = vertTexCoord.xy;
    coord2.x -= rotate*3.5;
    coord2.x = mod(coord2.x, 1.);
    
    float ratio;
    float smoo = 0.07;
    ratio = smoothstep(0.25-smoo, 0.25+smoo, coord2.x) - smoothstep(0.75-smoo, 0.75+smoo, coord2.x);
    
    vec3 colD= texture2D(texture2, vertTexCoord.xy).rgb*ratio;
    vec3 colN= texture2D(texture3, vertTexCoord.xy).rgb*(1. - ratio);
    vec3 col = colD+colN;
    
    col += colC*(ratio*0.4+0.1) * ((ratio*2.)-1.);

    gl_FragColor = vec4(col, 1.);
}

