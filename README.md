# Dotfiles

## macOS
Currently for macOS Catalina

### Pre install

1. Run install script
   ```console
   ./install.sh
   ```

### Run ansible playbook

1. Ensure inventory
1. ```console
   echo 'localhost ansible_connection=local' > inventory
   ```
1. Run playbook
   ```console
   ansible-playbook -v -i inventory site.yml
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

### Setup
1. Keyboard
   ```
   Keyboard -> Keyboard -> Use F1, F2...
   Keyboard -> Keyboard -> Modifiers Keys -> Caps Lock Key -> No Action
   Keyboard -> Shortcuts -> Input sources -> Select the previous input source -> CMD + Space
   Keyboard -> Shortcuts -> Input sources -> Select the next input source -> CMD + ALT + Space
   Keyboard -> Shortcuts -> Spotlight -> Show spotlight search -> CTRL + Space
   Keyboard -> Shortcuts -> Spotlight -> Show Finder search window -> CTRL + ALT + Space
   ```
1. Disable mouse pinter locate
   ```
   Accessibility -> Display -> Cursor -> Shake mouse pointer to locate
   ```
1. Trackpaq
   ```
   Accessibility -> Pointer Control -> Trackpad Options -> Enable draggin -> three finger drag
   Trackpad -> More Gestures -> Swipe between full-screen apps -> Swipe left or right with four fingers
   Trackpad -> More Gestures -> Mission Control -> Swipe up with four fingers
   Trackpad -> More Gestures -> App Expose -> Swipe down with four fingers
   ```


## TODO
1. osx_defaults
1. fix pynvim problem
