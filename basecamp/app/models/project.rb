# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class Project < ApplicationRecord
  include Bucketable

  belongs_to :creator, class_name: "Person", default: -> { Current.person }
end
