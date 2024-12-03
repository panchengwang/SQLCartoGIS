cmake_minimum_required(VERSION 3.16)

project(PCWangGIS VERSION 0.1 LANGUAGES CXX)

add_subdirectory(PCControls)
add_subdirectory(PCWangEditor)

# file(REMOVE_RECURSE ${CMAKE_BINARY_DIR}/bin)
# file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

