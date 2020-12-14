:" Fix incorrect, broken and missing filetypes.
augroup filetypedetect

  :" Ruby languages & DSLs
  au BufNewFile,BufRead *.racc  setf ruby
  au BufNewFile,BufRead *.rex   setf ruby
  au BufNewFile,BufRead *.ru    setf ruby

  :" Markdown with *.md files
  au BufNewFile,BufRead *.md    setf markdown

  :" Fix .ipp files ...
  au BufNewFile,BufRead *.ipp   setf cpp

augroup END

