# C++ 编译

* [Makefiles, autotools & CMake](https://indico.cern.ch/event/1127483/attachments/2387906/4081279/makefile.pdf)

## 【示例】CMake 使用 FetchContent

```cmake
cmake_minimum_required(VERSION 3.26)
project(Learning_CMake)

set(CMAKE_CXX_STANDARD 23)

include(FetchContent)

FetchContent_Declare(fmt
        GIT_REPOSITORY https://github.com/fmtlib/fmt.git)
FetchContent_MakeAvailable(fmt)

FetchContent_Declare(Boost
#        GIT_REPOSITORY https://github.com/boostorg/boost.git
        URL https://github.com/boostorg/boost/releases/download/boost-1.83.0/boost-1.83.0.tar.xz
        DOWNLOAD_EXTRACT_TIMESTAMP ON)
FetchContent_MakeAvailable(Boost)

add_executable(Learning_CMake main.cpp)
target_link_libraries(Learning_CMake PRIVATE fmt Boost::uuid Boost::lexical_cast)
```

## 将动态链接的二进制可执行文件转换为静态链接的二进制可执行文件

使用 [Ermine](https://magicermine.com/trial.html) 进行转换（Light 版本够用，一般无需 Pro）

```bash
$PROGRAM $DYNAMIC --output $STATIC
```

