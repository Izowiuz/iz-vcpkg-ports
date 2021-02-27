function(install_qt5)

	# setup make and nmake / jom
    if(CMAKE_HOST_WIN32)
		vcpkg_find_acquire_program(JOM)
		set(_f_INVOKE "${JOM}" /J ${VCPKG_CONCURRENCY})
    else()
        find_program(MAKE make)
        set(_f_INVOKE "${MAKE}" -j${VCPKG_CONCURRENCY})
    endif()

	if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE MATCHES "[Rr][Ee][Ll][Ee][Aa][Ss][Ee]")
		set(_t_BUILD_TYPE "RELEASE")
		
		list(APPEND _f_BUILD_TYPES ${_t_BUILD_TYPE})
		set(_f_BUILD_SHORT_NAME_${_t_BUILD_TYPE} "rel")
		set(_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE} "")

		unset(_t_BUILD_TYPE)
	endif()
	
	if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE MATCHES "[Dd][Ee][Bb][Uu][Gg]")
		set(_t_BUILD_TYPE "DEBUG")
		
		list(APPEND _f_BUILD_TYPES ${_t_BUILD_TYPE})
		set(_f_BUILD_SHORT_NAME_${_t_BUILD_TYPE} "dbg")
		set(_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE} "/debug")
		
		unset(_t_BUILD_TYPE)
	endif()

	foreach(_t_BUILD_TYPE ${_f_BUILD_TYPES})
		set(_t_CURRENT_TRIPLET ${TARGET_TRIPLET}-${_f_BUILD_SHORT_NAME_${_t_BUILD_TYPE}})
	
		message(STATUS "Installing ${_t_CURRENT_TRIPLET}...")
	
	    vcpkg_execute_required_process(
            COMMAND ${_f_INVOKE} install
            WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${_t_CURRENT_TRIPLET}
            LOGNAME install-${_t_CURRENT_TRIPLET}
        )
        message(STATUS "Installing ${_t_CURRENT_TRIPLET} done!")
	
		unset(_t_CURRENT_TRIPLET)
	endforeach()

endfunction()