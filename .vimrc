set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'davidhalter/jedi-vim'

call vundle#end()

filetype plugin indent on
filetype indent on      " load filetype-specific indentation

syntax enable           " enable syntax processing

colorscheme elflord     " colorscheme

"""""""""""""""""""""""""""""""""""""""
" => Interface
"""""""""""""""""""""""""""""""""""""""

set cursorline          " enable hightlighted current line
set number              " enable line numbers

set wildmenu
set showmatch

"""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""

set incsearch           " set incremental searchin
set hlsearch            " highight search cases

" pressing '\<space>' will unhighlight selection
nnoremap <leader><space> :nohlsearch<CR> 

" map * and # to search for words
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
 
"""""""""""""""""""""""""""""""""""""""
" => Movement
"""""""""""""""""""""""""""""""""""""""

nnoremap j gj         
nnoremap k gk

"""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""

set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""

set tabstop=4           " number of spaces a tab counts for
set softtabstop=4       " number of spaces removed when backspace pressed
set shiftwidth=4        " move existing tabs
set expandtab           " modify existing tabs
set smarttab            " smart tab

set ai                  " auto indent
set si                  " smart indent
set wrap                " wrap lines

"""""""""""""""""""""""""""""""""""""""
" Helper functions
"""""""""""""""""""""""""""""""""""""""

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/' . l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/' . l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
