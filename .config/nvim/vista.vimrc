let g:vista_default_executive = 'coc'
let g:vista_sidebar_width =  40
let g:vista_fzf_preview = ['right:50%']

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" You can add the following line to your vimrc if you want to show the nearest function in your statusline automatically.
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
