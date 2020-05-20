
let s:temp_file_path = $HOME . '/.vim/vim-temp-copy-paste.bin'

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    " return join(lines, "\n")
	return lines
endfunction

function Copy_visual()
	let lines = s:get_visual_selection()
	call writefile(lines, s:temp_file_path)
endfunction

function Paste_visual()
	let file_msg = readfile(s:temp_file_path)
	call append(line("."), file_msg)
endfunction

