add_library(MiniEDRCore STATIC
    Source/Core/Core.cpp
)

target_include_directories(MiniEDRCore PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Source
)

