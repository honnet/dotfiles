" Set syntax on
syn on

" Set command history length
set history=10000

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

" turn off expandtab in makefiles
autocmd FileType make setlocal noexpandtab

" Higlhight search
set hls

" Wrap text instead of being on one line
set lbr

" Automatically wrap left and right
set whichwrap=<,>,[,]

" Turn beep off
set noerrorbells
"set visualbell

" Disable auto-comment for all files:
au FileType * setl fo=cql

" Activate mouse:
set mouse=a

" Activate variable/function declaration research
set tags=./tags

" Do world statistics on file
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

" Display pde files (processing) like java files:
au! BufRead,BufNewFile *.pde set filetype=java

" Display ino files (arduino) like c files:
au! BufRead,BufNewFile *.ino set filetype=c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell check http://vimcasts.org/episodes/spell-checking/

"toggle spell checking on and off
nmap zs :set spell!<CR>

"next & prev error:
map zn ]s
map zp [s

"cursor on misspelled word => show suggestions
map ZZ z=

"cursor on misspelled word => correct with 1st suggestion
map zz 1z=

" Set region to french and us english
"set spelllang=fr,en_us

" automatic spell check for latex files
augroup filetypedetect
  au BufNewFile,BufRead *.tex setlocal spell spelllang=fr,en_us
augroup END

" suggestions number (obtained with 'z=')
set spellsuggest=6

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline,bold cterm=underline,bold
highlight clear SpellCap
highlight SpellCap term=underline,bold cterm=underline,bold
highlight clear SpellRare
highlight SpellRare term=underline,bold cterm=underline,bold
highlight clear SpellLocal
highlight SpellLocal term=underline,bold cterm=underline,bold

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Automatically remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

