" Gather search hits, and display in a new scratch buffer.
function! Gather(pattern)
  if !empty(a:pattern)
    let save_cursor = getpos(".")
    let orig_ft = &ft
    " append search hits to results list
    let results = []
    execute "g/" . a:pattern . "/call add(results, getline('.'))"
    call setpos('.', save_cursor)
    if !empty(results)
      " put list in new scratch buffer
      new
      setlocal buftype=nofile bufhidden=hide noswapfile
      execute "setlocal filetype=".orig_ft
      call append(1, results)
      1d  " delete initial blank line
    endif
  endif
endfunction

" Delete the current buffer if it is a scratch buffer (any changes are lost).
function! CloseScratch()
  if &buftype == "nofile" && &bufhidden == "hide" && !&swapfile
    " this is a scratch buffer
    bdelete
    return 1
  endif
  return 0
endfunction

nnoremap <silent> <Leader>f :call Gather(input("Search for: "))<CR>
nnoremap <silent> <Leader>F :call Gather(@/)<CR>
"hiko: using <Esc> will cause the direction(arrow) keys in abnormal status ie. pring B in eridor
"nnoremap <silent> <Esc> :call CloseScratch()<CR>
nnoremap <silent> <Leader>fq :call CloseScratch()<CR>
