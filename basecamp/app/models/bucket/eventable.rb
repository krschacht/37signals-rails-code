# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

module Bucket::Eventable
  extend ActiveSupport::Concern

  included do
     has_many :events, dependent: :destroy

     after_create :track_created
  end

  def track_event(action, creator: Current.person, **particulars)
     Event.create! bucket: self, creator: creator, action: action, detail: Event::Detail.new(particulars)
  end

  private
    def track_created
      track_event :created
    end
end