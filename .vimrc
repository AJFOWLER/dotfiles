
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

:set noundofile

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Screen navigation and splits
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" use spacebar to fold
nnoremap <space> za
"Using simpylFold plugin -- preview docstring.
let g:SimpylFold_docstring_preview=1

" PEP 8 indentation
au BufNewFile, BufRead *.py
  \ set tabstop=4
  \ set softtabstop=4
  \ set softwidth=4
  \ set textwidth=79
  \ set expandtab
  \ set autoindent
  \ set fileformat=unix
"Other files can use 2tabs
au BufNewFile,BufRead *.js, *.html, *.css
  \ set tabstop=2
  \ set softtabstop=2
  \ set shiftwidth=2
"netrw config
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_banner = 0

"Vundle setup
set nocompatible
filetype off
" set the runtime path to include Vundle and init.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" add further plugins here...
Plugin 'tmhedberg/SimpylFold' " better folding
Plugin 'vim-scripts/indentpython.vim'
Plugin 'mattn/emmet-vim'
" All plugins must finish before this section:
call vundle#end()
filetype plugin indent on

" within vim now use :PluginInstall to install listed plugs!
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif