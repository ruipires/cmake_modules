find_path(CATCH_INCLUDE_DIR catch.hpp ${CATCH_DIR} ${THIRD_PARTY_DIR}/Catch/)

# Handle the QUIETLY and REQUIRED arguments and set CATCH_FOUND to TRUE if all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Catch DEFAULT_MSG CATCH_INCLUDE_DIR)

if(CATCH_INCLUDE_DIR)
    set(CATCH_FOUND TRUE)

    add_library(Catch INTERFACE)
    target_include_directories(Catch INTERFACE ${CATCH_INCLUDE_DIR})
endif()

