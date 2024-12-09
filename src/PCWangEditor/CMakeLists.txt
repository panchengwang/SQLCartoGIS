cmake_minimum_required(VERSION 3.16)

project(PCWangEditor VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "")

# message(STATUS ${CMAKE_CURRENT_SOURCE_DIR})
find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(PCWangEditor
    main.cpp
)

qt_add_qml_module(PCWangEditor
    URI PCWangEditor
    VERSION 1.0
    QML_FILES
        Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(PCWangEditor PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER cn.pc.gis.editor
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# target_link_libraries(PCWangEditor
#     PRIVATE Qt6::Quick
# )

# target_link_directories(PCWangEditor
#     ../PCControls
# )
target_link_libraries(PCWangEditor
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS PCWangEditor
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


# add_custom_command(TARGET PCWangEditor POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:PCWangEditor> ${CMAKE_BINARY_DIR}/bin/$<TARGET_FILE_NAME:PCWangEditor>
# )

# message(STATUS $<TARGET_FILE_NAME:PCWangEditor>)

# add_custom_command(TARGET PCWangEditor POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:PCWangEditor> ${CMAKE_BINARY_DIR}/bin
# )
