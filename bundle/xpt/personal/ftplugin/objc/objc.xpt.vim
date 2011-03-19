XPTemplate priority=personal
let s:f = g:XPTfuncs()


XPT log " NSLog
NSLog(@"`message^"`, `args^);

XPT m " - (...) ...
- (`void^) `methodName^`:`args...^
XSETm args...|post
:(`type^)`param^` `more...^
XSETm END
XSETm more...|post
 `name^:(`type^)`param^` `more...^
XSETm END
