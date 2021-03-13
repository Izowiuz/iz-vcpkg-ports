# iz-vcpkg-ports
Registry for custom vcpkg ports.

# qt5-custom
Stripped down configuration of Qt5 framework. Should be equal to Qt configured with options:

```
	-opensource
	-confirm-license
	-system-doubleconversion
	-system-zlib
	-system-pcre
	-system-sqlite
	-sql-psql
	-sql-sqlite
	-no-sql-odbc
	-no-gui
	-no-dbus
	-no-accessibility
	-no-opengl
	-no-libjpeg
	-no-libpng
	-no-harfbuzz
	-no-xcb
	-no-xcb-xlib
	-no-eglfs
	-no-xkbcommon
	-no-kms
	-no-feature-zstd
	-no-feature-xml
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
```
This port configures Qt from 'monolithic', all-in-one source archive. It is not recomended to use it alongside regular Qt5 ports as Bad Things Could Happen [tm].

Triplets tested to be working are *x64-windows-static* and *x64-linux*.
