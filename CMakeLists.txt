cmake_minimum_required(VERSION 3.20)
project(MiniEDR LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Always export compile commands for clangd
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(MiniEDR-Core)
add_subdirectory(MiniEDR-App)

