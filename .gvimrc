" Open in full screen
function FullScreen()
  silent !wmctrl -r :ACTIVE: -b toggle,maximized_horz
  silent !wmctrl -r :ACTIVE: -b toggle,maximized_vert
  silent !wmctrl -r :ACTIVE: -b toggle,fullscreen
endfunction

" execute when start
autocmd GUIEnter * call FullScreen()


" disable visual warnings (too slow)
set novisualbell

set guifont=Monospace\ 10

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

" remove scrollbars
set guioptions+=LlRrb
set guioptions-=LlRrb

" Allow copy/paste to/from clipboard with "cc/vv"
noremap cc "+y
noremap vv "+p

