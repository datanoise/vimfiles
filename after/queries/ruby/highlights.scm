; extends

; ActiveRecord methods
(call method: (identifier) @rails.method
      (#any-of? @rails.method "belongs_to" "has_many" "has_one" "has_and_belongs_to_many" "validates"
       "with_options" "has_one_attached" "has_many_attached" "scope" "default_scope" "where" "order"
       "includes" "joins" "not" "composed_of" "normalizes" "ignored_columns")
      (#set! "priority" 200))

(call receiver: (identifier) @rails.method
      (#any-of? @rails.method "where")
      (#set! "priority" 200))

; ActiveRecord callbacks
(call method: (identifier) @rails.method
      (#any-of? @rails.method "before_validation" "after_commit" "before_destroy" "before_save" )
      (#set! "priority" 200))

; ActionPack methods
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "helper" "protect_from_forgery" "layout" "rescue_from" "helper_method")
      (#set! "priority" 200))

; ActionPack callbacks
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "before_action" "after_action" "around_action" "skip_before_action")
      (#set! "priority" 200))

; ActionJob methods
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "queue_as" "retry_on" "discard_on" "limits_concurrency" "sidekiq_locking" "sidekiq_retry_in")
      (#set! "priority" 200))

; Custmom methods
(call method: (identifier) @rails.method
      (#any-of? @rails.method "def_attribute" "auth" "bool_def_param" "def_param")
      (#set! "priority" 200))

; Adding custom query to properly highlight the symbols
([
  (simple_symbol)
  (delimited_symbol)
  (hash_key_symbol)
  (bare_symbol)
] @string.special.symbol.custom (#set! "priority" 200))
