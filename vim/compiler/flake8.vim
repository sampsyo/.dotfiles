if exists('current_compiler')
    finish
endif
let current_compiler = 'flake8'

" Error format below stolen from Neomake source.
CompilerSet makeprg=flake8\ %
"CompilerSet  errorformat=%f:%l:\ could\ not\ compile
CompilerSet errorformat=%f:%l:%c:\ %t%n\ %m
"CompilerSet errorformat+=%f:%l:\ %t%n\ %m
"CompilerSet errorformat+=%-G%.%#
