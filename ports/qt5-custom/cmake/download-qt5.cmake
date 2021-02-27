function(download_qt5)

	cmake_parse_arguments(_ext "" "OUT_SOURCE_PATH" "" ${ARGN})

    vcpkg_download_distfile(ARCHIVE_FILE
        URLS "https://download.qt.io/archive/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.tar.xz"
        FILENAME "qt-everywhere-src-5.15.2.tar.xz"
        SHA512 "e7d22cf22e9baa5622f5075ec1b60536ef05c474370a410b6b0a33a4645389b46471e0a38da679e42e9b6ee750bc784f19eb166975f5e4958bc5123a571ea2f0"
    )

	vcpkg_extract_source_archive_ex(
		OUT_SOURCE_PATH SOURCE_PATH
		ARCHIVE "${ARCHIVE_FILE}"
		REF "5.15.2"
	)
	
	set(${_ext_OUT_SOURCE_PATH} ${SOURCE_PATH} PARENT_SCOPE)
	
endfunction()