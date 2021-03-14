#!/bin/bash
set -euo pipefail

# https://unix.stackexchange.com/questions/111499/how-do-i-know-the-name-of-a-tmux-session
session_name=$(tmux display-message -p "#S")
session_sha=$(echo "${session_name}" | shasum )
session_colour=${session_sha::6}
# https://stackoverflow.com/questions/13280131/hexadecimal-to-decimal-in-shell-script
# https://stackoverflow.com/questions/428109/extract-substring-in-bash#428580
r=$((16#${session_colour::2}))
g=$((16#${session_colour:2:2}))
b=$((16#${session_colour:4:2}))

# https://ryanstutorials.net/bash-scripting-tutorial/bash-arithmetic.php
# https://stackoverflow.com/questions/12807669/how-to-convert-an-rgb-color-to-the-closest-matching-8-bit-color
((colour_id=(r*6/256)*36 + (g*6/256)*6 + (b*6/256)))

TMUX_SESSION_COLOUR=colour$colour_id
TMUX_SESSION_INVERTED_COLOUR=black
tmux set-environment TMUX_SESSION_COLOUR $TMUX_SESSION_COLOUR
tmux set-environment TMUX_SESSION_INVERTED_COLOUR $TMUX_SESSION_INVERTED_COLOUR
tmux set-option @prefix_highlight_fg "$TMUX_SESSION_COLOUR"
tmux set-option @prefix_highlight_bg "$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option status-left "#[fg=$TMUX_SESSION_COLOUR,bg=$TMUX_SESSION_INVERTED_COLOUR] #S #[default] "
tmux set-option status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,} #{prefix_highlight} %H:%M %d-%b-%y #[fg=$TMUX_SESSION_COLOUR,bg=$TMUX_SESSION_INVERTED_COLOUR] #{keyboard_layout} #[default]"
tmux set-option status-style "bg=$TMUX_SESSION_COLOUR,fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option window-status-format " #I:#W#{?window_flags,#{window_flags}, } "
tmux set-option window-status-style "bg=$TMUX_SESSION_COLOUR,fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option window-status-current-format " #I:#W#{?window_flags,#{window_flags}, } "
tmux set-option window-status-current-style "bg=$TMUX_SESSION_INVERTED_COLOUR,fg=$TMUX_SESSION_COLOUR"
tmux set-option window-status-activity-style "bg=$TMUX_SESSION_COLOUR,fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option pane-border-style "fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option pane-active-border-style "fg=$TMUX_SESSION_COLOUR"

# https://github.com/koalaman/shellcheck/wiki/SC1090
# shellcheck source=/dev/null
tmux run-shell -b "${TMUX_PLUGIN_MANAGER_PATH}/tmux-prefix-highlight/prefix_highlight.tmux"
tmux run-shell -b "${TMUX_PLUGIN_MANAGER_PATH}/tmux-keyboard-layout/keyboard_layout.tmux"
