project "MiniEDR-App"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. OutputDir .. "/%{prj.name}")
    objdir ("bin-int/" .. OutputDir .. "/%{prj.name}")

    files {
        "Source/**.cpp",
        "Source/**.h",
        "Source/**.hpp"
    }

    includedirs {
        "../MiniEDR-Core/Source"
    }

    libdirs {
        "../bin/" .. OutputDir .. "/MiniEDR-Core"
    }

    links {
        "MiniEDRCore"
    }

