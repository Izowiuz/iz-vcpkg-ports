# TODO:
#	enable Zstandard support

# test this with:
# .\vcpkg.exe remove qt5-custom  --overlay-ports=F:/git/iz-vcpkg-ports/ports/qt5-custom --triplet=x64-windows-static
# .\vcpkg install qt5-custom --overlay-ports=F:/git/iz-vcpkg-ports/ports/qt5-custom --triplet=x64-windows-static --editable

# ./vcpkg remove qt5-custom --overlay-ports=/home/izowiuz/Git/iz-vcpkg-ports/ports/qt5-custom
# ./vcpkg install qt5-custom --overlay-ports=/home/izowiuz/Git/iz-vcpkg-ports/ports/qt5-custom --editable

# from https://github.com/microsoft/vcpkg/blob/master/scripts/cmake/vcpkg_buildpath_length_warning.cmake
# `Warns the user if their vcpkg installation path might be too long for the package they're installing.`
vcpkg_buildpath_length_warning(37)

# make custom cmake files include-able
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# include custom cmake files
include(download-qt5)
include(configure-qt5)
include(build-qt5)
include(install-qt5)

# start by downloading qt5
download_qt5(
	OUT_SOURCE_PATH SOURCE_PATH
)

# configure it...
configure_qt5(
	SOURCE_PATH ${SOURCE_PATH}
)

# build it...
build_qt5()

# ...and finally install
install_qt5()
