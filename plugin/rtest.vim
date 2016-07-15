" Description: rtest.vim - Some basic functionality for navigating between spec & implementation in rspec
" Author:      Michael Thelander <mjthelander@gmail.com>
" License:     This file is placed in the public domain

if exists('g:loaded_rtest')
  finish
endif

function OpenTest()
  execute ':e ' . GetTestFile()
endfunction

function OpenTestHoriz()
  execute ':sp ' . GetTestFile()
endfunction

function OpenImplementation()
  execute ':e ' . GetImplementation()
endfunction

function OpenImplementationHoriz()
  execute ':sp ' . GetImplementation()
endfunction

function CurrentFilename()
  return expand('%:p')
endfunction

function RootDir()
  return Chomp(system("git rev-parse --show-toplevel"))
endfunction

function Chomp(str)
  return substitute(a:str, '\n\+$', '', '')
endfunction

function GetTestFile()
  let filename = CurrentFilename()
  if stridx(filename, '/spec/') < 0
    let l:testfile = substitute(filename, '/app/', '/spec/', '')
    let l:testfile = substitute(l:testfile, '/lib/', '/spec/lib/', '')
    let l:testfile = substitute(l:testfile, '.rb', '_spec.rb', '')
    return l:testfile
  endif
endfunction

function GetImplementation()
  let filename = CurrentFilename()
  if stridx(filename, '/spec/') >= 0
    if stridx(filename, '/lib/') >= 0
      let l:testfile = substitute(filename, '/spec/', '/', '')
    else
      let l:testfile = substitute(filename, '/spec/', '/app/', '')
    endif
    let l:testfile = substitute(l:testfile, '_spec\.', '\.', '')
    return l:testfile
  endif
endfunction

function _RunTest(filename)
  let root = RootDir()
  let command = "!(clear && cd " . root . " && bundle exec rspec " . a:filename . ")"
  execute command
endfunction

function RunTests()
  call _RunTest(CurrentFilename())
endfunction

function RunTest()
  call _RunTest(CurrentFilename() . ':' . line('.'))
endfunction

nnoremap ,gt :call OpenTest()<CR>
nnoremap ;gt :call OpenTestHoriz()<CR>

nnoremap ,gi :call OpenImplementation()<CR>
nnoremap ;gi :call OpenImplementationHoriz()<CR>

nnoremap ,T :call RunTests()<CR>
nnoremap ,t :call RunTest()<CR>

let g:loaded_rtest = 1
