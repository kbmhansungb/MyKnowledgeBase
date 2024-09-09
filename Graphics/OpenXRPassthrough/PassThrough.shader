Shader "WR/CustomSelectivePassthroughWithScreenUV"
{
    Properties
    {
        _SelectFlag("Select Flag", Float) = 0
        _SelectColor("Select Color", Color) = (1, 0, 0, 0.5)

        _OutlineWidthColor("Outline WidthColor", Color) = (0, 1, 0, 1)
        _OutlineHeightColor("Outline HeightColor", Color) = (0, 1, 0, 1)
        _OutlineThickness("Outline Thickness", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            Name "ObjectPass"
            Tags { "LightMode" = "UniversalForward" }
            ZWrite On
            ZTest LEqual

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityShaderVariables.cginc"

            sampler2D _CameraDepthTexture; // 뎁스 텍스처 선언

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;   // 클립 좌표
                float4 posWorld : TEXCOORD1;   // 월드 좌표 
                float4 screenPos : TEXCOORD2;  // 스크린 공간 좌표
            };

            float _SelectFlag;
            fixed4 _SelectColor;

            float4 _OutlineHeightColor;
            float4 _OutlineWidthColor;
            float _OutlineThickness;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.screenPos = ComputeScreenPos(o.vertex);
                
                o.uv = v.uv;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 screenUV = i.screenPos.xy / i.screenPos.w;
                float depth = LinearEyeDepth(tex2D(_CameraDepthTexture, screenUV).r);
                float currentDepth = length(_WorldSpaceCameraPos - i.posWorld.xyz);
                if (currentDepth > depth)
                {   
                    clip(-1);
                    return float4(1, 1, 1, 1);
                }

                // 윤곽선 두께를 계산
                float thickness = _OutlineThickness / min(_ScreenParams.x, _ScreenParams.y) * 2.0;
                    
                bool isWidthOutline = i.uv.x < thickness || i.uv.x > 1 - thickness;
                bool isHeightOutline = i.uv.y > 1 - thickness || i.uv.y < thickness;

                if (_SelectFlag == 1)
                {
                    if (isWidthOutline)
                    {
                        return _OutlineWidthColor;
                    }

                    if (isHeightOutline)
                    {
                        return _OutlineHeightColor;
                    }

                    return _SelectColor;
                }
                else
                {
                    return float4(0, 0, 0, 0);
                }
            }
            ENDCG
        }
    }
}
