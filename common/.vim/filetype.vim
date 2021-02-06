:" Fix incorrect, broken and missing filetypes.
augroup filetypedetect

  :" Ruby languages & DSLs
  au BufNewFile,BufRead *.racc      setf ruby
  au BufNewFile,BufRead *.rex       setf ruby
  au BufNewFile,BufRead *.ru        setf ruby
  au BufNewFile,BufRead Gemfile     setf ruby
  au BufNewFile,BufRead Rakefile    setf ruby
  au BufNewFile,BufRead Vagrantfile setf ruby

  :" Markdown with *.md files
  au BufNewFile,BufRead *.md    setf markdown

  :" Fix .ipp files ...
  au BufNewFile,BufRead *.ipp   setf cpp

  :" Typescript is javascript
  au BufNewFile,BufRead *.ts   setf javascript

augroup END

