cmake_minimum_required(VERSION 3.16)

project(ScControls VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
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

message(STATUS "os is ${CMAKE_SYSTEM_NAME}")


# set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/bin)
# message(STATUS "CMAKE_BINARY_DIR:" ${CMAKE_BINARY_DIR})
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


list(APPEND SINGLETON_QML_FILES
    ScStyles.qml
    ScColors.qml
    ScAppHelper.qml
    ScDirHelper.qml
    ScFileHelper.qml
    ScFontIcons.qml
    ScFonts.qml
    ScApplication.qml
)

set_source_files_properties(${SINGLETON_QML_FILES}
    PROPERTIES
    QT_QML_SINGLETON_TYPE true
)


list(APPEND QML_FILES
    ScApplicationWindow.qml
    ScButton.qml
    ScAvatar.qml
    ScSeperator.qml
    ScDialog.qml
    ScLoginDialog.qml
    ScText.qml
    ScTextField.qml
    ScOkCancelButtons.qml
    ScSystemBar.qml
    ScTextInput.qml
    ScSystemSettingPanel.qml
    ScTabView.qml
    ScTabPanel.qml
    ScTabButton.qml
    ScCatalog.qml
    ScMapView.qml
    ScPopup.qml
    ScLoginPopup.qml
    ScUserMenu.qml
    ScAccountPanel.qml
    ScNotify.qml
    ScCheckbox.qml
    ScLogPanel.qml
    ScConnector.qml
    ScMapPanel.qml
    ScWebMapControl.qml
    ScWebMapSwitcher.qml
    ScStatusBar.qml
)

list(APPEND SOURCES
    ScMapControl.cpp
    ScImage.cpp
    ScAppUtils.cpp
    ScDirUtils.cpp
    ScFileUtils.cpp
    ScAjax.cpp
    ScAffine.cpp
    ScProjection.cpp
    ScOGRPoint.cpp
    ScAffineParameter.cpp
)

list(APPEND HEADERS
    ScMapControl.h
    ScImage.h
    ScAppUtils.h
    ScDirUtils.h
    ScFileUtils.h
    ScAjax.h
    ScAffine.h
    ScProjection.h
    ScOGRPoint.h
    ScAffineParameter.h
)

# qt_add_library(ScControls SHARED)
qt_add_qml_module(ScControls
    PLUGIN_TARGET ScControls
    OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls
    URI cn.pc.controls
    VERSION 1.0
    QML_FILES
    ${QML_FILES}
    ${SINGLETON_QML_FILES}

    SOURCES
    ${SOURCES}
    ${HEADERS}

    RESOURCES
    SOURCES ScSpatialDatabase.h ScSpatialDatabase.cpp
    SOURCES ScGeometryIO.h ScGeometryIO.cpp


    # SOURCES ScAffine_copy.cpp
    # SOURCES ScAffine_copy.h

    # images/pcwang.png
    # fonts/MaterialSymbolsOutlined-Regular.ttf
    # fonts/NotoSansSC-Regular.ttf

)

set_target_properties(ScControls PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER cn.pc.controls
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(ScControls
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(ScControls PRIVATE
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

target_include_directories(ScControls PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${CAIRO_INCLUDE_DIRS})

add_custom_command(TARGET ScControls POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/fonts
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/images
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/icons
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/webmap


    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/fonts ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/fonts
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/images ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/images
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/icons ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/icons
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/webmap ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/webmap
    # COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:ScControls> ${CMAKE_BINARY_DIR}/bin/cn/pc/controls/$<TARGET_FILE_NAME:ScControls>
)
