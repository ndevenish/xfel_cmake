cmake_minimum_required(VERSION 3.20...3.30 FATAL_ERROR)

project(xfel LANGUAGES CXX)

# Add the included modules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/")

# General cmake environment configuration
include(SetDefaultBuildRelWithDebInfo) # Default builds to release with debug info
include(AlwaysColourCompilation) # Always show coloured compiler output
set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # Generate compile_commands.json
set(CMAKE_CXX_STANDARD 14)

find_package(Python REQUIRED COMPONENTS Interpreter Development)
set(Boost_USE_STATIC_LIBS OFF) # This is the default everywhere except Windows
find_package(Boost COMPONENTS "python${Python_VERSION_MAJOR}${Python_VERSION_MINOR}" REQUIRED)
find_package(CCTBX REQUIRED COMPONENTS scitbx cctbx rstbx annlib OPTIONAL_COMPONENTS fast_linalg)
find_package(DIALS REQUIRED)

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/src")

# To make it easier to run in-place
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

add_subdirectory(src/xfel)
