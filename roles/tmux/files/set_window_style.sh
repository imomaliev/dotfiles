#!/bin/bash
set -euo pipefail

tmux set-option window-status-format " #I:#W#{?window_flags,#{window_flags}, } "
tmux set-option window-status-style "bg=$TMUX_SESSION_COLOUR,fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option window-status-current-format " #I:#W#{?window_flags,#{window_flags}, } "
tmux set-option window-status-current-style "bg=$TMUX_SESSION_INVERTED_COLOUR,fg=$TMUX_SESSION_COLOUR"
tmux set-option window-status-activity-style "bg=$TMUX_SESSION_COLOUR,fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option pane-border-style "fg=$TMUX_SESSION_INVERTED_COLOUR"
tmux set-option pane-active-border-style "fg=$TMUX_SESSION_COLOUR"
