" Description: rtest.vim - Some basic functionality for navigating between spec & 
"	implementation in rspec
" Author:   	 Michael Thelander <mjthelander@gmail.com>
" License: 		 This file is placed in the public domain

if exists('loaded_rtest')
	finish
endif
let loaded_rtest = 1

function OpenTest (filename, before_cmd)
	let l:testfile = substitute(a:filename, 'app/', 'spec/', '')
	let l:testfile = substitute(l:testfile, '.rb', '_spec.rb', '')
	if stridx(testfile, 'lib/') >= 0
		let l:testfile = 'spec/' . l:testfile
	endif
	if !empty(a:before_cmd)
		exe a:before_cmd
	endif
	exe ':e ' . l:testfile
endfunction

function OpenImplementation (filename, before_cmd)
	if stridx(a:filename, 'lib/') >= 0
		let l:testfile = substitute(a:filename, 'spec/', '', '')
	else
	  let l:testfile = substitute(a:filename, 'spec/', 'app/', '')
	endif
	let l:testfile = substitute(l:testfile, '_spec.rb', '.rb', '')
	if !empty(a:before_cmd)
		exe a:before_cmd
	endif
	exe ':e ' . l:testfile
endfunction

function RunTests(filename)
	exe ':!bundle exec rspec ' . a:filename
endfunction

function RunTest(filename)
	exe ':!bundle exec rspec ' . a:filename . ' --line ' . line('.')
endfunction

nmap ,gt :call OpenTest(bufname('%'), '')<CR>
nmap ;gt :call OpenTest(bufname('%'), ':sp')<CR>

nmap ,gi :call OpenImplementation(bufname('%'), '')<CR>
nmap ;gi :call OpenImplementation(bufname('%'), ':sp')<CR>

nmap ,T :call RunTests(bufname('%'))<CR>
nmap ,t :call RunTest(bufname('%'))<CR>
