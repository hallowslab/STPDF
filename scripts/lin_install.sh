cd src
pyinstaller --upx-dir=$UPX_PATH gui.spec --log-level ERROR
7z a STPDF-gui.7z dist > /dev/null
rm -r dist build
pyinstaller --upx-dir=$UPX_PATH stpdf_cli.spec --log-level ERROR
7z a STPDF-cli.7z dist > /dev/null
rm -r dist build
mkdir dist
cp *.7z dist

