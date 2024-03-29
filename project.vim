" This is a scripts testing file
" First, test out inserting a project header:
" This is the pattern to call a custom command:
command TC :call TestCommand()
" Then :so project.vim; and call :TC

function! TestCommand()
	echo "Hello"
endfunction
" Layout: PROJECTS have many CHUNKS, each CHUNK is made up of TASKS
"
" ,t will create a new CHUNK on the line below
nnoremap ,c o- []
" When all subtasks are marked as done, then the chunk will be marked as done.
" ,d will make the current task done.
" nnoremap ,d :s/\[\]/\[x\]/ <CR><ESC>$
" ,t will create a task below current chunk
nnoremap ,t o  -{}
",d will mark as done
nnoremap ,d :s/{}/{x}/ <CR><ESC>$
" for our mapping of activities; first remap to add date:
" this means that when we click ,l in our progress file, the date will be
" appended and new line enter
nnoremap ,l A � <C-R>=strftime("%c")<CR><ESC>o
"|  | 07/02/2023 13:09:35  | 07/02/2023 13:10:20 | 07/02/2023 13:10:27 |
"07/02/2023 13:10:45 | 07/02/2023 13:12:27 | 07/02/2023 13:12:50
" | 07/02/2023 13:10:56 | 07/02/2023 13:12:04 � 07/02/2023 13:13:25
"
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

function! CleanUp()
	"This function cleans up the todo list into the done-list
	" Yank to Z register
	" Small z = last match; capital Z = all matches
	" First clear the z reg
	call setreg('z',[])
	g/{x}/y Z
	" We can then use "zp to paste items!
	" execute 'normal! "zp write newfile.txt'
	let l.cliptext = getreg('z')
	" Now get rid of leading whitespace

endfunction

"
" CreateProject command
command -nargs=1 CreateProject :call CreateProject(<f-args>)

function! CreateProject(projectname = "NewProject")
	execute "normal i". a:projectname."_PR"
endfunction

function! UpdateProject()
	"Identify all {} between chunks and if they are completed; then make
	"the chunk complete
	" Put cursor to top of document
	execute 'normal! gg' 
	let l:chunks = search("\[\]")	
	echo(l:chunks)
	"Identify all [] between _PR and if they are completed, then make the
	"project complete
	

	" ASCII style 'progress bar' for projects
endfunction
" Testing here 
