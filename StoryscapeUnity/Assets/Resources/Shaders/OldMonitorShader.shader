// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/OldMonitor"
{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
		_VertsColor("Verts fill color", Float) = 0 
		_VertsColor2("Verts fill color 2", Float) = 0
		_BarrelPower("Barrel Power", Float) = 1
		_Glitchiness("Barrel Power", Float) = 1
    }
 
    SubShader {
        Pass {
            ZTest Always Cull Off ZWrite Off Fog { Mode off }
 
            CGPROGRAM
 
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #include "UnityCG.cginc"
            #pragma target 3.0
 			
            struct v2f
            {
                float4 pos      : POSITION;
                float2 uv       : TEXCOORD0;
				float4 scr_pos  : TEXCOORD1;
            };
 
            uniform sampler2D _MainTex;
			
			uniform float _VertsColor;
			uniform float _VertsColor2;

			uniform float _Glitchiness;
			
            v2f vert(appdata_img v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
				o.scr_pos = ComputeScreenPos(o.pos);
                return o;
            }
 
            half4 frag(v2f i): COLOR
            {
            	
                half4 color = tex2D(_MainTex, i.uv);

                float glitchAmount = min(_Glitchiness*_Glitchiness*_Glitchiness*_Glitchiness, abs(_Glitchiness * (tan((_Glitchiness*_Time.x*_Time.x))+1.0)));
                float glitchOrFlickerDisplacementPixels = max(0.4, glitchAmount);
                float glitchOrFlickerSampleOffset = glitchOrFlickerDisplacementPixels/_ScreenParams.x;
                float glitchOrFlickerIntensity = 0.2 * (sin(tan(i.uv.y)*4.0+_Time.y*20.0) + 1.0);

                half4 glitchOrFlickerOffsetSample = tex2D(_MainTex, float2(i.uv.x+glitchOrFlickerSampleOffset, i.uv.y));

				color = color*(1.0-glitchOrFlickerIntensity) + glitchOrFlickerOffsetSample*glitchOrFlickerIntensity;

				// Scanlines
				float2 ps = i.scr_pos.xy *_ScreenParams.xy / i.scr_pos.w;
				
                int pp = (int)ps.x % 3;
				
				float4 muls;
				if (pp == 1)      { muls = float4(1, _VertsColor, _VertsColor2, 1); }
				else if (pp == 2) { muls = float4(_VertsColor2, 1, _VertsColor, 1); }
				else              { muls = float4(_VertsColor, _VertsColor2, 1, 1); }
				
				return color * muls;
            }
 
            ENDCG
        }


        Pass {
            ZTest Always Cull Off ZWrite Off Fog { Mode off }
 
            CGPROGRAM
 
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #include "UnityCG.cginc"
            #pragma target 3.0
 
			#define PI 3.14159265
			
			
            struct v2f
            {
                float4 pos      : POSITION;
                float2 uv       : TEXCOORD0;
            };
 
            uniform sampler2D _MainTex;
			
			uniform float _BarrelPower;
			
            v2f vert(appdata_img v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }
 
     		float2 Distort(float2 p)
			{
				//float theta  = atan2(p.y, p.x);
				//float radius = length(p);
				//radius = pow(radius, _BarrelPower);
				//p.x = radius * cos(theta);
				//p.y = radius * sin(theta);
				//return 0.5 * (p + 1.0);

				float2 cc = p-0.5;
				float dist = dot(cc,cc) * _BarrelPower;
				return (p+cc*(1.0-dist)*dist);
			}

            half4 frag(v2f i): COLOR
            {
			
				float2 xy = 2.0 * i.uv - 1.0;
				  float2 uv;
				  float d = length(xy);
				  if (1==1 || d < 1.0)
				  {
					uv = Distort(i.uv);
				  }
				  else
				  {
					uv = i.uv;
				  }
				
                return uv.x < 0 || uv.x > 1 || uv.y < 0 || uv.y > 1 ? half4(0.0, 0.0, 0.0, 1.0) : tex2D(_MainTex, uv);
            }
 
            ENDCG
        }
    }
    FallBack "Diffuse"
}