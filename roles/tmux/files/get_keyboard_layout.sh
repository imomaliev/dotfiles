#!/bin/bash
# TODO: convert this to tpm plugin
defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -sq Colemak
layout=$?
if [[ layout -eq 0 ]]; then
    echo En
else
    echo Ru
fi
