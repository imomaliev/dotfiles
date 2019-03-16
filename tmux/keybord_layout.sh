#!/bin/bash
defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -sq Colemak
if [[ $? -eq 0 ]]; then
    echo En
else
    echo Ru
fi
