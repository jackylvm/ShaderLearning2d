Shader "ShaderLearning/Shader06"
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
                float xa = 1 - step(0.25, i.uv.x);
                float xb = step(0.75, i.uv.x);
                float xc = max(xa, xb);

                float ya = 1 - step(0.25, i.uv.y);
                float yb = step(0.75, i.uv.y);
                float yc = max(ya, yb);

                // 这段注释掉的实现四个角有颜色
                // float xy = xc * yc;
                // fixed3 c = fixed3(1.0, 0.0, 0.0) * xy;
                // return fixed4(c, 1);

                float xy = step(_OnOff, i.uv.x) * xc;
                xy += (1 - step(_OnOff, i.uv.y)) * yc;

                fixed3 c = fixed3(1.0, 0.0, 0.0) * xy;
                return fixed4(c, 1);
            }
            ENDCG
        }
    }
}