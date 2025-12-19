; extends

; ActiveSupport methods
(call method: (identifier) @rails.method
      (#any-of? @rails.method "delegate" "class_attribute" "thread_mattr_accessor" "mattr_accessor" "mattr_reader"
       "mattr_writer")
      (#set! "priority" 200))

; ActiveRecord methods
(call method: (identifier) @rails.method
      (#any-of? @rails.method "belongs_to" "has_many" "has_one" "has_and_belongs_to_many" "validates"
       "with_options" "has_one_attached" "has_many_attached" "scope" "default_scope" "where"
       "includes" "joins" "not" "composed_of" "normalizes" "ignored_columns" "limit" "references" "select"
       "optimizer_hints")
      (#set! "priority" 200))

(call receiver: (identifier) @rails.method
      (#any-of? @rails.method "where")
      (#set! "priority" 200))

; ActiveRecord callbacks
(call method: (identifier) @rails.method
      (#any-of? @rails.method "before_validation" "after_commit" "before_destroy" "before_save" "after_save"
       "after_update" "after_destroy" "after_create" "before_create" "before_update"
       "around_save" "around_create" "around_update" "around_destroy" "after_initialize" "after_find" "after_touch"
       "before_validation_on_create" "before_validation_on_update")
      (#set! "priority" 200))

; ActionPack methods
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "helper" "protect_from_forgery" "layout" "rescue_from" "helper_method")
      (#set! "priority" 200))

; ActionPack callbacks
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "before_action" "after_action" "around_action" "skip_before_action" "before_render"
       "http_basic_authenticate_with")
      (#set! "priority" 200))

; ActionJob methods
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "queue_as" "retry_on" "discard_on" "limits_concurrency" "sidekiq_locking" "sidekiq_retry_in")
      (#set! "priority" 200))

; Minitest methods
(call method: (identifier) @rails.method
      (#any-of? @rails.method "assert" "assert_equal" "assert_not" "assert_presence" "assert_not_nil" "assert_nil"
       "assert_includes" "assert_difference" "assert_no_difference" "assert_changes" "assert_match" "assert_no_match"
       "assert_raises" "assert_nothing_raised" "assert_respond_to" "assert_silent" "assert_empty" "assert_not_empty"
       "assert_predicate" "assert_not_predicate" "assert_kind_of" "assert_instance_of" "assert_same" "assert_not_same"
       "assert_enqueued_with" "assert_no_enqueued_jobs" "assert_in_delta" "assert_media_file" "assert_response" 
       "assert_operator")
      (#set! "priority" 200))

(call method: (identifier) @minitest.method
      (#any-of? @minitest.method "test" "setup" "teardown")
      (#set! "priority" 200))

(call method: (identifier) @minitest.method
      (#any-of? @minitest.method "test")
      arguments: (argument_list (string (string_content) @minitest.name))
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
