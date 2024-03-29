
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
" enable backups:
set backup
" enable undo files:
set undofile
set swapfile
" directory = swp files, backupdir = undo files // means write direct.
if has("win32") || has("win16") || has("win64")
	set directory=$HOME\vimfiles\tmp_swp\\
	set backupdir=$HOME\vimfiles\tmp_swp\\
	set undodir=$HOME\vimfiles\tmp_swp\\
	set rtp+=$HOME\vimfiles\bundle\Vundle.vim
	let g:wiki_root= $HOME . "\Documents\wiki"
else
	set directory=~/.vim/tmp//
	set backupdir=~/.vim/tmp//
	set undodir=~/.vim/tmp//
	set rtp+=~/.vim/bundle/Vundle.vim
	let g:wiki_root='~/wiki'
endif
" backup files datetimestamp:
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'
"
" Nuke these lines for now:
"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file (restore to previous version)
"  if has('persistent_undo')
"    set undofile	" keep an undo file (undo changes after closing)
"  endif
"endif

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
" colour-scheme: morning
colorscheme blue 
" Highlight current cursor position
set cursorline!
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
"yaml needs its own:
au BufNewFile,BufRead *.yml, *.yaml
  \ set tabstop=2
  \ set sts=2 
  \ set sw=2
  \ set expandtab
  \ set syntax on
  \ set ruler
  \ syntax on 
" make file:
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
"netrw config
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_banner = 0
" Custom commands for chunks/project management
" pdb import/set_trace
nnoremap ,p iimport pdb; pdb.set_trace()
" PROJECT MANAGEMENT CHUNKING
" ,t will create a new CHUNK on the line below
nnoremap ,c o- []
" When all subtasks are marked as done, then the chunk will be marked as done.
" ,d will make the current task done.
" nnoremap ,d :s/\[\]/\[x\]/ <CR><ESC>$
" ,t will create a task below current chunk
nnoremap ,t o  -{}
",d will mark as done
nnoremap ,d :s/{}/{x}/ <CR><ESC>$
" ,l will be used to date time activities when they are completed:
" this means that when we click ,l in our progress file, the date will be
" appended and new line enter
nnoremap ,l A � <C-R>=strftime("%c")<CR><ESC>o<ESC>
" numbers:
set number
" For now, bail on journal templating, try out vim.wiki
" JOURNAL TEMPLATING
function! Journal()
	let l:dt = strftime('%d-%b-%Y')	
	let l:day = strftime('%a')
	echo(l:day)
	" Format:
	" Date -- Day of the week
	" WP
	" Exercise
	" Wt
	" Reflection
	execute 'normal G'
	" move to the bottom of the page
	execute 'normal! o'.l:dt.' --'.l:day.'--'
	execute 'normal! o'.'Writing practice: {}'	
	execute 'normal! o'.'Exercise: '
	if l:day == 'Mon'
		execute 'normal! o'.'Weight:'
	endif
	execute 'normal! o'.'---Reflection---'
	execute 'normal! o'
endfunction

" MONTH FILE TEMPLATING
function! Month()
	execute 'normal! i ##'
	execute 'normal! o ------------ TO DO ----------'
	execute 'normal! 5o'
	execute 'normal! o ------------ JOURNAL----------'
endfunction

" TERMINAL IN VIM - SAVES NEEDING TMUX!
" Note you can create a terminal pane in vim :terminal
" vertical: :vertical terminal 
" to close: bd
" Use CNTRL-W to enter vim normal mode.
" yank current line to unnamed register, sendkeys to buffer2, @" sends it
" Note that terminals are of type R; :ls R
function! FindTerminal()
	" If name of terminal session was 'terminal':
	" let l:bn = bufwinnr('terminal')
 	let l:bn = uniq(map(filter(getwininfo(), 'v:val.terminal'), 'v:val.bufnr'))
	" Test this with: :silent let foo = FindTerminal()
	return l:bn[0] 
endfunction
" To move current line to terminal buffer::
"nnoremap ,sk :%y \| :call term_sendkeys(2, @")<CR>
" This works very well!
nnoremap ,sk :,y \| :call term_sendkeys(FindTerminal(), @")<CR>

" STATUS LINE
" Need to to have laststatus setup
set laststatus=2
" Start with empty status line
set statusline= 
" Statusline show filepath
set statusline+=%<%F
" Append [+] to the file if it has been changed:
set statusline+=%h%m%r
" Currently active register, quite helpful 
set statusline+=%1*[%rreg:%{v:register}]
" Buffernumber:
set statusline+=%2*[%rbuf:%n]
"
"These UserNumbers correspond to %N* for styling!
hi User1 ctermfg=yellow ctermbg=13
hi User2 ctermfg=darkgreen ctermbg=14 
"
" Now add git current branch
"
"Vundle setup
set nocompatible
filetype off
" set the runtime path to include Vundle and init.
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" add further plugins here...
Plugin 'tmhedberg/SimpylFold' " better folding
Plugin 'vim-scripts/indentpython.vim'
Plugin 'mattn/emmet-vim'
Plugin 'lervag/wiki.vim' " wiki.vim
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
