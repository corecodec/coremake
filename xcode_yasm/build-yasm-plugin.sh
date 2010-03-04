#!/bin/sh

curl -O http://www.tortall.net/projects/yasm/releases/yasm-0.8.0.tar.gz
tar -xvjf yasm-0.8.0.tar.gz
pushd yasm-0.8.0
./configure
make
popd

# make a directory location for yasm to reside
mkdir -p base/usr/local/coremake/bin

#copy yasm to destination directory
cp yasm-0.8.0/yasm base/usr/local/coremake/bin/

#build the Xcode plugin
pushd YasmPlugin
xcodebuild -configuration "Release" build
popd

mkdir -p base/Developer/Library/Xcode/Plug-ins
cp -R YasmPlugin/build/Release/Yasm.xcplugin base/Developer/Library/Xcode/Plug-ins

#make the package
/Developer/usr/bin/packagemaker -v --doc "YasmPluginInstaller.pmdoc" -o YasmPlugin.pkg --target 10.5 -i com.CoreCodec.yasmplugin;