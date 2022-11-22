my dotfiles

in linux/macOS:
 - git clone
 - make symbolic ln to relevant files
e.g.:
```> ln -sv "~/.doifles/.vimrc" ~ ```
To link from .dotfiles to ~.vimrc

https://www.webpro.nl/articles/getting-started-with-dotfiles

in windows:

to do:
 - files with `~` are back ups of original files.
 - files with .swp appended are swap files which detect edits made.

we will direct these to go into a tmp directory.
 - swap files/temp files to dedicated directory; this will need to be system specific as dirs for windows systems will differ.
 - may also want to have a standard .gitconfig / .bash_profile
 - detect OS and send these elsewhere when needed 
