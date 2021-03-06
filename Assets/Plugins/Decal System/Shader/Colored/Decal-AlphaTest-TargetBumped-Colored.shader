//
// Author:
//   Based on the Unity3D built-in shaders
//   Andreas Suter (andy@edelweissinteractive.com)
//
// Copyright (C) 2013 Edelweiss Interactive (http://www.edelweissinteractive.com)
//

Shader "Decal/Colored/Cutout Target Bumped Diffuse Colored" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
	}

	SubShader {
		Tags {
			"Queue" = "AlphaTest"
			"IgnoreProjector" = "True"
			"RenderType" = "TransparentCutout"
		}
		Offset -1, -1
		
		CGPROGRAM
		#pragma surface surf Lambert alphatest:_Cutoff

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _Color;

		struct Input {
			float2 uv_MainTex;
			float2 uv2_BumpMap;
			float4 color: Color;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color * IN.color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
			o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv2_BumpMap));
		}
		ENDCG
	}

	FallBack "Decal/Cutout Diffuse"
}
