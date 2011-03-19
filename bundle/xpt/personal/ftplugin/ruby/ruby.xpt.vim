" Default settings and functions used in every snippet file.
XPTemplate priority=personal

" containers
let s:f = g:XPTfuncs()

XPTvar $SPop ''

XPT r " attr_reader
attr_reader :`cursor^

XPT w " attr_writer
attr_writer :`cursor^
