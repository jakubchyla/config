" vim:foldmethod=marker

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"basic set up
    syntax on

"basic editor options
    set nu
    set relativenumber
    set encoding=utf-8
    set hidden "seperate tabs
    set breakindent

"theme
    if exists('g:GuiLoaded')
        GuiFont Fira Code:h12
    endif
    colorscheme tempus_totus

"disable swapfile
    set noswapfile

"disable gvim widgets
    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar
    set guioptions-=r "remove right-hand scroll bar
    set guioptions-=L "remove left-hand scroll bar

"show existing tab with 4 spaces width
    set tabstop=4
"when indenting with '>' use 4 spaces width
    set shiftwidth=4
"on pressing tab, insert 4 spaces
    set expandtab
    set autoindent
    set softtabstop=4

"set delays
    set timeoutlen=1000
    set ttimeoutlen=10

"-----------------------
" keybinds
"-----------------------

    nnoremap <Space> <Nop>
    let g:mapleader = " "

"move by one 'visible' line 
    nnoremap k gk
    nnoremap j gj
    vnoremap k gk
    vnoremap j gj

"save with Shift+w
    nnoremap <S-w> :update<CR>
    nnoremap <S-q> :q<CR>

    noremap <leader>y "+y
    noremap <leader>p "+p
    noremap <leader>Y "+y
    noremap <leader>P "+p

"clear highlight and search
    nnoremap / :noh<CR> :/

    inoremap jj <Esc>
    cnoremap jj <Esc>
    nnoremap <leader>k :
    
    ""insert space before cursor
    "nnoremap <leader>h i<Space><Esc>
    ""insert space after cursor
    "nnoremap <leader>l a<Space><Esc>
    
    "insert empty lines
    nnoremap <A-j> o<Esc>
    nnoremap <A-k> O<Esc>

    "merge lines
    nnoremap <C-j> :j<CR>
    nnoremap <C-k> k:j<CR>j

    "movement
    nnoremap <leader>j 5j
    nnoremap <leader><leader>j 10j
    vnoremap <leader>j 5j
    vnoremap <leader><leader>j 10j

    nnoremap <leader>k 5k
    nnoremap <leader><leader>k 10k
    vnoremap <leader>k 5k
    vnoremap <leader><leader>k 10k

    nnoremap <leader>h 5h
    nnoremap <leader><leader>h 10h
    vnoremap <leader>h 5h
    vnoremap <leader><leader>h 10h

    nnoremap <leader>l 5l
    nnoremap <leader><leader>l 10l
    vnoremap <leader>l 5l
    vnoremap <leader><leader>l 10l

    nnoremap J 50jzz
    nnoremap J 50jzz
    vnoremap K 50kzz
    vnoremap K 50kzz

    
"-----------------------
" language specific
"-----------------------

"set asm syntax
    au BufRead,BufNewFile *.s   let asmsyntax='gas'|set filetype=asm
    au BufRead,BufNewFile *.asm let asmsyntax='nasm'|set filetype=nasm

"-----------------------
" plugins options
"-----------------------

"vim-airline
let g:airline_section_y = ""
let g:airline_section_z = ""
let g:airline_section_warning = ""


"coc.vim
"{{{
"dependencies: python-language-server, ccls, bash language server
"CocInstall: coc-json, coc-html, coc-css, coc-rls, coc-python, coc-highlight, coc-git, coc-vimlsp, coc-pairs
    "Some servers have issues with backup file
    set nobackup
    set nowritebackup

    "Better display for messages
    set cmdheight=2

    "You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300

    "don't give |ins-completion-menu| messages.
    set shortmess+=c

    "always show signcolumns
    set signcolumn=yes

    "Use tab for trigger completion with characters ahead and navigate.
    "Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    "Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    "Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    "Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "Or use `complete_info` if your vim support it, like:
    "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    "Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    "Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    "Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    "Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    "Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      "Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      "Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    "Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    "Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    "Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    "Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    "Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <C-d> <Plug>(coc-range-select)
    xmap <silent> <C-d> <Plug>(coc-range-select)

    "Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    "Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    "use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    "Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"}}}
