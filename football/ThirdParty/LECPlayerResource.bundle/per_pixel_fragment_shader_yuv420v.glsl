precision mediump float;
uniform lowp sampler2D u_TextureX;
uniform lowp sampler2D u_TextureYZ;
uniform mat3 u_ColorConversion;
varying vec2 v_TexCoordinate;

void main()
{
    mediump vec3 yuv;
    lowp    vec3 rgb;
    
    yuv.x = (texture2D(u_TextureX, v_TexCoordinate).r - (16.0 / 255.0));
    yuv.yz = (texture2D(u_TextureYZ, v_TexCoordinate).ra - vec2(0.5, 0.5));
    rgb = yuv * u_ColorConversion;
    gl_FragColor = vec4(rgb, 1);
}
