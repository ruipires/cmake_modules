if(__add_headercheck)
	return()
endif()
set(__add_headercheck YES)

if(NOT TARGET all_headercheck)
    add_custom_target(all_headercheck)
    set_target_properties(all_headercheck PROPERTIES EXCLUDE_FROM_ALL TRUE)
endif()

function(add_header_check _targetname)
    set(_files)
    set(_number 0)
    foreach(_source ${ARGN})
        get_source_file_property(_headercheck_loc "${_source}" LOCATION)
        get_filename_component(_filename ${_source} NAME)
        get_filename_component(_extension ${_source} EXT)
        get_filename_component(_realpath ${_source} REALPATH)

        if("${_extension}" STREQUAL ".h") # TODO compare with a list of header extensions

            if(_headercheck_loc)
                # This file has a source file property, carry on.
                get_source_file_property(_headercheck_lang "${_source}" LANGUAGE)
                if("${_headercheck_lang}" MATCHES "CXX")
                    list(APPEND _files "${_headercheck_loc}")
                endif()
            else()
                # This file doesn't have source file properties - figure it out.
                get_filename_component(_headercheck_loc "${_source}" ABSOLUTE)
                if(EXISTS "${_headercheck_loc}")
                    list(APPEND _files "${_headercheck_loc}")
                else()
                    message(FATAL_ERROR
                        "Adding header self sufficiency check for file target ${_targetname}: "
                        "File ${_source} does not exist or needs a corrected path location "
                        "since we think its absolute path is ${_headercheck_loc}")
                endif()
            endif()

            set(_tmp_target ${_number}_${_filename}.self_sufficient_header_test)
            file(WRITE "${CMAKE_BINARY_DIR}/${_tmp_target}.cpp" "#include \"${_realpath}\"")
            add_library(${_tmp_target} OBJECT ${_source} ${CMAKE_BINARY_DIR}/${_tmp_target}.cpp)
            add_dependencies(all_headercheck ${_tmp_target})

            math(EXPR _number "${_number} + 1")
        else()
            message(WARNING "skipping header check on source file ${_source}")
        endif()
    endforeach()

endfunction()
