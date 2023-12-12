function RefreshGraph()
  !dot -Tsvg % > out.svg
  " !pgrep feh &>/dev/null && 'feh --auto-reload  --auto-zoom  --borderless ~/svg/out.png&'
  " !sleep 0.2 && i3-msg 'focus left'
endfunction
autocmd BufWritePre *.dot call RefreshGraph()
