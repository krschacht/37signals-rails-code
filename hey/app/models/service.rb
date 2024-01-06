# https://dev.37signals.com/active-record-nice-and-blended/

class Service < ApplicationRecord
  include Contactable
end