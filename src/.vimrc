au VimLeave * mks! ~/.vim/Session.vim
silent :source ~/.vim/Session.vim "不直接source session.vim!否则有一个提示窗口

nmap rn :CocCommand document.renameCurrentWord<CR> 
"python自动utf-8

autocmd BufNewFile *.py call setline(1,"# -*- coding: utf-8 -*-")

autocmd BufWinEnter *.py set foldmethod=indent

set foldmethod=marker
"使vim支持鼠标（触摸屏）
set mouse=a
"禁用生成交换文件
set noswapfile
"禁用连续注释
"set paste
"禁用自动换行
set nowrap
"禁用VI兼容模式 
set nocompatible     
"Vim 的内部编码
set encoding=utf-8         
"Vim 在与屏幕/键盘交互时使用的编码(取决于实际的终端的设定)
set termencoding=utf-8
"Vim 当前编辑的文件在存储时的编码
set fileencoding=utf-8
"Vim 打开文件时的尝试使用的编码
set fileencodings=utf-8,gbk,default
"设置搜索高亮显示
set hlsearch
" 打开实时查找预览
set incsearch
"自动保存
set autowriteall
set updatetime=500
"弹出补全窗口的颜色
highlight Pmenu ctermbg=233 ctermfg=7
highlight PmenuSel ctermbg=233 ctermfg=15
"设置每层缩进空格数量
set sw=2
"设置tab按钮的缩进空格数量
set ts=2
"将tab转换为空格
set expandtab
"设置自动缩进
set autoindent
"显示行号
set number
"显示当前光标位置
set ruler
"显示整行下划线
set cursorline
"显示当前模式
set showmode
"设置leader键为“，”
let mapleader=","
"开启代码折叠
autocmd vimenter *.py set foldmethod=indent
"开启rainBow
let g:rainbow_active = 1
"配置插件列表
call plug#begin('~/.vim/plugged')
"cocvim 提供补全支持
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"RainBow
"Plug 'Valloric/YouCompleteMe'
Plug 'luochen1990/rainbow'
"nerdtree 提供树形目录支持
Plug 'scrooloose/nerdtree'
"light line 提供底部状态栏
Plug 'vim-airline/vim-airline'
"emmet HTML的插件（可能用不到
Plug 'mattn/emmet-vim'
"snippets 提供代码片段
Plug 'honza/vim-snippets'
"自动格式化
Plug 'Chiel92/vim-autoformat'
"代码检查
Plug 'Eric-Song-Nop/vim-glslx'
Plug 'w0rp/ale'
"自动括号闭合
Plug 'jiangmiao/auto-pairs'
"显示缩进线
Plug 'Yggdroot/indentLine'
"主题
"Plug 'morhetz/gruvbox'
"Plug 'sainnhe/everforest' 
Plug 'sainnhe/sonokai'
call plug#end()

autocmd VimEnter * :AirlineTheme sonokai
let g:gruvbox_contrast='soft'
let g:gruvbox_number_column='bg1'
let g:gruvbox_italic=1
let g:gruvbox_invert_selection=0
let g:gruvbox_invert_tabline= 0
let g:indentLine_setColors = 0

let g:sonokai_style = 'default'
let g:sonokai_diagnostic_line_highlight = '1'
let g:airline#extensions#tabline#formatter = 'default'

autocmd vimenter * colorscheme sonokai
autocmd vimenter * set background=dark

"-------- nerd tree --------
"设置Ctrl+n为树形目录打开
map <C-n> :NERDTreeToggle<CR>

"识别文件类型
autocmd BufNewFile,BufRead *.geometry,*.vertex,*.fragment set ft=glslx
autocmd BufNewFile,BufRead *.material set filetype=json
" coc

"set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

"indent line
let g:indentLine_char='┊'
let g:indentLine_color_term = 100
let g:indentLine_enabled = 1
