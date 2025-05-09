Shader "ShaderLearning/Shader04"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OnOff("OnOff", Range(0, 1)) = 0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _OnOff;

            fixed4 frag(v2f i) : SV_Target
            {
                float c = step(0.5, _OnOff) * i.uv.x;
                c += (1 - step(0.5, _OnOff)) * i.uv.y;
                return fixed4(c, c, 0, 1);
            }
            ENDCG
        }
    }
}