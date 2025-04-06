; extends

; ActiveRecord methods
(call method: (identifier) @rails.method
      (#any-of? @rails.method "belongs_to" "has_many" "has_one" "validates"
       "with_options" "has_one_attached" "scope" "def_attribute" "where" "order"
       "includes" "joins" "not" "composed_of" "normalizes"))

(call receiver: (identifier) @rails.method
      (#any-of? @rails.method "where"))

; ActiveRecord callbacks
(call method: (identifier) @rails.method
      (#any-of? @rails.method "before_validation" "after_commit" "before_destroy" "before_save" ))

; ActionPack methods
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "auth" "helper" "protect_from_forgery" "layout" "rescue_from" "helper_method"))

; ActionPack callbacks
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "before_action" "after_action" "around_action" "skip_before_action"))

; ActionJob methods
 (call method: (identifier) @rails.method
      (#any-of? @rails.method "queue_as" "retry_on" "discard_on" "limits_concurrency" "sidekiq_locking" "sidekiq_retry_in"))

