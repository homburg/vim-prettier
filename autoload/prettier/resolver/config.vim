" By default we will default to our internal
" configuration settings for prettier
function! prettier#resolver#config#resolve(config, hasSelection, start, end) abort
  " Allow params to be passed as json format
  " convert bellow usage of globals to a get function o the params defaulting to global
  " TODO: Use a list, filter() and join() to get a nicer list of args.
  let l:cmd = ' ' .
          \ s:Flag_range_delimiter(a:config, a:hasSelection, a:start, a:end) . ' ' .
          \ ' --stdin-filepath="'.simplify(expand('%:p')).'"' .
          \ ' --loglevel error '.
          \ ' --stdin '
  return l:cmd
endfunction

" Returns either '--range-start X --range-end Y' or an empty string.
function! s:Flag_range_delimiter(config, partialFormatEnabled, start, end) abort
  if (!a:partialFormatEnabled)
    return ''
  endif

  let l:range = prettier#utils#buffer#getCharRange(a:start, a:end)

  return '--range-start=' . l:range[0] . ' --range-end=' . l:range[1]
endfunction
