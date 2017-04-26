set nocompatible              " be iMproved, required
filetype off                  " required

set termguicolors
" import custom vimrc file which is machine specific
let $CUSTOM_VIMRC=$HOME.'\custom.vimrc'
if filereadable($CUSTOM_VIMRC)
    source $CUSTOM_VIMRC
    echo "reading " $CUSTOM_VIMRC
else
    echo "WARNING: No "  $CUSTOM_VIMRC  " Found"
    echo "Must set the following variables in the file at least"
    echo "-----------------------------------------------------"
    echo "$PYTHON_PATH='C:\monty\win-31;C:\monty\win-32\Scripts;C:\monty\win-32\Libs\site-packages'"
    echo "$PATH=$PYTHON_PATH .';'. $PATH"
    echo "$VIM_DIR="~/vimfiles/plugged""
end
    

" Specify directory for plugins
call plug#begin($VIM_DIR)

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Instal solarized color scheme
Plug 'altercation/vim-colors-solarized'

" Asynchronous Lint Engine 
Plug 'w0rp/ale'

" Change conda environments in the editor
" Plug 'cjrh/vim-conda'
" CondaChangeEnv<Enter> - to switch virtual env

" Python autocompletion
Plug 'davidhalter/jedi-vim'

" Sublime text like multiple selection
Plug 'terryma/vim-multiple-cursors'

" Fuzzy finder CtrlP for fuzzy search 
Plug 'kien/ctrlp.vim'

" The NERD Tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" initialize plugin system
call plug#end()

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" Put your non-Plugin stuff after this line

" Set the statusline
" Source: http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2
set statusline=%f           " Path to the file
set statusline+=\ -\        " Separator
set statusline+=%l          " Current line
set statusline+=/           " Separator
set statusline+=%L          " Total lines
set statusline+=\ -\        " Separator
set statusline+=FileType:   " Label
set statusline+=%y          " Filetype of the file<Paste> syntax enable
set statusline+=\ -\        " Separator
set statusline+=%{ALEGetStatusLine()}

" ALE config
" @todo need to find a method of testing that linting is working correctly
" Write this in your vimrc file
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" You can disable this option too
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 1

" Font settings

if has("gui_running")
    set background=dark
    " Solarized options
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    colorscheme solarized
    " set font
    if has('gui_gtk2')
        set guifont=Inconsolata\ 12
    elseif has('gui_macvim')
        set guifont=Menlo\ Regular:h14
    elseif has('gui_win32')
        set guifont=Consolas:h13:cANSI:b
    end
else 
    colorscheme desert
endif

filetype plugin indent on    " required
" show existing tab with 4 spaces width
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" It tells Vim to look for a tags file in the directory of the current file, in the current directory and up and up until your $HOME (that's the meaning of the semicolon), stopping on the first hit.
set tags=./tags,tags;$HOME


