# https://dev.37signals.com/domain-driven-boldness/

class Contact < ApplicationRecord
  include Petitioner
  include Contactables

  # ...
end