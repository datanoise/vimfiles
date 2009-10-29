XPTemplate priority=lang-

XPTinclude 
    \ _common/common
    \ html/html
    \ html/eruby

XPTembed
    \ ruby/ruby
    \ javascript/javascript
    \ css/css

" ========================= Function and Variables =============================

" ================================= Snippets ===================================
XPTemplateDef

XPT div_for
<% div_for `obj^ do %>
    `cursor^
<% end %>


" ================================= Wrapper ===================================

