add_library(MiniEDRCore STATIC
    Source/Core/Core.cpp
    Source/Core/ProcessInfo.cpp
)

target_include_directories(MiniEDRCore PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Source
)

