lua << EOF
-- lua lsp package loads here
global = {}

require('lua-init')
-- a function to print stuff
-- ex- :luado put(vim.loop)
-- or inside lua good to see the object
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

EOF

" ------------------Theme
" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
endif
" theme
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai
"---------------------------
"
"-------------------Genral sets
set autoread hidden     " Reload files changed outside vim
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !
set numberwidth=4

"set list listchars=tab:»·,trail:·,nbsp:·
set cursorline

 "Open new split panes to right and bottom, which feels more natural
set splitbelow splitright
"Start scrolling when we're 8 lines away from margins
set scrolloff=8 sidescrolloff=15 sidescroll=1

"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set nu nowrap rnu
set mouse=a
set tabstop=2
set ts=2 sts=2 sw=2 expandtab
set smartindent nohlsearch incsearch 
set colorcolumn=80

" Preventing commenting the next line
au BufRead,BufNewFile * set formatoptions=""


" Add space for sing column
set signcolumn=yes

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set ignorecase
set ruler

"Conceal half-width space with space
call matchadd('Conceal', '\%u200c', 10, -1, {'conceal':' '})
set conceallevel=2 concealcursor=nv
set termbidi
"----------------------------------------
"
" This add Mark after modificatoin or insertion
let g:detect_mod_reg_state = -1

function! DetectRegChangeAndUpdateMark()
    let current_small_register = getreg('"-')
    let current_mod_register = getreg('""')
    if g:detect_mod_reg_state != current_small_register || 
                \ g:detect_mod_reg_state != current_mod_register
        normal! mM
        let g:detect_mod_reg_state = current_small_register
    endif
endfunction

autocmd FocusLost * call ToggleNumbersOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleNumbersOn()
autocmd InsertLeave * call ToggleRelativeOn()

" Mark I at the position where the last Insert mode occured across the buffer
autocmd InsertLeave * execute 'normal! mI'

" Mark M at the position when any modification happened 
" in the Normal or Insert mode
autocmd CursorMoved * call DetectRegChangeAndUpdateMark()
autocmd InsertLeave * execute 'normal! mM'
"----------------------------------------
function! ToggleNumbersOn()
    set nu
    set rnu!
endfunction
function! ToggleRelativeOn()
    set rnu
endfunction

"--------------------------------
" Add those file extentions you want to have 4 tab
"au BufNewFile,BufRead *.py,*.vhdl
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix
