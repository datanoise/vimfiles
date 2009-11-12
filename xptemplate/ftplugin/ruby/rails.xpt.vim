if !g:XPTloadBundle( 'ruby', 'rails' )
  finish
endif

XPTemplate priority=lang-2

let s:f = g:XPTfuncs()

XPTinclude
  \ _common/common

" ========================= Function and Variables =============================



" ================================= Snippets ===================================
XPTemplateDef

XPT p hint=params[:id]
params[:`id^]

XPT s hint=session[:id]
session[:`id^]

XPT f hint=flash[:id]
flash[:`id^]

XPT rep hint=redirect_to\(path)
redirect_to(`model^_path(`@^`model^))

XPT repp hint=redirect_to\(path\ plural)
redirect_to(`model^s_path)

XPT renp hint=redirect_to\(nested\ path)
redirect_to(`parent^_`child^_path(`v1^@^`parent^, `v2^@^`child^))

XPT rea hint=redirect_to\(action)
redirect_to :action => "`index^"

XPT reai hint=redirect_to\(action,\ id)
redirect_to :action => "`show^", :id => `@item^

XPT rec hint=redirect_to\(controller)
redirect_to :controller => "`items^"

XPT reca hint=redirect_to\(controller,\ action)
redirect_to :controller => "`items^", :action => "`list^"

XPT recai hint=redirect_to\(controller,\ action,\ id)
redirect_to :controller => "`items^", :action => "`show^", :id => "`item^"

XPT reb hint=redirect_to\ :back
redirect_to :back

XPT verify hint=verify\ -\ redirect
verify :only => [`only^], :session => :user, :params => :id, :redirect_to => {:action => '`index^'}

XPT rfu hint=render\ \(file,\ use_full_path)
render :file => "`filepath^", :use_full_path => `false^

XPT ril hint=render\ \(inline,\ locals)
render :inline => "`<%= 'hello' %>^", :locals => { `:name^ => "`value^" }

XPT ral hint=render\ \(action,\ layout)
render :action => "`action^", :layout => "`layout^"

XPT ra hint=render\ \(action)
render :action => "`action^"

XPT rtlt hint=render\ \(text,\ layout\ =>\ true)
render :text => "`text to render...^", :layout => `true^

XPT rl hint=render\ \(layout)
render :layout => "`layout^"

XPT rp hint=render\ \(partial)
render :partial => "`item^"

XPT rpo hint=render\ \(partial,\ object)
XSET obj|pre=@item
XSET obj|def=@R('item')
render :partial => "`item^", :object => `obj^

XPT rpc hint=render\ \(partial,\ collection)
XSET col|pre=@items
XSET col|def=@R('item')s
render :partial => "`item^", :collection => `col^

XPT rpl hint=render\ \(partial,\ locals)
XSET key|pre=item
XSET key|def=R('item')
XSET value|pre=@item
XSET value|def=@R('item')
render :partial => "`item^", :locals => { :`key^ => `value^ }

XPT rps hint=render\ \(partial,\ status)
render :partial => "`item^", :status => `500^

XPT rtl hint=render\ \(text,\ layout)
render :text => "`text to render...^", :layout => `layout^

XPT rts hint=render\ \(text,\ status)
render :text => "`text to render...^", :status => `401^

XPT rn hint=render\ (nothing)
render :nothing => `true^

XPT rns hint=render\ (nothing,\ status)
render :nothing => `true^, :status => `401^

XPT rf hint=render\ (file)
render file => "`file path^"

XPT rit hint=render\ \(inline,\ type)
render :inline => "`<%= 'hello' %>^", :type => `:rxml^

XPT ri hint=render\ \(inline)
render :inline => "`<%= 'hello' %>^"

XPT rt hint=render\ \(text)
render :text => "`<%= 'hello' %>^"

XPT ru hint=render\ \(update)
render :update do |`page^|
    `page^.`cursor^
end

XPT rest hint=respond_to
XSET wants|def=Trigger('wants')
respond_to do |wants|
    `wants^`
    `wants...^
    `wants^`
    `wants...^
end

XPT wants hint=wants.format
XSET format=Choose(['js', 'xml', 'html'])
wants.`format^` { `val` }^

XPT maprs hint=map.resources
XSETm do...|post
 do |`res_obj^|
    `cursor^
end
XSETm END
XSET res_obj=R('resource')
`map^.resources :`resource^` `do...`^

XPT mapr hint=map.resource
XSETm do...|post
 do |`res_obj^|
    `cursor^
end
XSETm END
XSET res_obj=R('resource')
`map^.resource :`resource^` `do...`^

XPT mapwo hint=map.with_options
`map^.with_options :`controller^ => '`thing^' do |`thing^R('thing')^|
    `cursor^
end

XPT mapca hint=map.catch_all
`map^.catch_all "*`anything^", :controller => "`default^", :action => "`error^"

XPT ho hint=has_one
XSET attributes...|post=, :class_name => "`name^", :foreign_key => "`id^"
XSET name=RubyCamelCase(R('object'))
XSET id=R('object')_id
has_one :`object^`, `attributes...`^

XPT bt hint=belongs_to
XSET attributes...|post=, :class_name => "`name^", :foreign_key => "`id^"
XSET name=RubyCamelCase(R('object'))
XSET id=R('object')_id
belongs_to :`object^`, `attributes...`^

XPT habtm hint=has_and_belongs_to_many
XSET attributes...|post=, :join_table => "`table_name^", :foreign_key => "`id^"
XSET id=R('object')_id
has_and_belongs_to_many :`object^`, `attributes...`^

XPT hm hint=has_many
XSET attributes...|post=, :class_name => "`class^", :foreign_key => "`id^"
XSET class=R('object')
XSET id=R('object')_id
has_many :`object^s`, `attributes...`^

XPT hmd hint=has_many\ :dependent\ =>\ :destroy
XSET attributes...|post=, :class_name => "`class^", :foreign_key => "`id^", :dependent => :destroy
XSET class=R('object')
XSET id=R('object')_id
has_many :`object^s`, `attributes...`^

XPT hmt hint=has_many\ \(through)
XSET source...|post=, :source => :`source^
has_many :`object^, :through => :`join_association^`, `source...`^

XPT vao hint=validates_acceptance_of
XSET attributes...|post=, :accept => "`accept^", :message => "`You must accept the terms of service^"`, :`if...`^
XSET accept=R('terms')
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_acceptance_of :`terms^`, `attributes...`^

XPT va hint=validates_associated
XSET attributes...|post=, :on => :`create^`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_associated :`attribute^`, `attributes...`^

XPT vc hint=validates_confirmation_of
XSET attributes...|post=, :on => :`create^, :message => "`should match confirmation^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_confirmation_of :`attribute^`, `attributes...`^

XPT ve hint=validates_exclusion_of
XSET attributes...|post=, :on => :`create^, :in => `in^, :message => "`extension %s is not allowed^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
XSET in|pre=%w[ mov avi ]
XSET in|post=BuildIfNoChangePre('%w[ `mov avi^ ]')
validates_exclusion_of :`attribute^`, `attributes...`^

XPT vi hint=validates_inclusion_of
XSET attributes...|post=, :on => :`create^, :in => `in^, :message => "`extension %s is not included in the list^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
XSET in|pre=%w[ mov avi ]
XSET in|post=BuildIfNoChangePre('%w[ `mov avi^ ]')
validates_inclusion_of :`attribute^`, `attributes...`^

XPT vf hint=validates_format_of
XSET attributes...|post=, :on => :`create^, :message => "`is invalid^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
XSET with|pre=^[\w\d]+$
validates_format_of :`attribute^, :with => /`with^/`, `attributes...`^

XPT vn hint=validates_numericality_of
XSET attributes...|post=, :on => :`create^, :message => "`is not a number^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_numericality_of :`attribute^`, `attributes...`^

XPT vp hint=validates_presence_of
XSET attributes...|post=, :on => :`create^, :message => "`can't be blank^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_presence_of :`attribute^`, `attributes...`^

XPT vl hint=validates_length_of
XSET attributes...|post=, :on => :`create^, :message => "`must be present^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_length_of :`attribute^, :within => `3..20^`, `attributes...`^

XPT vu hint=validates_uniqueness_of
XSET attributes...|post=, :on => :`create^, :message => "`must be unique^"`, :`if...`^
XSET if...|post=, :if => lambda { |obj| `cond^obj.condition?^ }
validates_presence_of :`attribute^`, `attributes...`^

XPT fina hint=find\(:all)
XSET conditions...|post=, :conditions => ['`cond...^', `true^]
XSET cond...|post=`field^ = ?
find(:all`, `conditions...`^)

XPT finf hint=find\(:first)
XSET conditions...|post=, :conditions => ['`cond...^', `true^]
XSET cond...|post=`field^ = ?
find(:first`, `conditions...`^)

XPT finl hint=find\(:first)
XSET conditions...|post=, :conditions => ['`cond...^', `true^]
XSET cond...|post=`field^ = ?
find(:last`, `conditions...`^)

XPT fini hint=find\(id)
find(`id^)

XPT finb hint=find_in_batches
XSET conditions...|post=:conditions => {:`field^ => `true^}
find_in_batches(`conditions...^) do |`item^s|
    `item^s.each do |`item^|
        `cursor^
    end
end

XPT fine hint=find_each
XSET conditions...|post=:conditions => {:`field^ => `true^}
find_in_batches(`conditions...^) do |`item^|
    `cursor^
end

XPT nc hint=named_scope
XSET joins...|post=, :joins => :`table^
XSET conditions...|post=['`field^ = ?', `true^]
named_scope :`name^`, `joins...`^, :conditions => `conditions...^

XPT ncl hint=named_scope\ lambda
XSET conditions...|post=['`field^ = ?', `true^]
named_scope :`name^, lambda { |`param^| { :conditions => `conditions...^ } }

XPT dc hint=default_scope
XSET joins...|post=, :joins => :`table^
default_scope :`order^ => `'created_at DESC'^`, :`joins...`^

XPT plugin hint=Plugin\ template
XSET def=Trigger('def')
module `plugin^
    def self.included(base)
        base.send :extend, ClassMethods
    end

    module ClassMethods
        def acts_as_`plugin^S(SV('[A-Z]','_\l&','g'),'\<_','','')^
            send :include, InstanceMethods
        end
    end

    module InstanceMethods
        `
        `def...^
        `def^`
        `def...^
    end
end
