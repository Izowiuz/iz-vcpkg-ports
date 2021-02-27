function(configure_qt5)

	# lets setup our stuff ...
	# _f_QT_CONFIGURE_ENTRYPOINT
	#	what will be used for launching Qt's configure
	
	# _f_QT_CONFIGURE_OPTIONS
	#	configure options passed to _f_QT_CONFIGURE_ENTRYPOINT
	
	# _f_BUILD_DIRECTORY
	#	directory we will be building Qt in

	# _f_BUILD_TYPES
	# build types to be built

	# parse external parameters
	cmake_parse_arguments(_ext "" "SOURCE_PATH" "" ${ARGN})
	
	if(CMAKE_HOST_WIN32)
		set(_f_QT_CONFIGURE_ENTRYPOINT "configure.bat")
	else()
		set(_f_QT_CONFIGURE_ENTRYPOINT "configure")
	endif()
	
	set(_f_QT_CONFIGURE_OPTIONS "")
	list(APPEND _f_QT_CONFIGURE_OPTIONS
		-prefix ${CURRENT_INSTALLED_DIR}
		-opensource
		-confirm-license
		-qt-zlib
		-qt-pcre
		-qt-doubleconversion
		-no-gui
		-no-dbus
		-no-accessibility
		-no-opengl
		-no-pkg-config
		-no-libjpeg
		-no-libpng
		-no-harfbuzz
		-no-xcb
		-no-xcb-xlib
		-no-eglfs
		-no-xkbcommon
		-no-kms
		-no-feature-xml
		-no-feature-testlib
		-no-feature-gif
		-no-feature-ico
		-no-feature-texthtmlparser
		-no-feature-textodfwriter
		-no-feature-effects
		-no-feature-im
		-no-feature-dom
		-no-feature-filesystemmodel
		-no-feature-graphicsview
		-no-feature-graphicseffect
		-no-feature-sizegrip
		-no-feature-calendarwidget
		-no-feature-printpreviewwidget
		-no-feature-keysequenceedit
		-no-feature-colordialog
		-no-feature-filedialog
		-no-feature-fontdialog
		-no-feature-printpreviewdialog
		-no-feature-progressdialog
		-no-feature-inputdialog
		-no-feature-errormessage
		-no-feature-wizard
		-no-feature-datawidgetmapper
		-no-feature-imageformat_bmp
		-no-feature-imageformat_ppm
		-no-feature-imageformat_xbm
		-no-feature-imageformat_png
		-no-feature-imageformat_jpeg
		-no-feature-image_heuristic_mask
		-no-feature-image_text
		-no-feature-colornames
		-no-feature-cups
		-no-feature-freetype
		-no-feature-translation
		-no-feature-codecs
		-no-feature-big_codecs
		-no-feature-ftp
		-no-feature-bearermanagement
		-no-feature-completer
		-no-feature-fscompleter
		-no-feature-desktopservices
		-no-feature-mimetype
		-no-feature-systemtrayicon
		-no-feature-undocommand
		-no-feature-undostack
		-no-feature-undogroup
		-no-feature-undoview
		-no-feature-statemachine
		-no-feature-zstd
		-no-feature-cssparser
		-no-feature-sqlmodel
		-no-feature-textmarkdownreader
		-no-feature-textmarkdownwriter
		-no-feature-itemmodeltester
		-nomake examples
		-nomake tests
		-skip qt3d
		-skip qtandroidextras
		-skip qtcanvas3d
		-skip qtcharts
		-skip qtconnectivity
		-skip qtdatavis3d
		-skip qtdeclarative
		-skip qtdoc
		-skip qtgamepad
		-skip qtgraphicaleffects
		-skip qtimageformats
		-skip qtlocation
		-skip qtmacextras
		-skip qtmultimedia
		-skip qtnetworkauth
		-skip qtpurchasing
		-skip qtquickcontrols
		-skip qtquickcontrols2
		-skip qtscript
		-skip qtscxml
		-skip qtsensors
		-skip qtserialbus
		-skip qtserialport
		-skip qtspeech
		-skip qtsvg
		-skip qttools
		-skip qttranslations
		-skip qtvirtualkeyboard
		-skip qtwayland
		-skip qtwebchannel
		-skip qtwebengine
		-skip qtwebview
		-skip qtwinextras
		-skip qtx11extras
		-skip qtremoteobjects
		-skip qtxmlpatterns
		-sql-psql
		-sql-sqlite
		-verbose
	)

	# vcpkg would like to link statically
    if("${VCPKG_LIBRARY_LINKAGE}" STREQUAL "static")
        list(APPEND _f_QT_CONFIGURE_OPTIONS -static)
    endif()

	# target is windows and vcpkg would like to statically link CRT libraries
    if(VCPKG_TARGET_IS_WINDOWS AND "${VCPKG_CRT_LINKAGE}" STREQUAL "static")
        list(APPEND _f_QT_CONFIGURE_OPTIONS -static-runtime)
	endif()

	# qt dependencies -->
	
	set(_f_DL_PTHREAD "-ldl -lpthread")
	set(_f_DL_PTHREAD "-ldl -lpthread")
	
	# psql
	find_library(PSQL_RELEASE NAMES pq libpq PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
	find_library(PSQL_DEBUG NAMES pq libpq pqd libpqd PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)
	if(NOT (PSQL_RELEASE MATCHES ".*\.so") AND NOT (PSQL_DEBUG MATCHES ".*\.so"))
		find_library(PSQL_COMMON_RELEASE NAMES pgcommon libpgcommon PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
		find_library(PSQL_COMMON_DEBUG NAMES pgcommon libpgcommon pgcommond libpgcommond PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)
		find_library(PSQL_PORT_RELEASE NAMES pgport libpgport PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
		find_library(PSQL_PORT_DEBUG NAMES pgport libpgport pgportd libpgportd PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)
	endif()
	
	# pcre2
	find_library(PCRE2_RELEASE NAMES pcre2-16 PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
	find_library(PCRE2_DEBUG NAMES pcre2-16 pcre2-16d PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)

	# sqlite
	find_library(SQLITE_RELEASE NAMES sqlite3 PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
	find_library(SQLITE_DEBUG NAMES sqlite3 sqlite3d PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)

	# zstd
	find_library(ZSTD_RELEASE NAMES zstd zstd_static PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
	find_library(ZSTD_DEBUG NAMES zstdd zstd_staticd PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)
	
	# openssl
	find_library(SSL_RELEASE ssl ssleay32 PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
	find_library(SSL_DEBUG ssl ssleay32 ssld ssleay32d PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)
	find_library(EAY_RELEASE libeay32 crypto libcrypto PATHS "${CURRENT_INSTALLED_DIR}/lib" NO_DEFAULT_PATH)
	find_library(EAY_DEBUG libeay32 crypto libcrypto libeay32d cryptod libcryptod PATHS "${CURRENT_INSTALLED_DIR}/debug/lib" NO_DEFAULT_PATH)

	# qt dependencies <--

	set(_f_WIN_LIBS "ws2_32.lib secur32.lib advapi32.lib shell32.lib crypt32.lib user32.lib gdi32.lib")
	set(_f_LINUX_LIBS "ldl -lpthread")

	if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE MATCHES "[Rr][Ee][Ll][Ee][Aa][Ss][Ee]")
		set(_t_BUILD_TYPE "RELEASE")
		
		list(APPEND _f_BUILD_TYPES ${_t_BUILD_TYPE})
		set(_f_BUILD_SHORT_NAME_${_t_BUILD_TYPE} "rel")
		set(_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE} "")
		set(_f_BUILD_OPTIONS_${_t_BUILD_TYPE} "")

		if(VCPKG_TARGET_IS_WINDOWS)
			list(APPEND _f_BUILD_OPTIONS_${_t_BUILD_TYPE}
				-release
				"ZLIB_LIBS=${ZLIB_RELEASE}"
				"PCRE2_LIBS=${PCRE2_RELEASE}"
				"PSQL_LIBS=${PSQL_RELEASE} ${PSQL_PORT_RELEASE} ${PSQL_TYPES_RELEASE} ${PSQL_COMMON_RELEASE} ${SSL_RELEASE} ${EAY_RELEASE} ${_f_WIN_LIBS}"
				"SQLITE_LIBS=${SQLITE_RELEASE}"
				"OPENSSL_LIBS=${SSL_RELEASE} ${EAY_RELEASE} ${_f_WIN_LIBS}"
				"QMAKE_LIBS_PRIVATE+=${ZSTD_RELEASE}"
				-I ${CURRENT_INSTALLED_DIR}/include
				-L ${CURRENT_INSTALLED_DIR}${_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE}}/lib
			)			
		elseif(VCPKG_TARGET_IS_LINUX)
			list(APPEND _f_BUILD_OPTIONS_${_t_BUILD_TYPE}
				-release
				"ZLIB_LIBS=${ZLIB_RELEASE}"
				"PCRE2_LIBS=${PCRE2_RELEASE}"
				"PSQL_LIBS=${PSQL_RELEASE} ${PSQL_PORT_RELEASE} ${PSQL_TYPES_RELEASE} ${PSQL_COMMON_RELEASE} ${SSL_RELEASE} ${EAY_RELEASE} ${_f_LINUX_LIBS}"
				"SQLITE_LIBS=${SQLITE_RELEASE} ${_f_LINUX_LIBS}"
				"OPENSSL_LIBS=${SSL_RELEASE} ${EAY_RELEASE} ${_f_LINUX_LIBS}"
				"QMAKE_LIBS_PRIVATE+=${ZSTD_RELEASE}"
				-I ${CURRENT_INSTALLED_DIR}/include
				-L ${CURRENT_INSTALLED_DIR}${_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE}}/lib
			)
		endif()
		
		unset(_t_BUILD_TYPE)
	endif()
	
	if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE MATCHES "[Dd][Ee][Bb][Uu][Gg]")
		set(_t_BUILD_TYPE "DEBUG")
		
		list(APPEND _f_BUILD_TYPES ${_t_BUILD_TYPE})
		set(_f_BUILD_SHORT_NAME_${_t_BUILD_TYPE} "dbg")
		set(_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE} "/debug")
		set(_f_BUILD_OPTIONS_${_t_BUILD_TYPE} "")
		
		if(VCPKG_TARGET_IS_WINDOWS)
			list(APPEND _f_BUILD_OPTIONS_${_t_BUILD_TYPE}
				-debug
				"ZLIB_LIBS=${ZLIB_DEBUG}"
				"PCRE2_LIBS=${PCRE2_DEBUG}"
				"PSQL_LIBS=${PSQL_DEBUG} ${PSQL_PORT_DEBUG} ${PSQL_TYPES_DEBUG} ${PSQL_COMMON_DEBUG} ${SSL_DEBUG} ${EAY_DEBUG} ${_f_WIN_LIBS}"
				"SQLITE_LIBS=${SQLITE_DEBUG}"
				"OPENSSL_LIBS=${SSL_DEBUG} ${EAY_DEBUG} ${_f_WIN_LIBS}"
				"QMAKE_LIBS_PRIVATE+=${ZSTD_DEBUG}"
				-I ${CURRENT_INSTALLED_DIR}/include
				-L ${CURRENT_INSTALLED_DIR}${_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE}}/lib
			)			
		elseif(VCPKG_TARGET_IS_LINUX)
			list(APPEND _f_BUILD_OPTIONS_${_t_BUILD_TYPE}
				-debug
				"ZLIB_LIBS=${ZLIB_DEBUG}"
				"PCRE2_LIBS=${PCRE2_DEBUG}"
				"PSQL_LIBS=${PSQL_DEBUG} ${PSQL_PORT_DEBUG} ${PSQL_TYPES_DEBUG} ${PSQL_COMMON_DEBUG} ${SSL_DEBUG} ${EAY_DEBUG} ${_f_LINUX_LIBS}"
				"SQLITE_LIBS=${SQLITE_DEBUG} ${_f_LINUX_LIBS}"
				"OPENSSL_LIBS=${SSL_DEBUG} ${EAY_DEBUG} ${_f_LINUX_LIBS}"
				"QMAKE_LIBS_PRIVATE+=${ZSTD_DEBUG}"
				-I ${CURRENT_INSTALLED_DIR}/include
				-L ${CURRENT_INSTALLED_DIR}${_f_BUILD_PATH_SUFFIX_${_t_BUILD_TYPE}}/lib
			)
		endif()
		
		unset(_t_BUILD_TYPE)
	endif()

	foreach(_t_BUILD_TYPE ${_f_BUILD_TYPES})
		set(_t_CURRENT_TRIPLET ${TARGET_TRIPLET}-${_f_BUILD_SHORT_NAME_${_t_BUILD_TYPE}})
		set(_t_CURRENT_BUILD_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${_t_CURRENT_TRIPLET}")
		
		# cleanup old files
		file(REMOVE_RECURSE "${_t_CURRENT_BUILD_DIRECTORY}")
		
		message(STATUS "Configuring ${_t_CURRENT_TRIPLET}...")
		file(MAKE_DIRECTORY ${_t_CURRENT_BUILD_DIRECTORY})
		
		vcpkg_execute_required_process(
			COMMAND "${_ext_SOURCE_PATH}/${_f_QT_CONFIGURE_ENTRYPOINT}" ${_f_QT_CONFIGURE_OPTIONS} ${_f_BUILD_OPTIONS_${_t_BUILD_TYPE}}
			WORKING_DIRECTORY ${_t_CURRENT_BUILD_DIRECTORY}
			LOGNAME config-${_t_CURRENT_TRIPLET}
		)
		
		message(STATUS "Configuring ${_t_CURRENT_TRIPLET} done!")
		
		unset(_t_CURRENT_TRIPLET)
		unset(_t_CURRENT_BUILD_DIRECTORY)
	endforeach()

endfunction()