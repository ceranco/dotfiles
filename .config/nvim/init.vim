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

" -----------------------------
" ------ Persistent Undo ------
" -----------------------------
" {{{

" Create undo directory if needed.
if !isdirectory("/tmp/.nvim-undo-dir")
    call mkdir("/tmp/.nvim-undo-dir")
endif

set undodir=/tmp/.nvim-undo-dir
set undofile

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
nnoremap <leader>qq :q!<cr>
nnoremap <leader>wq :wq<cr>

" Map <H> and <L> (uppercase) to move to beginning and end of the current (display) line.
nnoremap <s-h> g^
vnoremap <s-h> g^
nnoremap <s-l> g$
vnoremap <s-l> g$

" Always use 'very-magic' (aka sane regex) when searching.
nnoremap / /\v
nnoremap ? /\v

" Wrap word with quotes / brackets.
nnoremap <leader>' viw<esc>`>a'<esc>`<i'<esc>
nnoremap <leader>" viw<esc>`>a"<esc>`<i"<esc>
nnoremap <leader>[ viw<esc>`>a]<esc>`<i[<esc>
nnoremap <leader>{ viw<esc>`>a}<esc>`<i{<esc>
nnoremap <leader>( viw<esc>`>a)<esc>`<i(<esc>

" Wrap selection (visual mode) in quotes / brackets.
" NOTE that `> and `< remember specific positions, so we should first insert
" the last quote to prevent unneeded key-strokes.
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>2l
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>2l
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>`>2l
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>`>2l
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>`>2l

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

" Add newline without entering insert mode.
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Add semicolon at end of line.
nnoremap <leader>; maA;<esc>`a
inoremap <M-;> <esc>maA;<esc>`aa

" Jump to numbered buffer
nnoremap <leader>b :<C-U>exe v:count . "b"<cr>

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

