set nocompatible              " be iMproved, required
filetype off                  " required

if has('nvim')
    set termguicolors
endif

let g:python_host_prog='/Users/RicardoGaviria/anaconda3/envs/py2/bin/python'

" Specify directory for plugins
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Instal solarized color scheme
Plug 'altercation/vim-colors-solarized'

" Asynchronous Lint Engine 
Plug 'w0rp/ale'

" Change conda environments in the editor
Plug 'cjrh/vim-conda'
" CondaChangeEnv<Enter> - to switch virtual env

" Sublime text like multiple selection
Plug 'terryma/vim-multiple-cursors'

" Java Autocompletion
Plug 'artur-shaik/vim-javacomplete2'

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

if has("gui_running")
    set background=light
    " Solarized options
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    colorscheme solarized
    echo "Gui Running"
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

" Java Autocompletion configuration
" Check out https://github.com/artur-shaik/vim-javacomplete2 for more
" information
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Enable smart (trying to guess import option) inserting class imports with F4, add:

nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)

imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

" To enable usual (will ask for import option) inserting class imports with F5, add:

nmap <F5> <Plug>(JavaComplete-Imports-Add)

imap <F5> <Plug>(JavaComplete-Imports-Add)

" To add all missing imports with F6:

nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)

imap <F6> <Plug>(JavaComplete-Imports-AddMissing)

" To remove all unused imports with F7:

nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

let g:JaveComplete_AutoStartServer = 0 " Disable automatic startup of server

autocmd Filetype gitcommit setlocal spell textwidth=72
