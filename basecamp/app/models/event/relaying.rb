# https://dev.37signals.com/fractal-journeys/

module Event::Relaying
  extend ActiveSupport::Concern

  included do
    after_create_commit :relay_later, if: :relaying?
    has_many :relays
  end

  def relay_later
    Event::RelayJob.perform_later(self)
  end

  def relay_now
    relay_to_or_revoke_from_timeline

    relay_to_webhooks_later
    relay_to_customer_tracking_later

    if recording
      relay_to_readers
      relay_to_appearants
      relay_to_recipients
      relay_to_schedule
    end
  end

  private
    def relay_to_or_revoke_from_timeline
      if bucket.timelined?
        ::Timeline::Relayer.new(self).relay
        ::Timeline::Revoker.new(self).revoke
      end
    end
end