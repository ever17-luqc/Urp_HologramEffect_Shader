Shader "VFX Effects /Hologram_Opt"
{
    Properties
    {
        [KeywordEnum(WorldSpace,LocalSpace)]_SpaceMode("物体所用空间",Float)=0
        [KeywordEnum(X,Y,Z)]_PositionDirectionUsed("采样方向",Float)=0
        _EffectDirection("方向强度",Range(0,1))=1
        //
        [Header(Main Attributes)]
        _MainTex("主贴图",2D)="white"{}
        [HDR]_MainCol("主颜色",Color)=(0.5,0.5,0.5,1)
        //菲涅耳参数=============================================================
        [Toggle]_Fresnel("是否启用菲涅耳",Float)=1
        _FresnelPower("菲涅耳强度",Range(0,10))=1
        [HDR]_FresnelColor("菲涅耳颜色",Color)=(1,1,1,1)
        [Toggle(_NORMAL)]_Normal("菲涅耳是否启用normal map",Float)=1
        _NormalMap("菲涅耳法线贴图",2D)="bump"{}
        _NormalStrength("菲涅耳法线强度",Range(0,10))=1
       
        
        
        //扫描线参数===============================================================
         [Header(Shaderd Scan Lines Attributes )]
         [KeywordEnum(Line1,Line2,Both,None)]_ScanLineUsed("扫描线使用",Float)=0
        
         [Header( Scan Line 1)]
         [NoScaleOffset]_ScanLine1Tex("扫描线1 贴图",2D)="black"{}
         [HDR]_ScanLine1Col("扫描线1 颜色",Color)=(0.5,0.5,0.5,1)
         _ScanLine1Frequency("扫描线1 频率（平铺度）",Float)=1
         _ScanLine1Speed("扫描线1 速度",Float)=1
         _ScanLine1Alpha("扫描线1 alpha强度",Range(0,1))=0.8
         [Header( Scan Line 2)]
         [NoScaleOffset]_ScanLine2Tex("扫描线2 贴图",2D)="black"{}
         [HDR]_ScanLine2Col("扫描线2 颜色",Color)=(0.5,0.5,0.5,1)
         _ScanLine2Frequency("扫描线2 频率（平铺度）",Float)=1
         _ScanLine2Speed("扫描线2 速度",Float)=1
         _ScanLine2Alpha("扫描线2 alpha强度",Range(0,1))=0.4
         //Grain参数=================================================================
         [Header(Grain Attributes )]
         [Toggle]_Grain("是否开启Grain",Float)=0
         _GrainScale("Grain 疏密",Float)=1
         _GrainFrequency("Grain 频率",Float)=100
         _GrainValue("Grain强度区间(x-y)",Float)=(0,0.2,0)
         _GrainAffact("Grain影响因子",Range(0,1))=1

         //soft particle参数==========================================================
         [Header(SoftParticle(need depth) Attributes )]
         [Toggle]_SoftParticle("是否开启soft particle",Float)=0
         _SoftParticleIntensity("soft particle强度",Range(0,10))=1
         _SoftParticleAffact("soft particle影响因子",Range(0,1))=0.5
         [HDR]_SoftParticleColor("soft particle 颜色",Color)=(0.5,0.5,0.5,1)
         //Dissolve参数===============================================================
         [Header(Dissolve Attributes )]
         [Toggle]_Dissolve("是否开启溶解",Float)=0
         _DissolveHide("溶解度",Range(-1,1))=0
         _DissolveScale("溶解因子大小(xyz)",Float)=(0.1,1.1,5,0)
         //BoundBoxMask参数===========================================================
         [Header(Position  Alpha  Mask Attributes)]
         [Toggle]_PositionMask("是否开启基于位置的PMask",Float)=0
         [KeywordEnum(PWorld,PLocal)]_PSpace("PMask所用空间",Float)=0
         _PMaskInverse("PMask反转因子",range(0,1))=0
         _PMaskAttenuation("PMask衰减因子",Range(0.01,50))=0.01
         _PMaskSize("PMask大小",Float)=(0.5,0.5,0.5)
         _PMaskCenterOffset("PMask偏移",Float)=(0,0,0)
         //Alpha Texture参数==========================================================
         [Header(  Alpha Texture Mask Attributes)]
         [Toggle]_AlphaTexMask("是否使用AlphaTexture遮罩",Float)=0
         _AlphaTex("AlphaTexture",2D)="white"{}
         _AlphaTexAffact("AlphaTexture影响因子",Range(0,1))=1
         //Color Blink 参数
         [Header( Color Blink Attributes)]
         [Toggle]_ColorBlink("是否开启颜色闪烁",Float)=0
         _ColorBlinkFrequency("颜色闪烁频率",Float)=3
         _ColorBlinkAffact("颜色闪烁影响因子",Range(0,1))=1

         //Tex Glitch 参数
         [Header( Texture Glitch Attributes)]
         [Toggle]_TexGlitch("是否开启基于采样图的TexGlitch",Float)=0
         [NoScaleOffset]_TexGlitchTexture("TexGlitch 贴图",2D)="white"{}
         _TexGlitchFrequency("TexGlitch平铺",Float)=1
         _TexGlitchSpeed("TexGlitch速度",Float)=1
         _TexGlitchDirOffset("TexGlitch方向偏移(xyz)",Float)=(0.1,0,0,0)

         //Random Glitch 参数
         [Header( Random Glitch Attributes)]
         [Toggle]_RandomGlitch("是否开启基于随机的RGlitch",Float)=0
          _RandomGlitchTiling("RGlitch noise 平铺",Float)=1
          _RandomGlitchSpeedXY("RGlitch XY速度(参与Noise计算)",Float)=(2,-1,0,0)
          _RandomGlitchDir("RGlitch 方向XYZ",Float)=(0.5,0,0)
          _SubNoiseTiling("RGlitch SubNoise 平铺",Float)=4
          _NoiseRemap("RGlitch Remap(xy:old-min max zw:new-min max)",Float)=(0,1,-1,1)
          _RandomGlitchStrength("RGlitch 强度",Range(0,1))=0.5
          _RandomBlinkStrength("RGlitch Blink强度",Range(0,1))=1

          //Voxelization 参数
          [Header(Voxelization Attributes)]
         [Toggle]_Voxelization("是否开启体素化",Float)=0
         _VoxelizationScale("体素大小",Float)=10
         _VoxelizationAffact("体素影响因子",Range(0,1))=1

          

          
         

    }
    SubShader
    {
        Tags
        {
           
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "Queue"="Transparent"
        }
        
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite off
            Cull back
            
            Tags 
            { 
                "LightMode"="UniversalForward"
            }
            
         
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //Shader Feature
            #pragma shader_feature _SPACEMODE_WORLDSPACE _SPACEMODE_LOCALSPACE
            #pragma shader_feature _POSITIONDIRECTIONUSED_X _POSITIONDIRECTIONUSED_Y _POSITIONDIRECTIONUSED_Z
            #pragma shader_feature _SCANLINEUSED_LINE1 _SCANLINEUSED_LINE2 _SCANLINEUSED_BOTH _SCANLINEUSED_NONE  
            #pragma shader_feature _ _FRESNEL_ON
            #pragma shader_feature _ _NORMAL
            #pragma shader_feature _ _DISSOLVE_ON
            #pragma shader_feature _ _SOFTPARTICLE_ON
            #pragma shader_feature _ _POSITIONMASK_ON
            #pragma shader_feature _PSPACE_PWORLD _PSPACE_PLOCAL
            #pragma shader_feature _ALPHATEXMASK_ON
            #pragma shader_feature _GRAIN_ON
            #pragma shader_feature _COLORBLINK_ON
            #pragma shader_feature _TEXGLITCH_ON
            #pragma shader_feature _RANDOMGLITCH_ON
            #pragma shader_feature _VOXELIZATION_ON

            
         
       
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "HologramInclude.hlsl"
          
            
            
            CBUFFER_START(UnityPerMaterial)
          half4 _MainCol;
          float4 _MainTex_ST;
          half _EffectDirection;
          float _ScanLine1Frequency;
          float _ScanLine1Speed;
           float _ScanLine2Frequency;
           float _ScanLine2Speed;
           half _ScanLine2Alpha;
           half _ScanLine1Alpha;
           half4 _ScanLine1Col;
           half4 _ScanLine2Col;
           half _FresnelPower;
           half _NormalStrength;
           float4 _NormalMap_ST;
           half4 _FresnelColor;
           half _DissolveHide;
           float3 _DissolveScale;
           half _SoftParticleIntensity;
           half _SoftParticleAffact;
            half _PMaskInverse;
            half _PMaskAttenuation;
            float3 _PMaskSize;
            float3 _PMaskCenterOffset;
            float4 _AlphaTex_ST;
            float _AlphaTexAffact;
            half4 _SoftParticleColor;
            float _GrainFrequency;
            float _GrainScale;
            float2 _GrainValue;
            half _GrainAffact;
            half _ColorBlinkAffact;
            float _ColorBlinkFrequency;
             // float4 _TexGlitchTexture_ST;
            float _TexGlitchSpeed;
            float _TexGlitchFrequency;
            float3 _TexGlitchDirOffset;
            float2 _RandomGlitchSpeedXY;
            float _RandomGlitchTiling;
            float _SubNoiseTiling;
            half4 _NoiseRemap;
            half  _RandomGlitchStrength;
            half _RandomBlinkStrength;
            half3 _RandomGlitchDir;
            float _VoxelizationScale;
            half _VoxelizationAffact;
            CBUFFER_END
     
          TEXTURE2D(_MainTex);
          SAMPLER(sampler_MainTex); 
         
          TEXTURE2D(_ScanLine1Tex);
          SAMPLER(sampler_ScanLine1Tex);
          
          TEXTURE2D(_ScanLine2Tex);
          SAMPLER(sampler_ScanLine2Tex);
          

           TEXTURE2D(_NormalMap);
           SAMPLER(sampler_NormalMap);
           
           TEXTURE2D(_CameraDepthTexture);
           SAMPLER(sampler_CameraDepthTexture);
           
            TEXTURE2D(_AlphaTex);
            SAMPLER(sampler_AlphaTex);
            
            TEXTURE2D(_TexGlitchTexture);
            SAMPLER(sampler_TexGlitchTexture);
          
            

            struct Attributes
            {
                float3 positionOS : POSITION;
                float2 uv :TEXCOORD0;
            
                float3 normal:NORMAL;
            #ifdef _NORMAL
                float4 tangent:TANGENT;
            #endif
           
                
            };
            
           
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
              
                float4 uv :TEXCOORD0;
             #if defined(_FRESNEL_ON)||(_DISSOLVE_ON)||(_POSITIONMASK_ON)||(_GRAIN_ON)

                 float3 positionWS:TEXCOORD1;

             #endif

             #ifdef _FRESNEL_ON
           
                float3 viewDir:TEXCOORD2;
                
             #endif

              #ifndef _NORMAL
                float3 normalWS:TEXCOORD3;
              #else 
                float3 TBN[3]:TEXCOORD4;
              #endif
 
            // #if defined(_SCANLINEUSED_LINE1)||(_SCANLINEUSED_LINE2)||(_SCANLINEUSED_BOTH)
                float sampleDir:TEXCOORD7;
            // #endif
            #ifdef _SOFTPARTICLE_ON
                float4 screenUv:TEXCOORD8;
            #endif

            #ifdef _ALPHATEXMASK_ON
                float2 AlphaTexUv:TEXCOORD9;
            #endif

              
          


            };
            
            
        
            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                o.uv.xy = TRANSFORM_TEX(v.uv,_MainTex);
                o.uv.zw = TRANSFORM_TEX(v.uv,_NormalMap);
             
                
                   //Tex Glitch part
                float3 texGlitchOffset=float3(0,0,0);
             #ifdef _TEXGLITCH_ON
               float2 texGlitchUvWithTNO=v.uv*_TexGlitchFrequency+_Time.y*_TexGlitchSpeed;
               half sampleTexGlitchResult= SAMPLE_TEXTURE2D_LOD(_TexGlitchTexture, sampler_TexGlitchTexture, texGlitchUvWithTNO, 0.0).r;
               float3 objScale=float3(length(float3(UNITY_MATRIX_M[0].x,UNITY_MATRIX_M[1].x,UNITY_MATRIX_M[2].x)),
                                     length(float3(UNITY_MATRIX_M[0].y,UNITY_MATRIX_M[1].y,UNITY_MATRIX_M[2].y)),
                                     length(float3(UNITY_MATRIX_M[0].z,UNITY_MATRIX_M[1].z,UNITY_MATRIX_M[2].z))  
                                    );
               
                texGlitchOffset=_TexGlitchDirOffset/objScale*sampleTexGlitchResult;

             #endif

                //end Tex Glitch part



                //空间选择与方向选择决定采样方向
            #ifdef _SPACEMODE_WORLDSPACE
                float3 posUsedBySpace=TransformObjectToWorld(v.positionOS);
              #ifdef  _POSITIONDIRECTIONUSED_X
                o.sampleDir=posUsedBySpace.x;
              #elif _POSITIONDIRECTIONUSED_Y
                 o.sampleDir=posUsedBySpace.y;
              #else
                 o.sampleDir=posUsedBySpace.z;
              #endif
             #else
                float3 posUsedBySpace=v.positionOS;
              #ifdef  _POSITIONDIRECTIONUSED_X
                o.sampleDir=posUsedBySpace.x;
              #elif _POSITIONDIRECTIONUSED_Y
                 o.sampleDir=posUsedBySpace.y;
              #else
                 o.sampleDir=posUsedBySpace.z;
              #endif
            #endif


              //Random Glitch part ==================================================
              float3 RandomGlitchOffset=float3(0,0,0);
            #ifdef _RANDOMGLITCH_ON
            float3 RandomGlitchVector=float3(0,0,0);
              float2 Noise1InputXY=float2(o.sampleDir*_RandomGlitchTiling+_Time.y*_RandomGlitchSpeedXY.x, _Time.y*_RandomGlitchSpeedXY.y);
              float NoiseFactor1=Unity_GradientNoise_float( Noise1InputXY,5);
              NoiseFactor1=saturate(remap(NoiseFactor1,_NoiseRemap.x,_NoiseRemap.y,_NoiseRemap.z,_NoiseRemap.w));

              float RandomGlitchBlink=frac(sin(_Time.y*3)*2)+_RandomBlinkStrength;
              RandomGlitchBlink=saturate(remap(RandomGlitchBlink,_NoiseRemap.x,_NoiseRemap.y,_NoiseRemap.z,_NoiseRemap.w));

              NoiseFactor1*=RandomGlitchBlink;

              //sub noise
              float2 Noise2InputXY=float2(Noise1InputXY.x*_SubNoiseTiling,Noise1InputXY.y);
              float NoiseFactor2=Unity_GradientNoise_float(Noise2InputXY,10);
              NoiseFactor2=saturate(remap(NoiseFactor2,_NoiseRemap.x,_NoiseRemap.y,_NoiseRemap.z,_NoiseRemap.w));

              NoiseFactor2*=RandomGlitchBlink;

              RandomGlitchVector=(NoiseFactor2+NoiseFactor1)*_RandomGlitchDir*_RandomGlitchStrength;


             RandomGlitchOffset=RandomGlitchVector;

            #endif
              

             //end Glitch part=======================================================

             //Voxelization part
             #ifdef _VOXELIZATION_ON

             o.positionCS = lerp(TransformObjectToHClip(v.positionOS+RandomGlitchOffset+texGlitchOffset),
             TransformObjectToHClip( round((v.positionOS+RandomGlitchOffset+texGlitchOffset)*_VoxelizationScale)/_VoxelizationScale),
             _VoxelizationAffact);

             #else  

             o.positionCS = TransformObjectToHClip(v.positionOS)+half4(TransformWorldToHClipDir(RandomGlitchOffset)+TransformWorldToHClipDir(texGlitchOffset),0);


             #endif



             //end Voxelization





                //
            #ifdef _FRESNEL_ON
                o.positionWS=TransformObjectToWorld(v.positionOS);
                o.viewDir=normalize(_WorldSpaceCameraPos.xyz-o.positionWS);
                #ifndef _NORMAL
                o.normalWS=TransformObjectToWorldNormal(v.normal);
                #else
                float3 worldNormal=TransformObjectToWorldNormal(v.normal);
                float3 worldTangent=TransformObjectToWorldDir(v.tangent);
                //Create T to W matrix TBN
                float3x3 TBN=CreateTangentToWorld(worldNormal,worldTangent,v.tangent.w);
                //float3 o.TBN[0]=float3(TBN[0].x,TBN[1].x,TBN[2].x);
                //float3 o.TBN[1]=float3(TBN[0].y,TBN[1].y,TBN[2].y);
                //float3 o.TBN[2]=float3(TBN[0].z,TBN[1].z,TBN[2].z);
                o.TBN[0]=TBN[0];
                o.TBN[1]=TBN[1];
                o.TBN[2]=TBN[2];

                
                #endif
                //compute screenUv 
             #ifdef _SOFTPARTICLE_ON
                 o.screenUv=ComputeScreenPos(o.positionCS); //screenUv without / W
                 

            #endif
            #endif
            
            #ifdef _ALPHATEXMASK_ON
             o.AlphaTexUv=TRANSFORM_TEX(v.uv,_AlphaTex);
            #endif
                
              
                return o;
            }

            half4 frag(Varyings i) : SV_TARGET 
            {    
                half4 col=(0,0,0,0);
                float3 MainTexCol=SAMPLE_TEXTURE2D(_MainTex,sampler_MainTex,i.uv.xy);

            //Grain part========================================================================================================================
            
             #ifdef _GRAIN_ON

             
             
             float  GrainNoise=Simplex3DNoise(i.positionWS*_GrainScale+_Time.y*_GrainFrequency)*0.6+0.4;  // Grain Noise Tex
             GrainNoise=lerp(0,lerp(_GrainValue.x,_GrainValue.y,GrainNoise),_GrainAffact);
             col.rgb+=GrainNoise;

            #endif

            //end grain part====================================================================================================================
                

           //scan line part======================================================================================================================
            half4 ScanLineTex=(0,0,0,0);
                        //Line1
            #ifdef _SCANLINEUSED_LINE1
                ScanLineTex.rgb=SAMPLE_TEXTURE2D(_ScanLine1Tex,sampler_ScanLine1Tex,i.sampleDir.xx*_ScanLine1Frequency+_ScanLine1Speed*_Time.y).rgb;
                ScanLineTex.rgb*=_ScanLine1Col;
                ScanLineTex.a+=luminance(ScanLineTex.rgb)*_ScanLine1Alpha;
                col+=ScanLineTex;
                        //Line2
            #elif _SCANLINEUSED_LINE2
                ScanLineTex.rgb=SAMPLE_TEXTURE2D(_ScanLine2Tex,sampler_ScanLine2Tex,i.sampleDir.xx*_ScanLine2Frequency+_ScanLine2Speed*_Time.y).rgb;
                ScanLineTex.rgb*=_ScanLine2Col;
                ScanLineTex.a+=luminance(ScanLineTex.rgb)*_ScanLine2Alpha;
                col+=ScanLineTex;
                         //Both
            #elif _SCANLINEUSED_BOTH
                ScanLineTex.rgb=SAMPLE_TEXTURE2D(_ScanLine1Tex,sampler_ScanLine1Tex,i.sampleDir.xx*_ScanLine1Frequency+_ScanLine1Speed*_Time.y).rgb*_ScanLine1Col+
                SAMPLE_TEXTURE2D(_ScanLine2Tex,sampler_ScanLine2Tex,i.sampleDir.xx*_ScanLine2Frequency+_ScanLine2Speed*_Time.y).rgb*_ScanLine2Col;
                ScanLineTex.a+=luminance(SAMPLE_TEXTURE2D(_ScanLine1Tex,sampler_ScanLine1Tex,i.sampleDir.xx*_ScanLine1Frequency+_ScanLine1Speed*_Time.y).rgb)*_ScanLine1Alpha
                +luminance(SAMPLE_TEXTURE2D(_ScanLine2Tex,sampler_ScanLine2Tex,i.sampleDir.xx*_ScanLine2Frequency+_ScanLine2Speed*_Time.y).rgb)*_ScanLine2Alpha;
                col+=ScanLineTex;
            #endif
            //end scan line part

            //fresnel part========================================================================================================================
            
            #ifdef _FRESNEL_ON

            half4 FresnelCol=(0,0,0,0);
            half FresnelFactor=0;

             #ifdef _NORMAL
                   
                     half3 normalTex=UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap,sampler_NormalMap,i.uv.zw));
                   half3x3 TBN=half3x3(i.TBN[0],i.TBN[1],i.TBN[2]);
                   half3 worldNormal=TransformTangentToWorld(normalTex,TBN); //mul(normalTex, TBN); = 右乘TBN转置矩阵
                   worldNormal=float3(worldNormal.xy*_NormalStrength,lerp(1,worldNormal.b,saturate(_NormalStrength)));
                   FresnelFactor=FastPow(1-saturate(dot(i.viewDir,worldNormal)),_FresnelPower);

             #else  
                  FresnelFactor=FastPow(1-saturate(dot(i.viewDir,i.normalWS)),_FresnelPower);
                  
               
             #endif
             FresnelCol.rgb=FresnelFactor*_FresnelColor*_MainCol;
             col.rgb+=FresnelCol.rgb;
             col.a+=FresnelFactor;

            #endif

            //end fresnel part

            //(soft particle)depth part========================================================================================================================
           #ifdef _SOFTPARTICLE_ON

           float TDepth=SAMPLE_TEXTURE2D(_CameraDepthTexture,sampler_CameraDepthTexture,i.screenUv.xy/i.screenUv.w);
           half linearTDepth=LinearEyeDepth(TDepth,_ZBufferParams);
           float SDepth=i.positionCS.z;
           half linearSDepth=LinearEyeDepth(SDepth,_ZBufferParams);
           half DeltaDepth=(linearTDepth-linearSDepth);
           half softParticleFactor=lerp(1,FastPow(DeltaDepth,_SoftParticleIntensity)*DeltaDepth,_SoftParticleAffact);
           half4 softParticleCol=_SoftParticleColor*softParticleFactor*_MainCol;

           col.rgb+=softParticleCol.rgb;
           col.a*=softParticleFactor;
           col.a=saturate(col.a);

           
           #endif
            //

            //Dissolve part(Alpha Multiply)====================================================================================================================
            #ifdef _DISSOLVE_ON

             half dissolveAlpha=0;
             float3 DissolveNoiseGenFactor=i.positionWS*_DissolveScale;
             float  DissolveNoise=Simplex3DNoise(DissolveNoiseGenFactor)*0.6+0.4;  // Dissolve Noise Tex
             DissolveNoise=saturate(DissolveNoise-_DissolveHide);

             dissolveAlpha=DissolveNoise;
             col.a*=dissolveAlpha;
             


            #endif
        
            //end Dissolve part


            //POS alpha part==============================================================================================================================
            #ifdef _POSITIONMASK_ON
             half PAlphaFactor=0;
             float3 center=float3(0,0,0);
             float PDistanceMask=0;
             #ifdef _PSPACE_PWORLD
             //float3(unity_ObjectToWorld[0].w, unity_ObjectToWorld[1].w, unity_ObjectToWorld[2].w)或者unity_ObjectToWorld._m03_m13_m23 : Transform Position


              center+=unity_ObjectToWorld._m03_m13_m23+_PMaskCenterOffset; 
              PDistanceMask=1-saturate(length(max(abs(i.positionWS-center)-0.5*_PMaskSize,0))/_PMaskAttenuation);
            
              PDistanceMask=lerp(PDistanceMask,1-PDistanceMask,_PMaskInverse);

             #else  
              PDistanceMask=1-saturate(length(max(abs(i.positionWS-center)-0.5*_PMaskSize,0))/_PMaskAttenuation);

              PDistanceMask=lerp(PDistanceMask,1-PDistanceMask,_PMaskInverse);
               
              

             #endif
            col.a*=PDistanceMask;

            #endif

            //end  POS alpha part

            //Alpha Tex part=============================================================================================================================
            #ifdef _ALPHATEXMASK_ON

            half alphaTexCol=lerp(1,SAMPLE_TEXTURE2D(_AlphaTex,sampler_AlphaTex,i.AlphaTexUv).r,_AlphaTexAffact);
             col.a*=alphaTexCol;
            
            #endif

          
            //end alpha Tex part

            //Color Blink part===========================================================================================================================
            #ifdef _COLORBLINK_ON
            half BlinkFactor=lerp(1,frac(sin(_Time.y*_ColorBlinkFrequency)*2),_ColorBlinkAffact);
            col.rgb*=BlinkFactor;
            #endif

            //end color blink

             
                 col.rgb*=MainTexCol.rgb;
                 col.a*=_MainCol.a;
                return col ;
            }
            
            ENDHLSL
        }
    }
    CustomEditor "Hologram_hlsl_Editor"
}
