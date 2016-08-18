#!/bin/sh

# copy the plugin to the user folder
cp -R "$HOME/.coremake/Library/Application Support/Developer/Shared/Xcode/Plug-ins/CoreMakeXcode.xcplugin" "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins"
sudo mkdir -p "/usr/local/coremake/bin/"
sudo cp -R "$HOME/.coremake/usr/local/coremake/bin/gas-preprocessor.pl" "/usr/local/coremake/bin/gas-preprocessor.pl"
sudo cp -R "$HOME/.coremake/usr/local/coremake/bin/yasm" "/usr/local/coremake/bin/yasm"
#sudo chown -R $(id -nu):$(id -ng) "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins/CoreMakeXcode.xcplugin"
#sudo chmod 777 -R "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins/CoreMakeXcode.xcplugin"

# read DVTPlugInCompatibilityUUID from the installed Xcode version
UUID=$(defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID)

# try to find this UUID in the plugin Info.plist
UUID_IN_PLUGIN=$(defaults read $HOME/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/CoreMakeXcode.xcplugin/Contents/Info DVTPlugInCompatibilityUUIDs | grep $UUID)

echo "Xcode UUID: $UUID"

# if the result is not empty, add the UUID
if [ -z "$UUID_IN_PLUGIN" ]; then
    echo "Plugin is not yet compatible with this version of Xcode..."
    defaults write $HOME/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/CoreMakeXcode.xcplugin/Contents/Info DVTPlugInCompatibilityUUIDs -array-add $UUID
    echo "Plugin is now compatible.\n"
else
    echo "Plugin was already compatible with this version"
      
fi
    
    