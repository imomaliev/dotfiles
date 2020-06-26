iabbrev <buffer> pdb breakpoint()

if exists('$VIRTUAL_ENV')
  set path+=$VIRTUAL_ENV/**
endif

let b:undo_ftplugin .= "| iunabbrev <buffer> pdb"
