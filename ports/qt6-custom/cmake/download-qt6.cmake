function(download_qt6)

    cmake_parse_arguments(_ext "" "OUT_SOURCE_PATH" "" ${ARGN})

    vcpkg_download_distfile(ARCHIVE_FILE
        URLS "https://download.qt.io/official_releases/qt/6.2/6.2.1/single/qt-everywhere-src-6.2.1.tar.xz"
        FILENAME "qt-everywhere-src-6.2.1.tar.xz"
        SHA512 "67de5b9cf31e1fccff675082b1aaa0c0040e91451b274f103a64f156ed95c24bc1be502af5c857091da735e8aaf7e60cb995654df46b684616a6f03af5b3fbee"
    )

    vcpkg_extract_source_archive_ex(
        OUT_SOURCE_PATH SOURCE_PATH
        ARCHIVE
            ${ARCHIVE_FILE}
        REF
            "6.2.1"
        #PATCHES
            #"patches/QtBuild.patch"
    )

    set(${_ext_OUT_SOURCE_PATH} ${SOURCE_PATH} PARENT_SCOPE)

endfunction()
