function(post_build_and_install_qt6)

    vcpkg_cmake_install(
        ADD_BIN_TO_PATH
    )

    # when we built qt we generated artifacts in two, different places - /package_root/ and /package_root/debug/
    # lets start with making qt output structure a little bit more vcpkg compliant and merge some folders that
    # - I sincerely hope so :P - are identical for release and debug builds: doc, include, mkspecs and modules
    # by just nuking them completly from the debug location
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/doc")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/mkspecs")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/modules")

    # we can use vcpkg_cmake_config_fixup to fix the qt's cmake files
    # but lets skip lib/cmake/Qt6 folder as it is without *target.cmake files
    file(GLOB _f_QT_COMPONENTS LIST_DIRECTORIES true "${CURRENT_PACKAGES_DIR}/lib/cmake/Qt6*")
    list(REMOVE_ITEM _f_QT_COMPONENTS "${CURRENT_PACKAGES_DIR}/lib/cmake/Qt6")

    foreach(_f_LIST_ELEMENT IN LISTS _f_QT_COMPONENTS)

        if(IS_DIRECTORY "${_f_LIST_ELEMENT}")

            string(REPLACE "${CURRENT_PACKAGES_DIR}/lib/cmake/" "" _f_QT_COMPONENT "${_f_LIST_ELEMENT}")
            message(STATUS "Fixing Qt component: ${_f_LIST_ELEMENT} ...")

            vcpkg_cmake_config_fixup(PACKAGE_NAME ${_f_QT_COMPONENT} CONFIG_PATH /lib/cmake/${_f_QT_COMPONENT} DO_NOT_DELETE_PARENT_CONFIG_PATH)

        endif()

    endforeach()

    # there are still some targets to be fixed manually - Qt's plugins
    # debug targets now contain paths defined as "${_IMPORT_PREFIX}/Qt6/plugins" which have to be changed to "${_IMPORT_PREFIX}/debug/Qt6/plugins"
    file(GLOB_RECURSE _f_DEBUG_CMAKE_PLUGIN_TARGETS "${CURRENT_PACKAGES_DIR}/share/**/*Targets-debug.cmake")

    foreach(_f_DEBUG_PLUGIN_TARGET IN LISTS _f_DEBUG_CMAKE_PLUGIN_TARGETS)
        vcpkg_replace_string("${_f_DEBUG_PLUGIN_TARGET}" "{_IMPORT_PREFIX}/Qt6/plugins" "{_IMPORT_PREFIX}/debug/Qt6/plugins")
    endforeach()

    # we can now move /package_root/lib/cmake/Qt6 to the /package_root/share/
    file(COPY "${CURRENT_PACKAGES_DIR}/lib/cmake/Qt6" DESTINATION "${CURRENT_PACKAGES_DIR}/share")

    # we have to manually fix /share/Qt6/Qt6Targets.cmake and add ${VCPKG_TARGET_TRIPLET} to the {_IMPORT_PREFIX} there - not really sure, maybe we borked something earlier?
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/Qt6/Qt6Targets.cmake" "{_IMPORT_PREFIX}/" "{_IMPORT_PREFIX}/\${VCPKG_TARGET_TRIPLET}/")

    # now we can nuke /package_root/lib/cmake, /package_root/debug/share and /package_root/debug/lib/cmake folders
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")

    # we left some - I believe - platform dependent, empty directories and vcpkg do not like it, remove it
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/Qt6/ios")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/Qt6/macos")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/Qt6/QtBuildInternals")

    # we can now nuke /package_root/debug/tools directory
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/tools")

    # we can now copy license files
    file(GLOB _f_LICENSE_FILES "${SOURCE_PATH}/LICENSE.*")

    foreach(_f_LICENSE_FILE IN LISTS _f_LICENSE_FILES)
        file(COPY "${_f_LICENSE_FILE}" DESTINATION "${CURRENT_PACKAGES_DIR}/share/qt6-custom/copyright")
    endforeach()

    # everything now should be in place to copy PDB files
    vcpkg_copy_pdbs()

endfunction()
