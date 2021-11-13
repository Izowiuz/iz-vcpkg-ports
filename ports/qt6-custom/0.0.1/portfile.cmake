 # from https://github.com/microsoft/vcpkg/blob/master/scripts/cmake/vcpkg_buildpath_length_warning.cmake
# `Warns the user if their vcpkg installation path might be too long for the package they're installing.`
vcpkg_buildpath_length_warning(37)

# make custom cmake files include-able
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# include custom cmake files
include(download-qt6)
include(configure-qt6)
include(build-qt6)
include(post-build-and-install-qt6)

# start by downloading qt6
download_qt6(
    OUT_SOURCE_PATH SOURCE_PATH
)

# configure it...
configure_qt6(
    SOURCE_PATH ${SOURCE_PATH}
)

# build it...
build_qt6()

# ... do some fixuping and install it
post_build_and_install_qt6()
