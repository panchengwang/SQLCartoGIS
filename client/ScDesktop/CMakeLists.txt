cmake_minimum_required(VERSION 3.16)

project(SQLCartoDesktop VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(VCPKG_PATH "D:/vcpkg")
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_PATH}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
set(CMAKE_PREFIX_PATH "${VCPKG_PATH}/installed/x64-windows/share")
set(PKG_CONFIG_EXECUTABLE "${VCPKG_PATH}/installed/x64-windows/tools/pkgconf/pkgconf.exe")
set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${VCPKG_PATH}/installed/x64-windows/lib/pkgconfig")

# set(QML_IMPORT_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}" CACHE STRING "")
set(QML_IMPORT_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    CACHE STRING "extra qml import paths"
    FORCE
)
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "")

# message(STATUS ${CMAKE_CURRENT_SOURCE_DIR})
find_package(Qt6 6.5 COMPONENTS  Core Gui Qml Quick WebView REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Sql)
find_package(GEOS CONFIG REQUIRED)
find_package(GDAL CONFIG REQUIRED)

set(TIFF_INCLUDE_DIR "${VCPKG_PATH}/installed/x64-windows/include")
set(TIFF_LIBRARY "${VCPKG_PATH}/installed/x64-windows/lib/tiff.lib")
# find_package(TIFF REQUIRED)
set(ZLIB_INCLUDE_DIR "${VCPKG_PATH}/installed/x64-windows/include")
set(ZLIB_LIBRARY "${VCPKG_PATH}/installed/x64-windows/lib/zlib.lib")
find_package(PROJ CONFIG REQUIRED)
# find_package(cairo CONFIG REQUIRED)
# find_package(ZLIB REQUIRED)
find_package(PkgConfig REQUIRED)
# pkg_check_modules(PROJ REQUIRED proj)
pkg_check_modules(CAIRO REQUIRED cairo)
# pkg_check_modules(JSON_C REQUIRED json-c)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(SQLCartoDesktop
    main.cpp
)

qt_add_qml_module(SQLCartoDesktop
    URI SQLCartoDesktop
    VERSION 1.0
    QML_FILES
        Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(SQLCartoDesktop PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER cn.pc.gis.editor
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# target_link_libraries(SQLCartoDesktop
#     PRIVATE Qt6::Quick
# )

# target_link_directories(SQLCartoDesktop
#     ../PCControls
# )
target_link_libraries(SQLCartoDesktop PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Sql
    GEOS::geos
    GDAL::GDAL
    PROJ::proj
    ${CAIRO_LINK_LIBRARIES}
)

target_include_directories(SQLCartoDesktop PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${CAIRO_INCLUDE_DIRS})
include(GNUInstallDirs)
install(TARGETS SQLCartoDesktop
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


# add_custom_command(TARGET  POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:> ${CMAKE_BINARY_DIR}/bin/$<TARGET_FILE_NAME:>
# )

# message(STATUS $<TARGET_FILE_NAME:>)

# add_custom_command(TARGET  POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:> ${CMAKE_BINARY_DIR}/bin
# )
