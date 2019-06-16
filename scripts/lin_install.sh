echo "Setting upx path"
cd UPX && export UPX_PATH="($PWD)" && cd ..
cd src
echo "Building GUI"
pyinstaller --upx-dir=$UPX_PATH gui.spec --log-level ERROR
7z a STPDF-gui.7z dist > /dev/null
rm -r dist build
echo "Building CLI"
pyinstaller --upx-dir=$UPX_PATH stpdf_cli.spec --log-level ERROR
7z a STPDF-cli.7z dist > /dev/null
rm -r dist build
mkdir dist
cp *.7z dist


