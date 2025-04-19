Shader "ShaderLearning/Shader10"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Power ("Power", Range(0, 1)) = 0.5
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
            float _Power;

            fixed4 frag(v2f i) : SV_Target
            {
                // 让uv坐标在-1到1之间
                float2 uv = i.uv * 2 - 1;

                // 
                float r = pow(uv.x * uv.x, _Power) + pow(uv.y * uv.y, _Power) - 1;
                // float r = pow(i.uv.x * i.uv.x, 0.3) + pow(i.uv.y * i.uv.y, 0.3) - 1;    
                return fixed4(r, 0, 0, 1);
            }
            ENDCG
        }
    }
}