#!/bin/bash
# https://unix.stackexchange.com/questions/111499/how-do-i-know-the-name-of-a-tmux-session
session_name=$(tmux display-message -p "#S")
session_sha=$(echo $session_name | sha1sum )
session_colour=${session_sha::6}
# https://stackoverflow.com/questions/13280131/hexadecimal-to-decimal-in-shell-script
# https://stackoverflow.com/questions/428109/extract-substring-in-bash#428580
r=$((16#${session_colour::2}))
g=$((16#${session_colour:2:2}))
b=$((16#${session_colour:4:2}))

# https://ryanstutorials.net/bash-scripting-tutorial/bash-arithmetic.php
# https://stackoverflow.com/questions/12807669/how-to-convert-an-rgb-color-to-the-closest-matching-8-bit-color
let 'colour=(r*6/256)*36 + (g*6/256)*6 + (b*6/256)'

BASE_COLOUR=colour$colour
tmux set -w window-status-format "#[fg=black] #I: #{?window_activity_flag,##,}#{?window_bell_flag,\!,}#{?window_last_flag,~,}#W#{?window_zoomed_flag,[+],} "
tmux set -w window-status-current-format "#[bg=black,fg=$BASE_COLOUR] #I: #{?window_activity_flag,##,}#{?window_bell_flag,\!,}#{?window_last_flag,~,}#W#{?window_zoomed_flag,[+],} "
tmux set -w window-status-activity-style bg=$BASE_COLOUR,fg=black
tmux set -w pane-active-border-style fg=$BASE_COLOUR
