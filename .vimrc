"""""""""""""""""""
" MARTIN'S .VIMRC "
"""""""""""""""""""

" Pathogen "
execute pathogen#infect()

" Taboo " enables taboo to remember tab names when you save the current session
set sessionoptions+=tabpages,globals


" General "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set autoread " automatically reload file
set formatoptions=c " auto-wrap comments and insert current comment leader!
set history=50 "
set hlsearch " highlight search matches
set lazyredraw " buffer screen updates instead of updating all the time, reduce scrolling/large file lag and useful when playing back macros
set noswapfile " Set dir for storing swap files
set nu " show line numbers
set ruler " show line and column number
set showcmd " show pending/partial cmds
set showmode " show current vim mode
set splitbelow " opens new hsplits below
set splitright " opens new vsplits right
set tags=./tags; " ascending search for tag file starting in current directory
set textwidth=80 " 80 chars per line, affects various options
set ttyfast " more speed! should be on by default :help ttyfast
set wildmode=longest,list,full " tab completion stages
set wildmenu " tab completion
" Sync unnamed register to the + register, which is the x window clipboard
set clipboard=unnamedplus   " Use on UNIX
"set clipboard=unnamed      " Use on MS Windows


" Tab & Indent "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set tabstop=4

set sw=4 expandtab
autocmd Filetype ruby setlocal sw=2 expandtab
autocmd Filetype vim  setlocal sw=2 expandtab
autocmd Filetype make setlocal ts=4
autocmd FileType gitcommit set tw=72

" GUI "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    if has('unix')
        set gfn=MonoSpace\ 9
    endif
    if has('win32')
        set gfn=Consolas
        set backspace=indent,eol,start " Backspace how people expect
    endif
    set guioptions=emgtLr
    set tabpagemax=100 " maximum number of tabs to open when using -p option
    set guitablabel=%t\ %r%m " show filename, if readonly , and if modified
    color desert
else
    color slate
endif


" tabs and trailing whitespace pet peeve indulgence "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
set listchars=tab:\|_,trail:?

function! ShowPeeve()
  set list
  set colorcolumn=+1
endfunction

function! HidePeeve()
  set nolist
  set colorcolumn=
endfunction

nnoremap <Leader>dd :call ShowPeeve()<CR>
nnoremap <Leader>df :call HidePeeve()<CR>

set list
autocmd Filetype c call ShowPeeve()
autocmd Filetype sh call ShowPeeve()

" next line is to test visibility settings, leave it be
		"	test  


" Auto Completion "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=longest,menuone

inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

" Auto Highlight "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction


" netrw settings "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" combination of code from these two sources:
"   1. http://ivanbrennan.nyc/blog/2014/01/16/rigging-vims-netrw/
"   2. http://modal.us/blog/2013/07/27/back-to-vim-with-nerdtree-nope-netrw/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle=3 " tree style
let g:netrw_banner=0 " no banner
let g:netrw_altv=1 " open files on right
let g:netrw_preview=1 " open previews vertically

function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
      call VexSize(25)
  endif
endfunction
map <silent> <Leader>~ :call ToggleVExplorer()<CR>

fun! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

" Delete buffers not shown in any window (including tabs) "
" http://stackoverflow.com/a/7321131                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
"    let tablist = []
"    for i in range(tabpagenr('$'))
"        call extend(tablist, tabpagebuflist(i + 1))
"    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
"    let nWipeouts = 0
"    for i in range(1, bufnr('$'))
"        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
"        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
"            silent exec 'bwipeout' i
"            let nWipeouts = nWipeouts + 1
"        endif
"    endfor
"    echomsg nWipeouts . ' buffer(s) wiped out'
"endfunction
"command! Wipeout :call DeleteInactiveBufs()

