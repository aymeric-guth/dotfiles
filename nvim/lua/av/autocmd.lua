vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

vim.cmd([[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
    augroup END
]])

vim.cmd([[
    augroup roslaunch_ext
    autocmd!
    au BufRead,BufNewFile *.launch setfiletype roslaunch
    augroup END
]])
--
-- vim.cmd([[
-- 	augroup Binary
-- 	  au!
-- 	  au BufReadPre  *.mp3 let &bin=1
-- 	  au BufReadPost *.mp3 if &bin | %!xxd
-- 	  au BufReadPost *.mp3 set ft=xxd | endif
-- 	  au BufWritePre *.mp3 if &bin | %!xxd -r
-- 	  au BufWritePre *.mp3 endif
-- 	  au BufWritePost *.mp3 if &bin | %!xxd
-- 	  au BufWritePost *.mp3 set nomod | endif
-- 	augroup END
-- ]])
