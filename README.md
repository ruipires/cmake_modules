# (extra) CMake Modules

This repositories contains my custom build extra cmake modules.
I used them as complement or replacement for the built-in FindXYZ.cmake modules.
They usually use detect the library just like other FindXYZ.cmake modules, but in addition, they define a virtual library with the same name you passed to the find_package command, and defines its INTERFACE properties.
This way you can simply find it and link to it and all necessary flags will be added to your compilation options.


# General Usage

Just append the path to where this repository is checked out:

```cmake
set(CMAKE_MODULE_PATH "~/prj/opt/cmake" ${CMAKE_MODULE_PATH})
```

And then use a find_package command and link your executable with the imported library.

# Notes on specific modules

## FindCatch.cmake
Finds the catch.hpp single header from http://catch-lib.net .
This header could just be copied over to your project tree, but I like to have a single third party folder with the versions of the dependencies I'm using.

Usage example:
```cmake
find_package(Catch)
add_executable(Test ${SOURCE_FILES})
target_link_libraries(Test Catch)
```


# License
The contents of this repository are licensed under the [Boost Software License|http://www.boost.org/users/license.html]


