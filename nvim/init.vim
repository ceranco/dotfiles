" -----------------------------
" ------ Global Settings ------
" -----------------------------
" {{{{

" Use Vim settings, rather than Vi settings.
" This must be first, as it affects other options.
set nocompatible

" Sets the color scheme to the awesome OneDark scheme.
" (https://github.com/joshdick/onedark.vim)
colorscheme onedark

" Makes yanking (copying) use the system clipboard
" (i.e. CTRL-C / CTRL-V).
set clipboard=unnamedplus

" Enables hybrid line-numbers (https://linuxize.com/post/how-to-show-line-numbers-in-vim/#hybrid-line-numbers).
set relativenumber
set number

" Some black magic to somehow make color themes work with
" WSL, Windows Terminal and TMUX.
if exists('$TMUX')
	" Colors in tmux
	let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors
set background=dark

" Sets tabs to 4-characters wide.
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Show matching bracket when inserting a closing one. 
set showmatch

" Shows a few lines of context above / below the cursor.
set scrolloff=3

" Set the mappings leader.
let mapleader = " "
let maplocalleader = " "

" Reduce timout.
set timeoutlen=300

" }}}

" ---------------------
" ------ Plugins ------
" ---------------------
" {{{

call plug#begin(stdpath('data') . 'plugged')

" Coc provides LSP support.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Rust filetype plugin.
Plug 'rust-lang/rust.vim'

" Toggle comments.
Plug 'tpope/vim-commentary'

call plug#end()

" }}}

" --------------------------
" ------ Coc Settings ------
" --------------------------
" {{{

" These settings are all taken directly from
" 'https://github.com/neoclide/coc.nvim' example configuration.

" This is the list of all the used extensions. I prefer to use a global
" variable rather then :CocInstall to enable synchronizing the installed
" packages across machines.
let g:coc_global_extensions = [
	\'coc-rust-analyzer',
	\'coc-pairs',
	\'coc-actions'
	\]

" TextEdit might fail if hidden is not set.
set hidden

" Having a shorter update time leads to a better Coc experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <cr>`.
" Also call 'coc#on_enter()'.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>\<esc>:call coc#on_enter()\<cr>i"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>\<esc>:call coc#on_enter()\<cr>i"
endif

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
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
 
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)

" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>al  <Plug>(coc-fix-current)

" Open action pane.
nnoremap <silent> <leader>a :CocCommand actions.open<cr>

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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList

" Show all diagnostics.
nnoremap <silent><nowait> <leader>ld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Search workleader symbols.
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>lp  :<C-u>CocListResume<CR>

" Do default action for next item.
nnoremap <silent><nowait> <leader>n  :<C-u>CocNext<CR>

" Do default action for previous item.
nnoremap <silent><nowait> <leader>p  :<C-u>CocPrev<CR>

" Add mappings to scroll the floating window.
nnoremap <expr><C-j> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-j>"
nnoremap <expr><C-k> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-k>"

" }}}

" ------------------------
" ------ Remappings ------
" ------------------------
" {{{

" Disable all <esc> mappings that aren't 'jk'.
inoremap <s-[> <nop>
inoremap <esc> <nop>
vnoremap <s-[> <nop>
vnoremap <esc> <nop>
cnoremap <s-[> <nop>
cnoremap <esc> <nop>

inoremap jk <esc>
cnoremap jk <c-c>

" Disable usage of arrow keys.
nnoremap <left> <nop>
nnoremap <up> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
inoremap <left> <nop>
inoremap <up> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <up> <nop>
vnoremap <right> <nop>
vnoremap <down> <nop>

" Enables shift-tabbing to tab backwards.
inoremap <S-Tab> <C-d>

" Move by display lines, for sanity.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Enables moving around in insert mode.
inoremap <C-k> <C-o>g<Up>
inoremap <C-j> <C-o>g<Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Add mapping to enable easy reloading,
nnoremap <leader>r :source $MYVIMRC<cr>

" Toggle search highlight using <Ctrl-\>.
nnoremap <silent><expr> <C-\> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Use <leader>w and <leader>q to save / exit the document.
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>wq :wq<cr>

" Map <H> and <L> (uppercase) to move to beginning and end of the current (display) line.
nnoremap <s-h> g^
vnoremap <s-h> g^
nnoremap <s-l> g$
vnoremap <s-l> g$

" Always use 'very-magic' (aka sane regex) when searching.
nnoremap / /\v
nnoremap ? /\v

" Operator mappings for "[in / around] [next / last]
" [parentheses / curly brackets].
" The '<C-u>' is needed to remove the the range that Vim inserts.
onoremap in( :<C-u>normal! f(vi(<cr>
onoremap il( :<C-u>normal! F)vi(<cr>
onoremap an( :<C-u>normal! f(va(<cr>
onoremap al( :<C-u>normal! F)va(<cr>

onoremap in{ :<C-u>normal! f{vi{<cr>
onoremap il{ :<C-u>normal! F}vi{<cr>
onoremap an{ :<C-u>normal! f{va{<cr>
onoremap al{ :<C-u>normal! F}va{<cr>

" Wrap word with single / double quotes.
nnoremap <leader>' viw<esc>`>a'<esc>`<i'<esc>
nnoremap <leader>" viw<esc>`>a"<esc>`<i"<esc>

" Wrap selection (visual mode) in single double quotes.
" NOTE that `> and `< remember specific positions, so we should first insert
" the last quote to prevent unneeded key-strokes.
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>2l
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>2l

" Adds a mapping to highlight trailing whitespace as an error.
" Adds another mapping to clear match.
augroup trailing_whitespace_highlight_group
	autocmd!
	autocmd BufEnter * :highlight TrailingWhitespaceError ctermbg=LightRed guibg=#f59b42
augroup END
nnoremap <leader>t :match TrailingWhitespaceError /\v[ \t]+$/<cr>
nnoremap <leader>T :match none<cr>

" Add mappings for easily opening new files in splits.
nnoremap <leader>sa :leftabove split 
nnoremap <leader>sl :leftabove vsplit 
nnoremap <leader>sb :rightbelow split 
nnoremap <leader>sr :rightbelow vsplit 

" Toggle line comment using <C-/> (vim-commentary plugin).
xmap <C-_> <Plug>Commentary
nmap <C-_> <Plug>CommentaryLine
imap <C-_> <C-O><Plug>CommentaryLine

" }}}

" ------------------
" ------ Rust ------
" ------------------
" {{{

" Enable autoformat on save.
augroup rust_settings
	autocmd!
	autocmd FileType rust let g:rustfmt_autosave=1
	autocmd FileType rust set foldmethod=syntax
	autocmd BufRead *.rs :normal zR
augroup END

" }}}

" Go to last visited line on open on open buffer.
" NOTE: 'https://github.com/vim/vim/blob/master/runtime/defaults.vim' has a
" different (probably better) implementation.
augroup open_on_last_visited
	autocmd!
	autocmd BufReadPost * :normal `"zz
augroup END

" Enable spell-checking on .txt files.
augroup spellcheck
	autocmd!
	autocmd FileType text setlocal spell
augroup END

" Use folding markers on vim files.
augroup vim_fold_settings
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" Display friendly ASCII-art cat when init.vim is sourced.
echo ">^.^<"

