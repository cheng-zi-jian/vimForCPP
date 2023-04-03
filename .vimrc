" init the plugins
" (<--- left pannel) wait for 'PlugInstall' command
" please quit vim after 'PlugInstall' command
" autocmd VimEnter * :PlugInstall

set number
set ruler
set showcmd
set notimeout

set mouse=a
set clipboard=unnamed
set cursorline

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set cindent
set smartindent

set showmatch
set matchtime=5


syntax on
" 文件修改之后自动载入
set autoread
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5
" 左下角不显示当前vim模式
set noshowmode

"""""""""""""""""""""""""" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
"set foldmethod=indent
"set foldlevel=99
" 代码折叠自定义快捷键 zz
"let g:FoldMethod = 0
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" ==== plugin manager ====
call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'
  Plug 'preservim/nerdtree'
  Plug 'luochen1990/rainbow'
  Plug 'mhinz/vim-startify'
  Plug 'preservim/nerdcommenter'
  Plug 'Yggdroot/LeaderF'
 " Plug 'Valloric/YouCompleteMe'
  Plug 'bling/vim-airline'
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'w0ng/vim-hybrid'
  Plug 'majutsushi/tagbar'
  "Plug 'scrooloose/nerdtree-project-plugin'

  " lsp
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" ==== preservim/nerdcommenter ====
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDToogleCheckAllLines = 1

" ==== preservim/nerdtree ====
nnoremap <LEADER>e :NERDTreeToggle<CR>
" 褰揘ERDTree涓哄墿涓嬬殑鍞?涓€绐楀彛鏃惰嚜鍔ㄥ叧闂?
autocmd vimenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q |endif

" ==== itchyny/lightline.vim ====
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
" -- INSERT -- is unnecessary anymore because the mode infomation is displayed
"  in the statusline.
set noshowmode

" ==== luochen1990/rainbow ====
let g:rainbow_active = 1


inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
 
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " Update signature help on jump placeholder
augroup end


" GoTo code navigation.

function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('.vscode'))
    execute 'silent !mkdir .vscode'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()

" ==== puremourning/vimspector ====
let g:vimspector_enable_mappings = 'HUMAN'

function! s:generate_vimspector_conf()
  if empty(glob( '.vimspector.json' ))
    if &filetype == 'c' || 'cpp' 
      !cp ~/.config/nvim/vimspector_conf/c.json ./.vimspector.json
    elseif &filetype == 'python'
      !cp ~/.config/nvim/vimspector_conf/python.json ./.vimspector.json
    endif
  endif
  e .vimspector.json
endfunction

""""""""""""""""""""""""""""""
"Leaderf settings
""""""""""""""""""""""""""""""
let mapleader = "'"
"文件搜索
nnoremap <silent> <Leader>f :Leaderf file<CR>
"历史打开过的文件
nnoremap <silent> <Leader>m :Leaderf mru<CR>
"Buffer
nnoremap <silent> <Leader>b :Leaderf buffer<CR>
"函数搜索（仅当前文件里）
nnoremap <silent> <Leader>F :Leaderf function<CR>
"模糊搜索，很强大的功能，迅速秒搜
nnoremap <silent> <Leader>rg :Leaderf rg<CR>


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme = 'desertink'  " 主题
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
       \ '0': '0 ',
       \ '1': '1 ',
       \ '2': '2 ',
       \ '3': '3 ',
       \ '4': '4 ',
       \ '5': '5 ',
       \ '6': '6 ',
       \ '7': '7 ',
       \ '8': '8 ',
       \ '9': '9 '
       \}
" 设置切换tab的快捷键 <\> + <i> 切换到第i个 tab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" 设置切换tab的快捷键 <\> + <-> 切换到前一个 tab
nmap <leader>- <Plug>AirlineSelectPrevTab
" 设置切换tab的快捷键 <\> + <+> 切换到后一个 tab
nmap <leader>+ <Plug>AirlineSelectNextTab
" 设置切换tab的快捷键 <\> + <q> 退出当前的 tab
nmap <leader>q :bp<cr>:bd #<cr>

nmap <leader>n :tabnew<cr>
nmap <leader>a :tabnext<cr>
nmap <leader>d :tabprevious<cr>
nmap <leader>c :tabclose<cr>


"====hybrid=====
set background=dark
colorscheme hybrid


" C and C++ compiler:
autocmd FileType c nnoremap <buffer> <C-i> :w <RETURN> :!gcc % -o test -g && ./test <RETURN>
autocmd FileType cpp nnoremap <buffer> <C-i> :w <RETURN> :!g++ % -o test -g && ./test <RETURN>

" Python runner:
autocmd FileType python nnoremap <buffer> <C-i> :w <RETURN> :!python % <RETURN>

filetype plugin on
set completeopt=longest,menu

filetype plugin on
set completeopt=longest,menu

""" 其他
" 调整窗口移动
nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l
" 快速保存
inoremap jk <esc>:w<cr>
" 快速缩进
vnoremap < <gv
vnoremap > >gv

