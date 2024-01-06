# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class Bucket < ApplicationRecord
  include Eventable

  def record(...)
     Recorder.new(self).record(...)
  end
end
