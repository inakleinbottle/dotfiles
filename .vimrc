set nocompatible   " no vi compatibility, we're in vim

set encoding=utf-8

filetype plugin on   " load plugins for detected filetype
filetype indent on   " enable automatic indentation
syntax on            " enable syntax highlighting

set autoindent      " Indent with previous line
set tabstop =4      " Tab indentation as 4 spaces
set expandtab       " Expand tabs to spaces
set softtabstop =4  " Tab key indent by 4 spaces
set shiftwidth =4   " >> indents by 4 spaces
set shiftround      " >> indents to next multiple of 'shiftwidth'
set belloff=all     " Don't make a sound

set backspace =indent,eol,start     " Make backspace work as expected
set hidden                          " Switch buffers without having to save first
set laststatus =2                   " Always show status line
set display =lastline               " Show as much as possible of last line

set showmode                        " Show the current mode in the command line
set showcmd                         " Show already typed keys when more are expected

set incsearch                       " Highlight while searching with / or ?
"set hlsearch                        " Keep matches highlighted

set ttyfast                         " Faster redrawing
set lazyredraw                      " only redraw when necessary


"set cursorline                      " Highlight current line
set wrapscan                        " Wrap search at end of file
set report =0                       " Always report changed lines
set synmaxcol =200                  " only highlight first 200 columns


"set list                            " show non-printable characters
"if has('multi_byte') && &encoding ==# 'utf-8'
"    let &listchars ='tab:> ,extends:>,precedes:<,sbsp:.'
"else
"    let &listchars ='tab:> ,extends:>,precedes:<,sbsp:.'
"endif


set backup
set backupdir   =$HOME/.vim/files/backup
set backupext   =-vimbackup
set backupskip  = 
set directory   =$HOME/.vim/files/swap/
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo
set viminfo     ='100,n$HOME/.vim/files/info/viminfo




set clipboard=unnamedplus   " Use X clipboard
