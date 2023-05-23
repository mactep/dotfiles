for s:char in [ '_', '<bar>', '/', '<bslash>', ]
  execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
  execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
  execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
  execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

function! Ticks(inner)
    normal! gv
    call searchpos('`', 'bW')
    if a:inner | exe "normal! 1\<space>" | endif
    normal! o
    call searchpos('`', 'W')
    if a:inner | exe "normal! \<bs>" | endif
endfunction

vnoremap <silent> a` :<c-u>call Ticks(0)<cr>
vnoremap <silent> i` :<c-u>call Ticks(1)<cr>

onoremap <silent> a` :<c-u>normal va`<cr>
onoremap <silent> i` :<c-u>normal vi`<cr>
