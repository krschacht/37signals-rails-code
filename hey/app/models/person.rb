# https://dev.37signals.com/active-record-nice-and-blended/

class Person < ApplicationRecord
  include Contactable
end