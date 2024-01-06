# https://dev.37signals.com/active-record-nice-and-blended/

class User < ApplicationRecord
  include Contactable
end