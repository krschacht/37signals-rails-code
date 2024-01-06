# https://dev.37signals.com/good-concerns/

class Topic < ApplicationRecord
  include Accessible, Breakoutable, Deletable, Entries, Incineratable, Indexed, Involvable, Journal, Mergeable, Named, Nettable, Notifiable, Postable, Publishable, Preapproved, Collectionable, Recycled, Redeliverable, Replyable, Restorable, Sortable, Spam, Spanning

  # ...
end
