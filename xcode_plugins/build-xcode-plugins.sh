#!/bin/sh

VERSION=1.3.0

curl -O http://www.tortall.net/projects/yasm/releases/yasm-$VERSION.tar.gz
tar -xvzf yasm-$VERSION.tar.gz
pushd yasm-$VERSION
./configure
make
popd

# make a directory location for yasm and gaspp to reside
mkdir -p base/usr/local/coremake/bin

#copy yasm to destination directory
cp yasm-$VERSION/yasm base/usr/local/coremake/bin/

#copy gas-preprocessor to destination directory
cp XcodePlugins/gas-preprocessor.pl base/usr/local/coremake/bin

#build the Xcode plugin
pushd XcodePlugins
xcodebuild -configuration "Release" build
popd

mkdir -p base/Developer/Library/Xcode/Plug-ins
cp -R XcodePlugins/build/Release/CoreMakeXcode.xcplugin base/Developer/Library/Xcode/Plug-ins

#make the package
/Applications/PackageMaker.app/Contents/MacOS/PackageMaker -v --doc "YasmPluginInstaller.pmdoc" -o XcodePlugins.pkg --target 10.5 -i com.CoreCodec.xcodeplugins;