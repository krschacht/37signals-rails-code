# https://dev.37signals.com/good-concerns/

class Account < ApplicationRecord
  include Closable

  # ...
end