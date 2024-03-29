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

#### Run playbook

Using implicit `localhost`

```console
ansible-playbook -v --ask-become-pass site.yml
```

#### Run one role

https://stackoverflow.com/questions/38350674/ansible-can-i-execute-role-from-command-line

```console
ansible localhost -m include_role -a name="{name}"
```

#### Create new role
```console
ansible-galaxy init --role-skeleton=roles/skel roles/new_role
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
1. Dock
   ```
   Dock -> Minimize windows using -> Scale Effect
   Dock -> Position on screen -> Left
   Dock -> Automatically hide and show Dock
   ```

## TODO

1. osx_defaults
