Shader "Custom/AlphaBlend"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200
		cull off
		zwrite off

        CGPROGRAM
        #pragma surface surf NewLambert alpha:fade
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

		float4 LightingNewLambert(SurfaceOutput s, float3 lightDir, float atten) {
			float ndotl = saturate(dot(s.Normal, lightDir));
			float3 final = s.Albedo * ndotl * _LightColor0.rgb * atten;
			return float4(final, s.Alpha);
		}
        ENDCG
    }
    FallBack "Legacy Shaders/Transparent/VertexLit"
}
