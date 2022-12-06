// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Test"
{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    SubShader {
        Pass {
            Tags { "queue"="Transparent" "RenderType"="Transparent" }
            Cull Front // first pass renders only back faces 
            //ZWrite Off // don't write to depth buffer 
            //Blend SrcAlpha OneMinusSrcAlpha // use alpha blending
            CGPROGRAM
            #pragma vertex vert 
            // this specifies the vert function as the vertex shader 
            #pragma fragment frag
            // this specifies the frag function as the fragment shader
            #include "UnityCG.cginc"
             //#include "UnityEngine"

            sampler2D _MainTex;
            struct v2f {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };
            v2f vert(appdata_base v) {
                v2f o;
                o.uv = v.texcoord;
                v.vertex.x += sign(v.vertex.x) * sin(_Time.w)/50;
                v.vertex.y += sign(v.vertex.y) * cos(_Time.w)/50;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }
            half4 frag(v2f i) : COLOR {
                half4 c = tex2D(_MainTex, i.uv);
                return c;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
