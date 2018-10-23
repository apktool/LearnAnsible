"https://github.com/yangyangwithgnu/use_vim_as_ide
"ctags＋taglist 需要单独安装
"ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++

if has("syntax")
  syntax on
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
" vimrc文件修改之后自动加载。
"autocmd! bufwritepost .vimrc source %
"set modifiable

"{{ 设置airline
    set laststatus=2
    let g:airline_theme = "bubblegum"
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show=1
"}}

"{{ YouCompleteMe配置
    let g:ycm_seed_identifiers_with_syntax=1                                " 语法关键字补全
    let g:ycm_min_num_of_chars_for_completion=2                             " 从第2个键入字符就开始罗列匹配项
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf=0                                          " 打开vim时不再询问是否加载ycm_extra_conf.py配置
    let g:ycm_collect_identifiers_from_tags_files = 1                       " 使开启 YCM 标签引擎
    let g:ycm_error_symbol = '>>'
    let g:ycm_warning_symbol = '>*'
    " let g:ycm_path_to_python_interpreter= 'python3'
    let g:ycm_python_binary_path = 'python3'
    "let g:ycm_path_to_python_interpreter = 'python3'
    let g:ycm_key_list_select_completion = ['<TAB>', '<DOWN>']
    let g:ycm_key_list_previous_completion = ['<S-TAB>', '<UP>']
    let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
    set completeopt=longest,menu                                            " 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
    let mapleader = ","                                                     " 让leader映射为逗号','
    nnoremap <leader>jk :YcmCompleter GoToDeclaration<CR>                   " 按,jk 会跳转到声明
    nnoremap <leader>jj :YcmCompleter GoToDefinition<CR>                    " 按,jj 会跳转到定义
    nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>     " 按,jd 会跳转到定义声明
"}}

"{{ Vundle
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'scrooloose/nerdtree'
    Plugin 'majutsushi/tagbar'
    Plugin 'nvie/vim-flake8'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'dracula/vim'
    Plugin 'Chiel92/vim-autoformat'
    Plugin 'vim-scripts/indentpython.vim'
    Plugin 'jiangmiao/auto-pairs'
    call vundle#end()
    filetype plugin indent on
"}}

"{{
    autocmd InsertEnter * :set norelativenumber number           " 插入模式下用绝对行号
    autocmd InsertLeave * :set relativenumber                    " 普通模式下用相对行号
    nnoremap <F2> :g/^\s*$/d<CR>                                 " <F2> 去空行
    map <F3> :%s/\s\+$//<CR>                                     " <F3> 删除多余空格
    nnoremap <F4> :call NumberToggle()<cr>                       " <F4> 相对和绝对行号切换
    function! NumberToggle()
        if(&relativenumber == 1)
            set norelativenumber number
        else
            set relativenumber
        endif
    endfunc

    autocmd FileType python map <buffer> <F5> :call Flake8()<CR>
"}}

"{{
    nmap <F8> :NERDTreeToggle<CR>                        " 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
    let NERDTreeWinSize=32                               " 设置NERDTree子窗口宽度
    let NERDTreeWinPos="right"                           " 设置NERDTree子窗口位置
    let NERDTreeShowHidden=1                             " 显示隐藏文件
    let NERDTreeMinimalUI=1                              " NERDTree 子窗口中不显示冗余帮助信息
    let NERDTreeAutoDeleteBuffer=1                       " 删除文件时自动删除文件对应 buffer
    let tagbar_left=1                                    " 设置 tagbar 子窗口的位置出现在主编辑区的左边
    nmap <F7> :TagbarToggle<CR>                          " 设置显示／隐藏标签列表子窗口的快捷键。
    let tagbar_width=32                                  " 设置标签子窗口的宽度
    let g:tagbar_compact=1                               " tagbar 子窗口中不显示冗余帮助信息
    " 设置 ctags 对哪些代码标识符生成标签
    let g:tagbar_type_cpp = {
        \ 'kinds' : [
             \ 'c:classes:0:1',
             \ 'd:macros:0:1',
             \ 'e:enumerators:0:0',
             \ 'f:functions:0:1',
             \ 'g:enumeration:0:1',
             \ 'l:local:0:1',
             \ 'm:members:0:1',
             \ 'n:namespaces:0:1',
             \ 'p:functions_prototypes:0:1',
             \ 's:structs:0:1',
             \ 't:typedefs:0:1',
             \ 'u:unions:0:1',
             \ 'v:global:0:1',
             \ 'x:external:0:1'
         \ ],
         \ 'sro'        : '::',
         \ 'kind2scope' : {
             \ 'g' : 'enum',
             \ 'n' : 'namespace',
             \ 'c' : 'class',
             \ 's' : 'struct',
             \ 'u' : 'union'
         \ },
         \ 'scope2kind' : {
             \ 'enum'      : 'g',
             \ 'namespace' : 'n',
             \ 'class'     : 'c',
             \ 'struct'    : 's',
             \ 'union'     : 'u'
         \ }
    \ }
"}}

"{{ 加载cscope
    if has("cscope")
        set csprg=/usr/local/bin/cscope
        set csto=0
        set cst
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
    endif
"}}

"{{ vim-autoformat       " 需要单独安装额外包
    nnoremap <leader>gg=G :Autoformat<CR>                            " ,gg=G 格式化代码
    let g:autoformat_autoindent = 0
    let g:autoformat_retab = 0
    let g:autoformat_remove_trailing_spaces = 0
"}}

"{{ vim基本设置
    if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
    
    if has("syntax")
        syntax on
    endif

    " Source a global configuration file if available
    if filereadable("/etc/vim/vimrc.local")
        source /etc/vim/vimrc.local
    endif
"}}

"{{ Common configure
    set showmatch        " 高亮显示匹配的括号
    set cindent          " c/c++风格
    set number           " 显示行号
    set cursorline       " 突出显示当前行
    "set cursorcolumn    " 突出显示当前列
    set tabstop=4        " 一个tab相当于4个空格的长度
    set shiftwidth=4     " 每次缩进的空格数
    set expandtab        " 将tab展开为空格
    set nobackup         " 从不备份
    set nocompatible     " 与 Vi 不完全兼容
    set noswapfile       " 关闭交换文件
    set ignorecase       " 搜索忽略大小写
    set ruler            " 右下角显示当前光标位置
    set showcmd          " 在 Vim 窗口右下角，标尺的右边显示未完成的命令
    set novisualbell     " 不要闪烁
    set backspace=2      " INSERT模式下Delete删除缩进和行尾，但Backspace不能向前删除
    set nowrapscan       " 禁止循环查找方式
    "set noignorecase    " 精确匹配大小写
    set nocompatible
    set hlsearch
    set encoding=utf-8

    set autochdir
    set tags=tags;

    set t_Co=256
    set background=dark
    colorscheme dracula
"}}

"{{ 配色相关

    ""YouCompleteMe配色相关
    "设置标记一列的背景颜色和数字一行颜色一致
    hi! link SignColumn   LineNr
    hi! link ShowMarksHLl DiffAdd
    hi! link ShowMarksHLu DiffChang

    "hi IndentGuidesOdd  ctermbg=black
    "hi IndentGuidesEven ctermbg=darkgrey
    "set ts=4 sw=4 noet

    "YouCompleteMe标签栏颜色
    "highlight PmenuSbar ctermfg=red        "弹出菜单: 滚动
    "highlight PmenuThumb ctermbg=yellow    "滚动条
    "highlight Pmenu ctermfg=6 ctermbg=7     "普通菜单
    "highlight PmenuSel ctermfg=7 ctermbg=8  "选中项

    " 防止错误整行标红导致看不清
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline
    
    " 修正vim背景配色
    highlight Normal ctermbg=NONE
    highlight nonText ctermbg=NONE
    highlight LineNr ctermbg=NONE
    highlight Error cterm=bold ctermfg=1 ctermbg=NONE
"}}
