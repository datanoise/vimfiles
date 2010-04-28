if !g:XPTloadBundle('eruby', 'rails')
  finish
endif

XPTemplate priority=lang-2

let s:f = g:XPTfuncs()

XPTinclude
  \ _common/common

XPTembed
  \ ruby/rails

" ========================= Function and Variables =============================

fun! s:f.BaseFname(fn)
  return substitute(a:fn, '^\(\w\+\)\(\.\w*\)', '\1', 'g')
endfunction

fun! s:f.BuildOptionalString( str )
  return self.Build( self.V() == '"'.a:str.'..."' ? '`"`'.a:str.'`"^' : self.V() )
endfunction


" ================================= Snippets ===================================

XPT df hint=div_for
<% div_for `obj^ do -%>
    `cursor^
<% end -%>

XPT ff hint=form_for
<% form_for @`model^ do |f| -%>
    `cursor^
<% end -%>

XPT ffe hint=form_for\ with\ errors
<%= error_messages_for :`model^ %>

<% form_for @`model_var^R('model')^ do |f| -%>
    `cursor^
<% end -%>

XPT nff hint=fields_for
<% fields_for :`model^, @`model_obj^{R('model')}^ do |`f^| -%>
    `cursor^
<% end -%>

XPT ffl hint=form_for\ label
XSET name|pre=Attribute
XSET name|def=S(S(R('attribute'),'[[:alpha:]]\+','\u\0','g'),'_',' ','g')
<%= f.label :`attribute^`, "`name`"^ %>

XPT fftf hint=form_for\ text_field
<%= f.text_field :`attribute^ %>

XPT ffta hint=form_for\ text_area
<%= f.text_area :`attribute^ %>

XPT ffcb hint=form_for\ check_box
<%= f.check_box :`attribute^ %>

XPT ffrb hint=form_for\ radio_button
<%= f.radio_button :`attribute^, :`tag_value^ %>

XPT ffpf hint=form_for\ password_field
<%= f.password_field :`attribute^ %>

XPT ffhf hint=form_for\ hidden_field
<%= f.hidden_field :`attribute^ %>

XPT ffff hint=form_for\ file_field
<%= f.file_field :`attribute^ %>

XPT ffs hint=form_for\ submit
XSET label|pre=Submitting...
XSET label|def=R('submit')ing...
<%= f.submit "`submit^Submit^"`, :disable_with =>"`label^" %>

XPT ft hint=form_tag
XSET class...|post=, {:class => "`form^"}
<% form_tag(`:action => "`update^"`, :`class...^) do -%>
    `cursor^
<% end -%>

XPT st hint=submit_tag
XSET attributes...|post=`, :`id...^`, :`name...^`, :`class...^`, :`disabled...^`, :`disabled_with...^
XSET id...|post=, :id => "`submit^"
XSET name...|post=, :name => "`submit^"
XSET class...|post=, :class => "`_^form_submit^"
XSET disabled...|post=, :disabled => `false^
XSET disabled_with...|post=, :disabled_with => "`_^Please wait...^"
<%= submit_tag "`label^Save changes^"`, :`attributes...^ %>

XPT ist hint=image_submit_tag
XSET attributes...|post=`, :`id...^`, :`name...^`, :`class...^`, :`disabled...^
XSET id...|post=, :id => "`_^BaseFname(R('file'))^"
XSET name...|post=, :name => "`_^BaseFname(R('file'))^"
XSET class...|post=, :class => "`_^BaseFname(R('file'))-button^"
XSET disabled...|post=, :disabled => `_^false^
<%= image_submit_tag("`file^agree.png^"`, :`attributes...^) %>

XPT lip hint=link_to\ \(path)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
XSET variable|pre=@model
XSET variable|def=@R('model')
<%= link_to `text^, `model^_path(`variable^) %>

XPT lipp hint=link_to\ \(path\ plural)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, `model^s_path %>

XPT linp hint=link_to\ \(nested\ path\)
XSET pobj|pre=@parent
XSET pobj|def=@R('parent')
XSET cobj|pre=@child
XSET cobj|def=@R('child')
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, `parent^_`child^_path(`pobj^`, `cobj`^) %>

XPT lia hint=link_to\ \(action)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, :action => "`index^" %>

XPT liai hint=link_to\ \(action,\ id)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, :action => "`index^", :id => `@item^ %>

XPT lic hint=link_to\ \(controller)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, :controller => "`items^" %>

XPT lica hint=link_to\ \(controller,\ action)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, :controller => "`index^", :action => "`index^" %>

XPT licai hint=link_to\ \(controller,\ action,\ id)
XSET text|pre="link text..."
XSET text|post=BuildOptionalString('link text')
<%= link_to `text^, :controller => "`index^", :action => "`index^", :id => "`edit^" %>

XPT lim hint=link_to\ \(model)
<%= link_to `model^.`name^, `model^_path(`model^) %>

XPT fore hint=for\ loop\ with\ empty\ check
<% if !`list^.blank? -%>
    <% for `item^ in `list^ -%>
        `code^R('item')^
    <% end %>
<% else -%>
    `cursor^
<% end -%>

XPT for hint=for\ loop
XSET list|pre=@items
XSET code|pre=item
<% for `item^ in `list^@R('item')s^ -%>
    <%= `code^R('item')^.name %>
<% end %>

XPT conf hint=content_for
<% content_for :`yield_label_in_layout^ do -%>
    `cursor^
<% end -%>

XPT end hint=end\ \(ERB)
<% end -%>

XPT jit hint=javascript_include_tag
XSET cache...|post=, :cache => `true^
<%= javascript_include_tag `:all^`, :`cache...`^ %>

XPT slt hint=stylesheet_link_tag
XSET cache...|post=, :cache => `true^
<%= stylesheet_link_tag `:all^`, :`cache...`^ %>

XPT each hint=each\ loop
XSET param=S(S(R('model'), '^@\?\(\w\+\).*', '\1', ''), 's$', '', '')
<% `model^.each do |`param^| %>
    `cursor^
<% end %>
