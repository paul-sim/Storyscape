Shader "SonarShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ObjectsTex ("ObjectsTexture", 2D) = "white" {}
		_OverlayTex ("OverlayTexture", 2D) = "white" {}
		_SweepTex ("SweepTexture", 2D) = "white" {}
		_RevealMaskTex ("RevealMaskTexture", 2D) = "white" {}
		_NoiseMaskTex ("NoiseMaskTexture", 2D) = "white" {}
		_NoiseTex ("NoiseTexture", 2D) = "white" {}

		_SweepSpeed ("SweepSpeed", Float) = 0.5
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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _ObjectsTex;
			sampler2D _OverlayTex;
			sampler2D _SweepTex;
			sampler2D _RevealMaskTex;
			sampler2D _NoiseMaskTex;
			sampler2D _NoiseTex;

			float _SweepSpeed;

			fixed4 frag (v2f i) : SV_Target
			{
				float sweepProgress = _SweepSpeed * _Time.x;
				float texelAngle = atan2(i.uv.y-0.5, i.uv.x-0.5);
				texelAngle = (texelAngle+3.1415926535)/(2.0*3.1415926535);
				float2 sweepLookupPosition = float2(frac(sweepProgress + texelAngle), 0.5);

				fixed4 mapColor = tex2D(_MainTex, i.uv);
				fixed4 objectsColor = tex2D(_ObjectsTex, i.uv);
				fixed4 overlayColor = tex2D(_OverlayTex, i.uv);
				fixed4 noiseColor = tex2D(_NoiseTex, i.uv);
				fixed4 sweepColor = tex2D(_SweepTex, sweepLookupPosition);

				float objectsRevealAmount = tex2D(_RevealMaskTex, sweepLookupPosition).r;
				float noiseRevealAmount = tex2D(_NoiseMaskTex, sweepLookupPosition).r;

				fixed4 col = noiseRevealAmount * mapColor;

				col += objectsRevealAmount * objectsColor * objectsColor.a;

				col += noiseRevealAmount * fixed4(noiseColor.r-0.5, noiseColor.g-0.5, noiseColor.b-0.5, 1.0);

				col = col*(1.0-sweepColor.a) + sweepColor.a*fixed4(sweepColor.r, sweepColor.g, sweepColor.b, 1.0);

				col = col*(1.0-overlayColor.a) + overlayColor.a*fixed4(overlayColor.r, overlayColor.g, overlayColor.b, 1.0);
				col.a = 1.0;

				return col;
			}
			ENDCG
		}
	}
}
