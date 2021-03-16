#!/usr/bin/env bash
set -euo pipefail

TMUX_PEACOCK_SESSION_INVERTED_COLOUR=black
tmux set-option @prefix_highlight_fg "$TMUX_PEACOCK_SESSION_COLOUR"
tmux set-option @prefix_highlight_bg "$TMUX_PEACOCK_SESSION_INVERTED_COLOUR"
tmux set-option status-left "#[fg=$TMUX_PEACOCK_SESSION_COLOUR,bg=$TMUX_PEACOCK_SESSION_INVERTED_COLOUR] #S #[default] "
tmux set-option status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,} #{prefix_highlight} %H:%M %d-%b-%y #[fg=$TMUX_PEACOCK_SESSION_COLOUR,bg=$TMUX_PEACOCK_SESSION_INVERTED_COLOUR] #{keyboard_layout} #[default]"
tmux set-option status-style "bg=$TMUX_PEACOCK_SESSION_COLOUR,fg=$TMUX_PEACOCK_SESSION_INVERTED_COLOUR"

# https://github.com/koalaman/shellcheck/wiki/SC1090
# shellcheck source=/dev/null
tmux run-shell -b "${TMUX_PLUGIN_MANAGER_PATH}/tmux-prefix-highlight/prefix_highlight.tmux"
tmux run-shell -b "${TMUX_PLUGIN_MANAGER_PATH}/tmux-keyboard-layout/keyboard_layout.tmux"
