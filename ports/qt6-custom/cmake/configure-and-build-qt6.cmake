function(configure_and_build_qt6)

    # parse external parameters
    cmake_parse_arguments(_ext "" "SOURCE_PATH" "" ${ARGN})

    # setup Perl
    vcpkg_find_acquire_program(PERL)
    get_filename_component(PERL_PATH ${PERL} DIRECTORY)
    vcpkg_add_to_path(${PERL_PATH})
    
    set(_f_DYNAMIC_OPTIONS "")
    
    # vcpkg would like to link statically
    if("${VCPKG_LIBRARY_LINKAGE}" STREQUAL "static")
        list(APPEND _f_DYNAMIC_OPTIONS
            -DINPUT_openssl=linked
            -DBUILD_SHARED_LIBS=OFF
    )
    endif()

    # target is windows and vcpkg would like to statically link CRT libraries
    if(VCPKG_TARGET_IS_WINDOWS AND "${VCPKG_CRT_LINKAGE}" STREQUAL "static")
        list(APPEND _f_DYNAMIC_OPTIONS -DINPUT_static_runtime=yes)
    endif()
   
    vcpkg_cmake_configure(
        SOURCE_PATH
            ${_ext_SOURCE_PATH}
        PREFER_NINJA
        OPTIONS
            ${_f_DYNAMIC_OPTIONS}
            -DFEATURE_relocatable=ON
            -DFEATURE_optimize_full=ON
            -DBUILD_qtshadertools=OFF
            -DBUILD_qtsvg=OFF
            -DBUILD_qtdeclarative=OFF
            -DBUILD_qt3d=OFF
            -DBUILD_qt5compat=OFF
            -DBUILD_qtactiveqt=OFF
            -DBUILD_qtimageformats=OFF
            -DBUILD_qtquickcontrols2=OFF
            -DBUILD_qtmultimedia=OFF
            -DBUILD_qtcharts=OFF
            -DBUILD_qtcoap=OFF
            -DBUILD_qtconnectivity=OFF
            -DBUILD_qtdatavis3d=OFF
            -DBUILD_qttools=OFF
            -DBUILD_qtdoc=OFF
            -DBUILD_qtserialport=OFF
            -DBUILD_qtlocation=OFF
            -DBUILD_qtlottie=OFF
            -DBUILD_qtmqtt=OFF
            -DBUILD_qtopcua=OFF
            -DBUILD_qtquicktimeline=OFF
            -DBUILD_qtquick3d=OFF
            -DBUILD_qtremoteobjects=OFF
            -DBUILD_qtscxml=OFF
            -DBUILD_qtsensors=OFF
            -DBUILD_qtserialbus=OFF
            -DBUILD_qttranslations=OFF
            -DBUILD_qtvirtualkeyboard=OFF
            -DBUILD_qtwayland=OFF
            -DBUILD_qtwebchannel=OFF
            -DBUILD_qtwebengine=OFF
            -DBUILD_qtwebview=OFF
            -DBUILD_qttools=OFF
            -DQT_BUILD_EXAMPLES=FALSE
            -DQT_BUILD_TESTS=FALSE
            -DQT_USE_BUNDLED_BundledFreetype=FALSE
            -DQT_USE_BUNDLED_BundledHarfbuzz=FALSE
            -DQT_USE_BUNDLED_BundledLibpng=FALSE
            -DQT_USE_BUNDLED_BundledPcre2=FALSE
            -DINPUT_gui=no
            -DINPUT_widgets=no
            -DINPUT_dbus=no
            -DINPUT_opengl=no
            -DINPUT_sha3_fast=yes
            -DINPUT_accessibility=no
            -DINPUT_appstore_compliant=no
            -DINPUT_assistant=no
            -DINPUT_clipboard=no
            -DINPUT_dom=no
            -DINPUT_im=no
            -DINPUT_imageformat_bmp=no
            -DINPUT_imageformat_jpeg=no
            -DINPUT_imageformat_png=no
            -DINPUT_imageformat_ppm=no
            -DINPUT_imageformat_xbm=no
            -DINPUT_imageformat_xpm=no
            -DINPUT_imageformatplugin=no
            -DINPUT_movie=no
            -DINPUT_action=no
            -DINPUT_animation=no
            -DINPUT_columnview=no
            -DINPUT_completer=no
            -DINPUT_concatenatetablesproxymodel=no
            -DINPUT_cssparser=no
            -DINPUT_cursor=no
            -DINPUT_datawidgetmapper=no
            -DINPUT_designer=no
            -DINPUT_desktopservices=no
            -DINPUT_dialog=no
            -DINPUT_easingcurve=no
            -DINPUT_filesystemmodel=no
            -DINPUT_gestures=no
            -DINPUT_identityproxymodel=no
            -DINPUT_islamiccivilcalendar=no
            -DINPUT_macdeployqt=no
            -DINPUT_mimetype=no
            -DINPUT_pixeltool=no
            -DINPUT_proxymodel=no
            -DINPUT_qtplugininfo=no
            -DINPUT_shortcut=no
            -DINPUT_sortfilterproxymodel=no
            -DINPUT_sqlmodel=no
            -DINPUT_standarditemmodel=no
            -DINPUT_statemachine=no
            -DINPUT_stringlistmodel=no
            -DINPUT_style_stylesheet=no
            -DINPUT_systemtrayicon=no
            -DINPUT_tabletevent=no
            -DINPUT_tableview=no
            -DINPUT_texthtmlparser=no
            -DINPUT_textmarkdownreader=no
            -DINPUT_textmarkdownwriter=no
            -DINPUT_textodfwriter=no
            -DINPUT_translation=no
            -DINPUT_transposeproxymodel=no
            -DINPUT_treeview=no
            -DINPUT_undocommand=no
            -DINPUT_undogroup=no
            -DINPUT_undostack=no
            -DINPUT_undoview=no
            -DINPUT_wheelevent=no
            -DINPUT_windeployqt=no
            -DINPUT_sql_psql=yes
            -DINPUT_sql_sqlite=yes
            -DINPUT_system_zlib=yes
            -DINPUT_doubleconversion=system
            -DINPUT_pcre=system
            -DINPUT_system_sqlite=yes
            -DINPUT_direct2d=no
            -DINPUT_directfb=no
            -DINPUT_eglfs=no
            -DINPUT_gbm=no
            -DINPUT_kms=no
            -DINPUT_linuxfb=no
            -DINPUT_xcb=no
            -DINPUT_xcb_xlib=no
            -DINPUT_fontconfig=no
            -DINPUT_freetype=no
            -DINPUT_harfbuzz=no
            -DINPUT_cups=no

            -DINSTALL_BINDIR=tools/qt6-custom
            -DINSTALL_LIBEXECDIR=tools/qt6-custom
            -DINSTALL_PLUGINSDIR=Qt6/plugins
            -DINSTALL_DOCDIR=doc/Qt6
            -DINSTALL_INCLUDEDIR=include/Qt6
            -DINSTALL_MKSPECSDIR=share/Qt6/mkspecs
            -DINSTALL_DESCRIPTIONSDIR=share/Qt6/modules

        OPTIONS_RELEASE
            -DCMAKE_BUILD_TYPE=Release
            
        OPTIONS_DEBUG
            -DCMAKE_BUILD_TYPE=Debug
            -DFEATURE_debug=ON

        MAYBE_UNUSED_VARIABLES
            BUILD_qtquickcontrols2
            INPUT_accessibility
            INPUT_action
            INPUT_assistant
            INPUT_clipboard
            INPUT_columnview
            INPUT_completer
            INPUT_cssparser
            INPUT_cups
            INPUT_cursor
            INPUT_datawidgetmapper
            INPUT_designer
            INPUT_desktopservices
            INPUT_dialog
            INPUT_direct2d
            INPUT_directfb
            INPUT_eglfs
            INPUT_filesystemmodel
            INPUT_fontconfig
            INPUT_freetype
            INPUT_gbm
            INPUT_harfbuzz
            INPUT_im
            INPUT_imageformat_bmp
            INPUT_imageformat_jpeg
            INPUT_imageformat_png
            INPUT_imageformat_ppm
            INPUT_imageformat_xbm
            INPUT_imageformat_xpm
            INPUT_imageformatplugin
            INPUT_kms
            INPUT_linuxfb
            INPUT_macdeployqt
            INPUT_movie
            INPUT_opengl
            INPUT_pixeltool
            INPUT_qtplugininfo
            INPUT_standarditemmodel
            INPUT_statemachine
            INPUT_style_stylesheet
            INPUT_systemtrayicon
            INPUT_tabletevent
            INPUT_tableview
            INPUT_texthtmlparser
            INPUT_textmarkdownreader
            INPUT_textmarkdownwriter
            INPUT_textodfwriter
            INPUT_treeview
            INPUT_undocommand
            INPUT_undogroup
            INPUT_undostack
            INPUT_undoview
            INPUT_wheelevent
            INPUT_windeployqt
            INPUT_xcb
            INPUT_xcb_xlib
    )
    
    vcpkg_cmake_build()

endfunction()
