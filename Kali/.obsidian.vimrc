set clipboard=unnamedplus


" " Copy to clipboard
vmap  " y"  "+y
nmap  " Y"  "+yg_
nmap  " y"  "+y
nmap  " yy"  "+yy

" " Paste from clipboard
nmap " p" "+p
nmap " P" "+P
vmap " p" "+p
vmap " P" "+P


" jk to normal mode
imap jk <Esc>

" cancel the highlight
nmap " c" :nohl<CR>

exmap back obcommand app:go-back
nmap H :back
exmap forward obcommand app:go-forward
nmap L :forward
