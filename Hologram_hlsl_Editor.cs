using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;


public class Hologram_hlsl_Editor : ShaderGUI
{
    private List<MaterialProperty> propertiesList = new List<MaterialProperty>();

    //
    private List<MaterialProperty> fresnelProps= new List<MaterialProperty>();
    private List<MaterialProperty> scanLineProps = new List<MaterialProperty>();
    private List<MaterialProperty> grainProps = new List<MaterialProperty>();
    private List<MaterialProperty> softParticleProps = new List<MaterialProperty>();
    private List<MaterialProperty> dissolveProps = new List<MaterialProperty>();
    private List<MaterialProperty> boundBoxProps = new List<MaterialProperty>();
    private List<MaterialProperty> alphaTextureProps = new List<MaterialProperty>();
    private List<MaterialProperty> colorBlinkProps = new List<MaterialProperty>();
    private List<MaterialProperty> texGlitchProps = new List<MaterialProperty>();
    private List<MaterialProperty> randomGlitchProps = new List<MaterialProperty>();
    private List<MaterialProperty> voxelizationProps = new List<MaterialProperty>();

    //feature prop
    private MaterialProperty fresnelFeature;
    private MaterialProperty normalFeature;
    private MaterialProperty scanLineFeature;
    private MaterialProperty grainFeature;
    private MaterialProperty softParticleFeature;
    private MaterialProperty dissolveFeature;
    private MaterialProperty boundboxFeature;
    private MaterialProperty alphaTexFeature;
    private MaterialProperty colorBlinkFeature;
    private MaterialProperty texGlitchFeature;
    private MaterialProperty randomGlitchFeature;
    private MaterialProperty voxelizationFeature;
    private MaterialProperty pMaskSpaceFeature;






    private static bool isExpandedFresnel;
    private static bool isExpandedScanLine;
    private static bool isExpandedGrain;
    private static bool isExpandedSoftParticle;
    private static bool isExpandedDissolve;
    private static bool isExpandedBoundBox;
    private static bool isExpandedAlphaTex;
    private static bool isExpandedColorBlink;
    private static bool isExpandedTexGlitch;
    private static bool isExpandedRandomGlitch;
    private static bool isExpandedVoxelization;

    //

    private MaterialProperty mainTexProp;
    private MaterialProperty mainColProp;
    private MaterialProperty spaceChooseProp;
    private MaterialProperty sampleDirProp;
    private MaterialProperty sampleDirStrengthProp;
    private string[] spaceModeKeywords = { "_SPACEMODE_WORLDSPACE", "_SPACEMODE_LOCALSPACE" };
    private string[] spaceModeName = { "World", "Local" };
    private int[] spaceValues = { 0, 1};
    private string[] scanLineKeywords = { "_SCANLINEUSED_LINE1", "_SCANLINEUSED_LINE2", "_SCANLINEUSED_BOTH", "_SCANLINEUSED_NONE" };
    private string[] DirKeywords = { "_POSITIONDIRECTIONUSED_X", "_POSITIONDIRECTIONUSED_Y", "_POSITIONDIRECTIONUSED_Z" };
    private int[] dirValues = { 0, 1, 2 };
    private string[] dirName = { "X", "Y", "Z" };
    private string[] pMaskKeywords = { "_PSPACE_PWORLD", "_PSPACE_PLOCAL" };
    private MaterialEditor materialEditor;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        //base.OnGUI(materialEditor, properties);
        this.materialEditor = materialEditor;

        propertiesList.Clear();
        propertiesList.AddRange(properties);

        fresnelProps.Clear();
        scanLineProps.Clear();
        grainProps.Clear();
        softParticleProps.Clear();
        dissolveProps.Clear();
        boundBoxProps.Clear();
        alphaTextureProps.Clear();
        colorBlinkProps.Clear();
        texGlitchProps.Clear();
        randomGlitchProps.Clear();
        voxelizationProps.Clear();

        EditorGUI.BeginChangeCheck();
        //
        foreach (var p in propertiesList)
        {
            string propName = p.displayName;
           
            if (propName.Equals("主贴图"))
            {
                mainTexProp = p;
            }
            else if (propName.Equals("主颜色"))
            {
                mainColProp = p;
            }
            else if (propName.Equals("方向强度"))
            {
                sampleDirStrengthProp = p;
            }
            else if (propName.Equals("采样方向"))
            {
                sampleDirProp = p;
            }
            else if (propName.Equals("物体所用空间"))
            {
                spaceChooseProp = p;
            }
            else if (propName.Contains("菲涅耳"))
            {
                if (propName.Equals("是否启用菲涅耳"))
                    fresnelFeature = p;
                else if (propName.Equals("菲涅耳是否启用normal map"))
                    normalFeature = p;
                else
                    fresnelProps.Add(p);
            }
            else if (propName.Contains("扫描线"))
            { 
                if (propName.Equals("扫描线使用"))
                    scanLineFeature = p;
                else
                
                scanLineProps.Add(p);
            }
            else if (propName.Contains("Grain"))
            {
                if (propName.Equals("是否开启Grain"))
                    grainFeature = p;
                else
                    grainProps.Add(p);
            }
            else if (propName.Contains("soft"))
            {
                if (propName.Equals("是否开启soft particle"))
                    softParticleFeature = p;
                else
                    softParticleProps.Add(p);
            }
            else if (propName.Contains("溶解"))
            {
                if (propName.Equals("是否开启溶解"))
                    dissolveFeature = p;
                else
                    dissolveProps.Add(p);
            }
            else if (propName.Contains("PMask"))
            {   if (propName.Equals("是否开启基于位置的PMask"))
                    boundboxFeature = p;
                else if (propName.Equals("PMask所用空间"))
                    pMaskSpaceFeature = p;
                boundBoxProps.Add(p);
            }
            else if (propName.Contains("AlphaTexture"))
            {
                if (propName.Equals("是否使用AlphaTexture遮罩"))
                    alphaTexFeature = p;
                else
                    alphaTextureProps.Add(p);
            }
            else if (propName.Contains("颜色闪烁"))
            {
                if(propName.Equals("是否开启颜色闪烁"))
                    colorBlinkFeature = p;
                else
                colorBlinkProps.Add(p);
            }
            else if (propName.Contains("TexGlitch"))
            {
                if (propName.Equals("是否开启基于采样图的TexGlitch"))
                    texGlitchFeature = p;
                else
                    texGlitchProps.Add(p);
            }
            else if (propName.Contains("RGlitch"))
            {
                if (propName.Equals("是否开启基于随机的RGlitch"))
                    randomGlitchFeature = p;
                else
                    randomGlitchProps.Add(p);
            }
            else if (propName.Contains("体素"))
            {
                if (propName.Equals("是否开启体素化"))
                    voxelizationFeature = p;
                else
                    voxelizationProps.Add(p);
            }

        }
        //===================================================================================
        DrawFeatureEnum(spaceChooseProp,spaceModeName,spaceValues,spaceModeKeywords);
        DrawFeatureEnum(sampleDirProp, dirName, dirValues, DirKeywords);
        materialEditor.RangeProperty(sampleDirStrengthProp, "方向强度");
        materialEditor.TexturePropertySingleLine(new GUIContent("主贴图"), mainTexProp);
        if (!mainTexProp.flags.HasFlag((System.Enum)MaterialProperty.PropFlags.NoScaleOffset))
        {
            materialEditor.TextureScaleOffsetProperty(mainTexProp);
        }
        materialEditor.ColorProperty(mainColProp, "主颜色");


           //Fresnel

           isExpandedFresnel = EditorGUILayout.Foldout(isExpandedFresnel, "菲涅耳参数部分参数");
        if (isExpandedFresnel)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(fresnelFeature, "_FRESNEL_ON",true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            DrawFeatureToggle(normalFeature, "_NORMAL",false);
            foreach (var p in fresnelProps)
            {
               
                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }
        //Scan Line
        isExpandedScanLine= EditorGUILayout.Foldout(isExpandedScanLine, "扫描线部分参数");
        if (isExpandedScanLine)
        {
            EditorGUI.indentLevel++;
            string[] scanEnumNames = { "Line1", "Line2", "全部开启", "全部关闭" };
            int[] scanEnumValues = { 0, 1, 2, 3 };
            DrawFeatureEnum(scanLineFeature, scanEnumNames, scanEnumValues, scanLineKeywords);
           
            foreach (var p in scanLineProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //
        //Grain 
        isExpandedGrain = EditorGUILayout.Foldout(isExpandedGrain, "Grain部分参数");
        if (isExpandedGrain)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(grainFeature, "_GRAIN_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in grainProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }


        //soft particle
        isExpandedSoftParticle = EditorGUILayout.Foldout(isExpandedSoftParticle, "soft particle部分参数");
        if (isExpandedSoftParticle)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(softParticleFeature, "_SOFTPARTICLE_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in softParticleProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //dissolve
        isExpandedDissolve = EditorGUILayout.Foldout(isExpandedDissolve, "溶解部分参数");
        if (isExpandedDissolve)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(dissolveFeature, "_DISSOLVE_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in dissolveProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //
        //Pmask
        isExpandedBoundBox = EditorGUILayout.Foldout(isExpandedBoundBox, "基于position的alpha遮罩参数");
        if (isExpandedBoundBox)
        {
            string[] pMaskNames = { "world", "local" };
            int[] pMaskValues = { 0, 1 };
            EditorGUI.indentLevel++;
            
            DrawFeatureToggle(boundboxFeature, "_POSITIONMASK_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            DrawFeatureEnum(pMaskSpaceFeature, pMaskNames, pMaskValues, pMaskKeywords);
            foreach (var p in boundBoxProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //Alpha tex
        isExpandedAlphaTex = EditorGUILayout.Foldout(isExpandedAlphaTex, "基于Texture的alpha遮罩参数");
        if (isExpandedAlphaTex)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(alphaTexFeature, "_ALPHATEXMASK_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in alphaTextureProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //color blink
        isExpandedColorBlink = EditorGUILayout.Foldout(isExpandedColorBlink, "Color Blink参数");
        if (isExpandedColorBlink)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(colorBlinkFeature, "_COLORBLINK_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in colorBlinkProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }
        //tex glitch
        isExpandedTexGlitch = EditorGUILayout.Foldout(isExpandedTexGlitch, "基于贴图的Glitch参数");
        if (isExpandedTexGlitch)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(texGlitchFeature, "_TEXGLITCH_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in texGlitchProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //random glitch
        isExpandedRandomGlitch = EditorGUILayout.Foldout(isExpandedRandomGlitch, "RandomGlitch参数（simplex Noise）");
        if (isExpandedRandomGlitch)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(randomGlitchFeature, "_RANDOMGLITCH_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in randomGlitchProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

        //voxelization

        isExpandedVoxelization = EditorGUILayout.Foldout(isExpandedVoxelization, "体素化参数");
        if (isExpandedVoxelization)
        {
            EditorGUI.indentLevel++;
            DrawFeatureToggle(voxelizationFeature, "_VOXELIZATION_ON", true);   //true 默认开启   false 默认不开启，关联shader部分的初始值
            foreach (var p in voxelizationProps)
            {

                DrawProperty(p);
            }
            EditorGUI.indentLevel--;
        }

    }
    //Draw shader function==================================================================================



    //Enum feature
    private void DrawFeatureEnum(MaterialProperty prop,string[] names,int[] values,string[] keywords) 
    {
        string propName = prop.displayName;
        bool hasMixedValue = prop.hasMixedValue;
        if(hasMixedValue)
        {
            EditorGUI.showMixedValue = true;
        }
        int value = (int)prop.floatValue;
        EditorGUI.BeginChangeCheck();
        
            value = EditorGUILayout.IntPopup(propName, value, names, values);
        if(EditorGUI.EndChangeCheck())
        {
            prop.floatValue = value;
         //
            for(int i=0;i<keywords.Length;i++)
            {
                if(value==i)
                {
                    foreach (var t in materialEditor.targets)
                    {
                        Material m = t as Material;
                        m.EnableKeyword(keywords[i]);
                    }
                }
                else{
                    foreach (var t in materialEditor.targets)
                    {
                        Material m = t as Material;
                        m.DisableKeyword(keywords[i]);
                    }
                }
            }




        //
        }
        if (hasMixedValue)
            EditorGUI.showMixedValue = false;
    }

    //toggle feature
         private void DrawFeatureToggle(MaterialProperty prop,string keyword,bool defalutState)
    {
        string propName = prop.displayName;
        bool hasMixedValue = prop.hasMixedValue;
        if(hasMixedValue)
        {
            EditorGUI.showMixedValue=true;
        }
        
        bool value = (int)prop.floatValue == 1;
        
        EditorGUI.BeginChangeCheck();
        value = EditorGUILayout.Toggle(propName, value);
        if (EditorGUI.EndChangeCheck())
        {   
            prop.floatValue = value ?1:0;
            if(value)
            {
                foreach(var t in materialEditor.targets)
                {
                    Material m = t as Material;
                    m.EnableKeyword(keyword);
                }
            }
            else
            {
                foreach (var t in materialEditor.targets)
                {
                    Material m = t as Material;
                    m.DisableKeyword(keyword);
                }
            }
            
        }
        if (hasMixedValue)
            EditorGUI.showMixedValue = false;
    }

    







    private void DrawProperty(MaterialProperty prop)
        {
        string propName = prop.displayName;
        switch(prop.type)
        {
               case MaterialProperty.PropType.Color:
                { materialEditor.ColorProperty(prop, propName);
                    break;
                }
            case MaterialProperty.PropType.Float:
                {
                    materialEditor.FloatProperty(prop, propName);

                    break;
                }
            case MaterialProperty.PropType.Range:
                {
                    materialEditor.RangeProperty(prop, propName);
                    break;
                }
            case MaterialProperty.PropType.Texture:
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent(propName),prop);
                    if(!prop.flags.HasFlag((System.Enum)MaterialProperty.PropFlags.NoScaleOffset))
                    {
                        materialEditor.TextureScaleOffsetProperty(prop);
                    }
                    break;
                }
            case MaterialProperty.PropType.Vector:
                {
                    materialEditor.VectorProperty(prop, propName);
                    break;
                }
        }

        }


       
        

    

}
