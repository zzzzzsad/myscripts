" to use vim-plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'universal-ctags/ctags'
" Plug 'Valloric/YouCompleteMe'
Plug 'preservim/nerdtree'
call plug#end()

" set tags=./.tags;,.tags
" let g:gutentags_ctags_tagfile = '.tags'
" " 同时开启ctags和gtags
" let g:gutentags_modules = []
" if executable('ctags')
" 	let g:gutentags_modules += ['ctags']
" endif
" if executable('gtags-cscope') && executable('gtags') 
" 	let g:gutentags_modules += ['gtags_cscope']
" endif
" 
" let s:vim_tags = expand('~/.cache/tags')
" let s:gutentags_cache_dir = s:vim_tags
" let g:gutentags_project_root = ['.root', '.svn', '.git','.project']
" 
" let g:gutentags_ctags_extra_args = ['--field=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args = ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args = ['--c-kinds=+px']
" 
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" let g:gutentags_auto_add_gtags_cscope = 1
" " change focus to quickfix window after search
" let g:gutentags_plus_switch = 1
" 
" set cscopequickfix=s-,g-,c-,d-,i-,t-,e-
" " cscope当前窗口直接跳转快捷键
" nnoremap <Leader>fs :cs find s <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>fg :cs find g <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>fd :cs find d <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>fc :cs find c <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>ft :cs find t <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>fe :cs find e <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>ff :cs find f <C-R>=expand("<cword>")<cr><cr>
" nnoremap <Leader>fi :cs find i <C-R>=expand("<cword>")<cr><cr>
" 
" if !isdirectory(s:vim_tags)
" 	silent! call mkdir(s:vim_tags, 'p')
" endif

" " YCM 的相关设置
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_server_log_level = 'info'
" let g:ycm_min_num_identifier_candidate_chars = 2
" let g:ycm_collect_idertifiers_from_comments_and_strings = 1
" let g:ycm_complete_in_strings = 1
" " let g:ycm_key_invoke_completion = '<c-z>' " c-z 触发补全，我不喜欢这个
" set completeopt=menu,menuone
" let g:ycm_key_list_stop_completion=['<c-y>', '<CR>']
" 
" 
" let g:ycm_semantic_triggers = {
" 		\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
" 		\ 'cs,lua,javascript':['re!\w{2}'],
" 		\ }
" 
" let g:ycm_filetype_whitelist = {
" 						\ "c":1,
" 						\ "cpp":1,
" 						\ "cc":1,
" 						\ "h":1,
" 						\ "hpp":1,
" 						\ "python":1,
" 						\ "py":1,
" 						\ }
" " YCM extra_config的设置
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_global_ycm_extra_conf = '~/.vim/.my_global_extra_conf.py'

" NERDTree 的设置
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" 全局复制粘贴脚本
source ~/.vim_global_copy_paste.vim
vnoremap C :call Copy_visual()<CR>
nnoremap V :call Paste_visual()<CR>

set t_Co=256
colorscheme desert
set hlsearch

highlight PMenu ctermfg=0  ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black
highlight Search ctermfg=238 ctermbg=178

set so=5
set fdm=marker
set nowrap

nnoremap x "_x
vnoremap x "_x
nnoremap J 15j
vnoremap J 15j
nnoremap K 15k
vnoremap K 15k
nnoremap H 80h
vnoremap H 80h
nnoremap L 80l
vnoremap L 80l
nnoremap go <C-o>
vnoremap go <C-o>
nnoremap gi <C-i>
vnoremap gi <C-i>
nnoremap g] <C-]>
vnoremap g] <C-]>
imap jj <Esc>


set nu
nnoremap <space> *N
set tabstop=4
set shiftwidth=4
set nocompatible
set backspace=indent,eol,start
