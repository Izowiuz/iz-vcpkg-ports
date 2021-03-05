function(install_qt5)

	# setup make and nmake / jom
    if(CMAKE_HOST_WIN32)
		vcpkg_find_acquire_program(JOM)
		set(_f_INVOKE "${JOM}" /J ${VCPKG_CONCURRENCY})
    else()
        find_program(MAKE make)
        set(_f_INVOKE "${MAKE}" -j${VCPKG_CONCURRENCY})
    endif()

	unset(_f_BUILD_TYPES)
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

	# nuke debug/lib/cmake
	file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")
	
	# copy lib/cmake to share/cmake
	file(COPY "${CURRENT_PACKAGES_DIR}/lib/cmake/" DESTINATION "${CURRENT_PACKAGES_DIR}/share/cmake/")
	
	# nuke lib/cmake
	file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake")

	# copy & nuke lib/*Qt5Bootstrap.* files
	file(GLOB _f_QT5_BOOTSTRAP_LIST "${CURRENT_PACKAGES_DIR}/lib/*Qt5Bootstrap.*")
	file(COPY ${_f_QT5_BOOTSTRAP_LIST} DESTINATION "${CURRENT_PACKAGES_DIR}/tools/qt5/lib/")
	file(REMOVE ${_f_QT5_BOOTSTRAP_LIST})
	
	# copy & nuke debug/lib/*Qt5Bootstrap.* files
	file(GLOB _f_QT5_BOOTSTRAP_DEBUG_LIST "${CURRENT_PACKAGES_DIR}/debug/lib/*Qt5Bootstrap.*")
	file(COPY ${_f_QT5_BOOTSTRAP_DEBUG_LIST} DESTINATION "${CURRENT_PACKAGES_DIR}/tools/qt5/debug/lib/")
	file(REMOVE ${_f_QT5_BOOTSTRAP_DEBUG_LIST})

	# install license file
    if(EXISTS "${SOURCE_PATH}/LICENSE.LGPLv3")
        set(_f_LICENSE_PATH "${SOURCE_PATH}/LICENSE.LGPLv3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.LGPL3")
        set(_f_LICENSE_PATH "${SOURCE_PATH}/LICENSE.LGPL3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.GPLv3")
        set(_f_LICENSE_PATH "${SOURCE_PATH}/LICENSE.GPLv3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.GPL3")
        set(_f_LICENSE_PATH "${SOURCE_PATH}/LICENSE.GPL3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.GPL3-EXCEPT")
        set(_f_LICENSE_PATH "${SOURCE_PATH}/LICENSE.GPL3-EXCEPT")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.FDL")
        set(_f_LICENSE_PATH "${SOURCE_PATH}/LICENSE.FDL")
    endif()
    file(INSTALL ${_f_LICENSE_PATH} DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
    
    # fixup pkgconfig dirs
    vcpkg_fixup_pkgconfig()

endfunction()
