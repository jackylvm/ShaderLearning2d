Shader "ShaderLearning/Shader14"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Column ("Columns", Float) = 5
        _Row ("Rows", Float) = 5
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
            float _Column;
            float _Row;

            float step_union(float edge, float v)
            {
                float a = 1 - step(edge, v);
                float b = step(1 - edge, v);
                return max(a, b);
            }

            // 这个shader结合shader11和shader13
            fixed4 frag(v2f i) : SV_Target
            {
                float columns = _Column;
                float rows = _Row;

                fixed2 uv = frac(i.uv * float2(columns, rows));

                float xa = step_union(0.1, uv.x);
                float ya = step_union(0.1, uv.y);
                float xy = max(xa, ya);
                xy = 1 - step(0.5, xy);

                return fixed4(xy, 0, 0, 1);
            }
            ENDCG
        }
    }
}