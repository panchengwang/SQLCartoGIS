cmake_minimum_required(VERSION 3.16)

project(PcControls VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(QML_IMPORT_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}" CACHE STRING "")
set(QML_IMPORT_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    CACHE STRING "extra qml import paths"
    FORCE
)

# set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/bin)
# message(STATUS "CMAKE_BINARY_DIR:" ${CMAKE_BINARY_DIR})
find_package(Qt6 6.5 COMPONENTS Quick REQUIRED)

list(APPEND SINGLETON_QML_FILES
    PcStyles.qml
    PcColors.qml
    PcAppHelper.qml
    PcDirHelper.qml
    PcFileHelper.qml
    PcFontIcons.qml
    PcFonts.qml
    PcApplication.qml
)

set_source_files_properties(${SINGLETON_QML_FILES}
    PROPERTIES
    QT_QML_SINGLETON_TYPE true
)


list(APPEND QML_FILES
    PcApplicationWindow.qml
    PcButton.qml
    PcAvatar.qml
    PcSeperator.qml
    PcDialog.qml
    PcLoginDialog.qml
    PcText.qml
    PcTextField.qml
    PcOkCancelButtons.qml
    PcSystemBar.qml
    PcTextInput.qml
    PcSystemSettingPanel.qml
    PcTabView.qml
    PcTabPanel.qml
    PcTabButton.qml
)

list(APPEND SOURCES
    PcMapControl.cpp
    PcImage.cpp
    PcAppUtils.cpp
    PcDirUtils.cpp
    PcFileUtils.cpp
)

list(APPEND HEADERS
    PcMapControl.h
    PcImage.h
    PcAppUtils.h
    PcDirUtils.h
    PcFileUtils.h
)

# qt_add_library(PcControls SHARED)
qt_add_qml_module(PcControls
    PLUGIN_TARGET PcControls
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
    QML_FILES PcCatalog.qml


    # images/pcwang.png
    # fonts/MaterialSymbolsOutlined-Regular.ttf
    # fonts/NotoSansSC-Regular.ttf
)

set_target_properties(PcControls PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER cn.pc.controls
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(PcControls
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(PcControls
    PRIVATE Qt6::Quick)

target_include_directories(PcControls PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(TARGET PcControls POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/fonts ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/fonts
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/images ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/images
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/icons ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cn/pc/controls/icons
    # COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:PcControls> ${CMAKE_BINARY_DIR}/bin/cn/pc/controls/$<TARGET_FILE_NAME:PcControls>
)
