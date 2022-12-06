Shader "Custom/InputParams"
{
   SubShader { 
      Pass { 
         CGPROGRAM 
 
         #pragma vertex vert  
         #pragma fragment frag 
         #include "UnityCG.cginc"
 
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 col : TEXCOORD0;
         };
 
         vertexOutput vert(appdata_full input) 
         {
            vertexOutput output;

            output.pos = UnityObjectToClipPos(input.vertex);
            output.col = input.texcoord;
            //input.texcoord - float4(1.5, 2.3, 1.1, 0.0); --> input.texcoord - float4(1.5/2.3 - 0.5, 2.3/2.3 - 0.5, 1.1/2.3 - 0.5, 0.0);

            return output;
         }
 
         float4 frag(vertexOutput input) : COLOR 
         {
            return input.col; 
         }
 
         ENDCG  
      }
   }
}
