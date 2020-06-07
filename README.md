# Dotfiles

## macOS
Currently for macOS Catalina

### Setup

1. Run install script
   ```console
   ./install.sh
   ```
1. Remove .ansible folder
   ```console
   rm -r ~/.ansible
   ```
1. For now pynvim is not installed automatically because if wierd issue with ansible installing it inside its venv
   ```console
   cd ~/.local/share/nvim/python3
   source bin/activate
   pip install pynvim
   ```
#### Run playbook
```console
ansible-playbook -v -l localhost -i inventory --ask-become-pass site.yml
```

### Manual Setup
1. Keyboard
   ```
   Keyboard -> Keyboard -> Use F1, F2...
   Keyboard -> Keyboard -> Modifiers Keys -> Caps Lock Key -> No Action
   ```
1. Disable mouse pinter locate
   ```
   Accessibility -> Display -> Cursor -> Shake mouse pointer to locate
   ```
1. Trackpad
   ```
   Accessibility -> Pointer Control -> Trackpad Options -> Enable draggin -> three finger drag
   Trackpad -> More Gestures -> Swipe between full-screen apps -> Swipe left or right with four fingers
   Trackpad -> More Gestures -> Mission Control -> Swipe up with four fingers
   Trackpad -> More Gestures -> App Expose -> Swipe down with four fingers
   ```
1. Spelling
   ```
   Keyboard -> Text -> *Disable everything
   ```
1. Time
   ```
   Date & Time -> Clock -> Display the time with seconds
   Date & Time -> Clock -> Show date
   ```
1. Windows
   ```
   Dock -> Minimize windows using -> Scale Effect
   ```


## TODO
1. osx_defaults
1. fix pynvim problem
