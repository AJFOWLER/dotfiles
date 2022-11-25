my dotfiles

in linux/macOS:
 - git clone
 - make symbolic ln to relevant files
e.g.:
```> ln -sv "~/.doifles/.vimrc" ~ ```
in windows;
```>  mklink link target ```
e.g.:
```>mklink  "C:\Users\Alex\.vimrc" "C:\Users\Alex\.dotfiles\.vimrc"```
To link from .dotfiles to ~.vimrc

https://www.webpro.nl/articles/getting-started-with-dotfiles

in windows:
```
> mkdir C:\Users\UN\vimfiles\tmp_swp
```
in mac/linux:
```
> mkdir ~/.vim/tmp
```
We can set colours with:
:colorscheme name
to see colour schemes:
:colorscheme [space] [cntrl+d]
in .vimrc:
colorscheme blue 
Vundle in unix:
>git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" add more plugins
call vundle#end()
filetype plugin indent on

```
Within vim :PluginInstall will install all relevant plugins

to do:
 - Get vundle working on windows
 -~~ files with `~` are back ups of original files.
 - ~~files with .swp appended are swap files which detect edits made.

we will direct these to go into a tmp directory.
 - swap files/temp files to dedicated directory; this will need to be system specific as dirs for windows systems will differ.
 - datetime stamped:

```au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'```
 - may also want to have a standard .gitconfig / .bash_profile
 - detect OS and send these elsewhere when needed 
