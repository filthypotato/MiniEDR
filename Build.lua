-- premake5.lua
workspace "MiniEDR"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }
   startproject "MiniEDR-App"

   -- Workspace-wide build options for MSVC
   filter "system:windows"
      buildoptions { "/EHsc", "/Zc:preprocessor", "/Zc:__cplusplus" }

OutputDir = "%{cfg.system}-%{cfg.architecture}/%{cfg.buildcfg}"

group "Core"
	include "MiniEDR-Core/Build-Core.lua"
group ""

include "MiniEDR-App/Build-App.lua"
