cmake_minimum_required(VERSION 2.8.12)
project(deltarobot-gui LANGUAGES CXX)
set (CMAKE_CXX_STANDARD_REQUIRED 11)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Core Quick SerialPort REQUIRED)
include( ../libdeltarobot/build/deltarobot.cmake )

add_executable(${PROJECT_NAME} "main.cpp" "qml.qrc")

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick Qt5::SerialPort deltarobot)
