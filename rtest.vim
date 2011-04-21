" Description: rtest.vim - Add some functionality for dealing with tests in rails
" Author:   	 Michael Thelander <mjthelander@gmail.com>
" License: 		 This file is placed in the public domain

if exists("loaded_rtest")
	finish
endif
let loaded_rtest = 1

function OpenTest (filename, before_cmd)
	let testfile = a:filename . '_TEST'
	echo stridx(testfile, "_")
	if !empty(a:before_cmd)
		"exe a:before_cmd
	endif
	"exe ":e " . testfile . "_test.txt"
endfunction

function OpenImplementation (filename, before_cmd)
	let testfile = a:filename . '__ASD'
	if !empty(a:before_cmd)
		exe a:before_cmd
	endif
	exe ":e " . testfile . "_test.txt"
endfunction

nmap ,gt :call OpenTest(bufname('%'), '')<CR>
nmap ;gt :call OpenTest(bufname('%'), ':sp')<CR>

nmap ,gi :call OpenImplementation(bufname('%'), '')<CR>
nmap ;gi :call OpenImplementation(bufname('%'), ':sp')<CR>
