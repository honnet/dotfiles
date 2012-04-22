" Open in full screen
function FullScreen()
  silent !wmctrl -r :ACTIVE: -b toggle,fullscreen
endfunction

" execute when start
autocmd GUIEnter * call FullScreen()


" disable visual warnings (too slow)
set novisualbell

" Change colorscheme from default to delek
colorscheme molokai

set guifont=Monospace\ 9

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar

