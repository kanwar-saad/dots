"execute pathogen#infect()
"let g:NERDTreeDirArrows=0
filetype plugin on
set tags=tags;
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
"Start C indent from open bracket
set cino=(0
" Set TList window width
let Tlist_WinWidth = 55

"Enable Gtags key mappings from gtags plugin
let Gtags_Auto_Map = 1

" For Align Plugin
set nocp
" Set omnicomplete function for gtags
autocmd FileType c set omnifunc=gtagsomnicomplete#Complete
" Remap ctrl+spcae for autocompletion menu
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-p>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

"let g:neocomplcache_enable_at_startup = 1

"Enable CScope PLugin (uncomment to turn off)
"let CScope_Auto_Map = 0

" Find definition of current symbol using Gtags
"map <C-?> <esc>:Gtags -r <CR>
"
" " Find references to current symbol using Gtags
"map <C-F> <esc>:Gtags <CR>
"
" " Go to previous file
"map <C-p> <esc>:bp<CR>
"
"


" transfer/read and write one block of text between vim sessions
" Usage:
" 'from' session:
" ma
" move to end-of-block
" xw
"
" 'to' session:
" move to where I want block inserted
" xr
"
if has("unix")
	nmap xr :r $HOME/.vimxfer<CR>
	nmap xw :'a,.w! $HOME/.vimxfer<CR>
	vmap xr c<Esc>:r $HOME/.vimxfer<CR>
	vmap xw :w! $HOME/.vimxfer<CR>
else
	nmap xr :r c:/.vimxfer<CR>
	nmap xw :'a,.w! c:/.vimxfer<CR>
	vmap xr c<Esc>:r c:/.vimxfer<CR>
	vmap xw :w! c:/.vimxfer<CR>
endif


" TRim trailing spaces from code

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>
ShowSpaces 1
" Set make command for the project
set makeprg=cd\ /workspace/git/ekanwli/spitfire;\ make\ SF-RP1-FUM\ O=/workspace/scratch/ekanwli/spitfire.out
nnoremap <F6> :make!<CR>

" Close QuickFix window if parent buffer is closed
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

let g:mos=10

function Test(...)

    echo "Test"
    let line=line('.')
    echo mos
    let g:mos=line
    echo "Test"
    "call setpos('.', old_pos)
endfunction

"" Taglist shortcuts
nnoremap <S->> :vertical resize +5<CR>
nnoremap <S-<> :vertical resize -5<CR>
nnoremap <S-+> :resize +5<CR>
nnoremap <S--> :resize -5<CR>

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" C Code alignment
vmap a =gv\tsp

" Generate Tags
nnoremap <S-F11> :! ~/tags.sh <CR>

function! Cppcheck_1()
  setlocal makeprg=cppcheck\ --enable=all\ %\ |\ grep\ \"^\[*$\"
  setlocal errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
  let curr_dir = expand('%:h')
  if curr_dir == ''
    let curr_dir = '.'
  endif
  echo curr_dir
  execute 'lcd ' . curr_dir
  execute 'make'
  execute 'lcd -'
  exe   ":botright cwindow"
  :copen
endfunction
