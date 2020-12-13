
:"
:" Set default options to make things useable.
:"

set autoindent
set backspace=2
set nobackup
set nocompatible
set expandtab
set helpheight=15
set hlsearch
set incsearch
set lines=44
set ruler
set shiftwidth=3
set smarttab
set splitright
set splitbelow
set tabstop=3
set nowrap
:" set ic
set noic

:" Just maximize the screen ... why is this impopssible to do cross platform.
set lines=999 columns=999

:" On GVIM, a little transparency, but not on VIM.
if has("gui_running")
   set transparency=10
endif

:" Old people ...

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h15
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

:" Makes weird popup dialog that complains too much ;-)
:" set verbose=1

source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/colors/darkblue.vim
behave mswin

syntax on

:" Fix .ipp files ...
au BufNewFile,BufRead *.ipp   setf cpp

:" Fix .md files ...
au BufNewFile,BufRead *.md   setf markdown

set diffexpr=MyDiff()
function MyDiff()
  let opt = ''
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  silent execute '!C:\Vim\vim61\diff -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out
endfunction

" Enable some perforce tool support ...
"runtime perforce/perforceutils.vim

" vim -b : edit binary using xxd-format!
" 	augroup Binary
" 	  au!
" 	  au BufReadPre  *.bin let &bin=1
" 	  au BufReadPost *.bin if &bin | %!xxd
" 	  au BufReadPost *.bin set ft=xxd | endif
" 	  au BufWritePre *.bin if &bin | %!xxd -r
" 	  au BufWritePre *.bin endif
" 	  au BufWritePost *.bin if &bin | %!xxd
" 	  au BufWritePost *.bin set nomod | endif
" 	augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Add support for sort command ... use like :'<,'>sort
"
" --- This came basically from :help eval-examples
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Function for use with Sort(), to compare two strings.
func! Strcmp(str1, str2)
  if (a:str1 < a:str2)
	return -1
  elseif (a:str1 > a:str2)
	return 1
  else
	return 0
  endif
endfunction

" Sort lines.  SortR() is called recursively.
func! SortR(start, end, cmp)
  if (a:start >= a:end)
	return
  endif
  let partition = a:start - 1
  let middle = partition
  let partStr = getline((a:start + a:end) / 2)
  let i = a:start
  while (i <= a:end)
	let str = getline(i)
	exec "let result = " . a:cmp . "(str, partStr)"
	if (result <= 0)
	    " Need to put it before the partition.  Swap lines i and partition.
	    let partition = partition + 1
	    if (result == 0)
		let middle = partition
	    endif
	    if (i != partition)
		let str2 = getline(partition)
		call setline(i, str2)
		call setline(partition, str)
	    endif
	endif
	let i = i + 1
  endwhile

  " Now we have a pointer to the "middle" element, as far as partitioning
  " goes, which could be anywhere before the partition.  Make sure it is at
  " the end of the partition.
  if (middle != partition)
   let str = getline(middle)
	let str2 = getline(partition)
	call setline(middle, str2)
	call setline(partition, str)
  endif
  call SortR(a:start, partition - 1, a:cmp)
  call SortR(partition + 1, a:end, a:cmp)
endfunc

" To Sort a range of lines, pass the range to Sort() along with the name of a
" function that will compare two lines.
func! Sort(cmp) range
  call SortR(a:firstline, a:lastline, a:cmp)
endfunc

" :Sort takes a range of lines and sorts them.
command! -nargs=0 -range Sort <line1>,<line2>call Sort("Strcmp")


"
" Removes trailing spaces on save ...
" http://www.bestofvim.com/tip/trailing-whitespace/
"
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()


