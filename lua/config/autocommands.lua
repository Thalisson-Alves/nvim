vim.cmd([[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _remove_trailing_whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup end

  augroup _fix_docker_compose
    autocmd!
    autocmd BufRead docker-compose.yml set filetype=yaml.docker-compose
  augroup end
]])
