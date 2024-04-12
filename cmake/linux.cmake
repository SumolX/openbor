set(COMMON_COMPILER_FLAGS "${COMMON_COMPILER_FLAGS}  -Wno-void-pointer-to-enum-cast -Wno-deprecated-declarations")
set(ARCH_SUFFIX "")

set(BUILD_SDL     ON)
set(BUILD_SDL_IO  ON)
set(BUILD_OPENGL  ON)
set(BUILD_LOADGL  ON)
set(BUILD_GFX     ON)
set(BUILD_VORBIS  ON)
set(BUILD_WEBM    ON)
set(BUILD_PTHREAD ON)
set(BUILD_STATIC  ON)

if(TARGET_ARCH STREQUAL "arm64")
  set(ARCH_SUFFIX "-arm64")
  set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc-12)
  set_target_properties(${PROJECT_NAME}
    PROPERTIES
    LINK_DIRECTORIES "/usr/lib/aarch64-linux-gnu"
  )
elseif(TARGET_ARCH STREQUAL "x86")
  set(ARCH_SUFFIX "-x86")
  set(CMAKE_C_COMPILER i686-linux-gnu-gcc-12)
  add_definitions(-DELF)
  set(BUILD_MMX ON)
  set_target_properties(${PROJECT_NAME}
    PROPERTIES
    LINK_DIRECTORIES "/usr/lib/i386-linux-gnu"
  )
else()
  if(CMAKE_SYSTEM_PROCESSOR STREQUAL "amd64")
    set(ARCH_SUFFIX "-x64")
    add_definitions(-DELF -DAMD64)
  elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86")
    set(ARCH_SUFFIX "-x86")
    add_definitions(-DELF)
    set(BUILD_MMX ON)
  endif()
endif()

add_definitions(-DLINUX)

target_include_directories(${PROJECT_NAME} PRIVATE 
  /usr/include
  /usr/include/SDL2
)

# Distribution Preperation
add_custom_command(TARGET ${PROJECT_NAME}
  POST_BUILD
  COMMAND mkdir -p ../engine/releases/LINUX/Logs
  COMMAND mkdir -p ../engine/releases/LINUX/Paks
  COMMAND mkdir -p ../engine/releases/LINUX/Saves
  COMMAND mkdir -p ../engine/releases/LINUX/ScreenShots
  COMMAND cp -a ${PROJECT_NAME} ../engine/releases/LINUX/${PROJECT_NAME}${ARCH_SUFFIX}
)
