"Set syntax on
syn on

" Highly recommended to set tab keys to 4 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" Indent automatically depending on filetype (use ":set noai" otherwise)
filetype indent on
set autoindent
set pastetoggle=<F2>

" display line numbers
:set number

" To turn off expandtab in makefiles
 autocmd FileType make setlocal noexpandtab

" Higlhight search
set hls

" Wrap text instead of being on one line
set lbr

set whichwrap=<,>,[,]

" Change colorscheme to molokai :(check ~/.vim/colors/molokai.vim)
"set t_Co=256
"colorscheme molokai

"turn beep off
set noerrorbells
set visualbell

"To disable auto-comment for all files:
au FileType * setl fo=cql

"activate mouse:
set mouse=a

"activate variable/function declaration research
set tags=./tags,~/TPfreeRTOS/tags,~/TPfreeRTOS/Source/tags,~/TPfreeRTOS/STM32/tags,

"change the shape of the cursor
if has("autocmd")
  au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
  au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif


function! WordFrequency() range
  let all = split(join(getline(a:firstline, a:lastline)), '\A\+')
  let frequencies = {}
  for word in all
    let frequencies[word] = get(frequencies, word, 0) + 1
  endfor
  new
  setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20
  for [key,value] in items(frequencies)
    call append('$', key."\t".value)
  endfor
  sort i
endfunction
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()

"display pde files (processing) like java files:
au! BufRead,BufNewFile *.pde set filetype=java

"display ino files (arduino) like c files:
au! BufRead,BufNewFile *.ino set filetype=c