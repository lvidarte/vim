" ============================================================================
" File:        heading.vim
" Version:     0.1
" Description: vim global plugin that provides a way to create headings.
" Maintainer:  Leonardo Vidarte <lvidarte[at]gmail>
" Last Change: February 21, 2010
" ============================================================================

if has('python')
python << EOF
def heading(decorator='=', top=False, bottom=True, limit=0, uppercase=False):

    import vim
    from string import upper, rstrip, lstrip

    if not top and not bottom:
        return None # nothing to do

    (row, col) = vim.current.window.cursor
    line = vim.current.buffer[row-1].rstrip()
    line_length = len(line.decode('utf8'))
    title = line.lstrip()
    word_length = len(title.decode('utf8'))
    whitespace = line[0:line_length - word_length]

    if limit > 0:
        decorator *= limit
        total_length = limit
    else:
        decorator *= word_length
        total_length = line_length

    if title[0:3] in ('// ', '/* ', '-- '):
        decoline = whitespace + title[0:3] + decorator
    elif title[0:2] in ('//', '/*', '--', '# ', '* ', '" '):
        decoline = whitespace + title[0:2] + decorator
    elif title[0:1] in ('#', '*', '"'):
        decoline = whitespace + title[0:1] + decorator
    else:
        decoline = whitespace + decorator

    # Special case: comments like C /* hello world */
    cend = ''
    if title[0:2] == '/*':
        if title[-3:] == ' */':
            cend = ' */'
        elif title[-2:] == '*/':
            cend = '*/'

    decoline = decoline[0:total_length - len(cend)] + cend
    final_heading = []

    if top:
        final_heading.append(decoline)

    if uppercase:
        final_heading.append(line.upper())
    else:
        final_heading.append(line)

    if bottom:
        final_heading.append(decoline)

    del vim.current.buffer[row-1]
    vim.current.buffer[row-1:0] = final_heading

    # Set final cursor position
    # =========================
    if top and bottom:
        vim.current.window.cursor = (row + 2, 0)
    else:
        vim.current.window.cursor = (row + 1, 0)

H = heading # shortcut
EOF

" ============================================================================
" Vim maps (see :help leader)
" ============================================================================
nnoremap <silent> <Leader>hh :python heading('*')<CR>

nnoremap <silent> <Leader>h1 :python heading('=', top=True)<CR>
nnoremap <silent> <Leader>h2 :python heading('-')<CR>
nnoremap <silent> <Leader>h3 :python heading("'")<CR>
nnoremap <silent> <Leader>h4 :python heading('.')<CR>
nnoremap <silent> <Leader>h5 :python heading('~')<CR>

nnoremap <silent> <Leader>HH :python heading(limit=78)<CR>
nnoremap <silent> <Leader>Hb :python heading(limit=78)<CR>
nnoremap <silent> <Leader>Ht :python heading(limit=78, bottom=False)<CR>

endif
