Shader "ShaderLearning/Shader12"
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

            // 这个函数实现Shader10里面的效果
            float pattern(float2 uv)
            {
                uv = uv * 2 - 1;
                float t = pow(uv.x * uv.x, 0.3) + pow(uv.y * uv.y, 0.3) - 1;
                return t;
                // 下面的代码是边界更清晰
                // return step(0, t) * t * 10 + step(0.2, t);
            }

            // 这个shader结合shader10和shader11的效果, 就是把shader10和shader11的效果结合了
            fixed4 frag(v2f i) : SV_Target
            {
                float columns = _Column;
                float rows = _Row;

                // frac函数取小数部分, frac(0.5) = 0.5, frac(1.5) = 0.5
                // uv * fixed2(columns, rows),把uv扩大columns, rows倍数
                // 加上frac取小数部分,就把uv缩小columns, rows倍数
                fixed2 uv = frac(i.uv * fixed2(columns, rows));

                float r = pattern(uv);

                return fixed4(r, 0, 0, 1);
            }
            ENDCG
        }
    }
}