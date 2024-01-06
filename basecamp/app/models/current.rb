class Current < ActiveSupport::CurrentAttributes
  attribute :account, :person
  attribute :http_method, :request_id, :user_agent, :ip_address, :referrer

  delegate :user, :integration, to: :person, allow_nil: true
  delegate :identity, to: :user, allow_nil: true

  resets { Time.zone = nil }

  def person=(person)
    super
    self.account = person.try(:account)
    Time.zone = person.try(:time_zone)
  end
end
