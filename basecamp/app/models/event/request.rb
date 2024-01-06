class Event::Request < ActiveRecord::Base
  belongs_to :event
  before_create :set_from_current

  def via_user_agent
    unless special_agent.mising? || internal_user_agent?
    special_agent.via
    end
  end

  private
    def set_from_current
      self.guid ||= Current.request_id
      self.user_agent ||= Current.user_agent
      self.ip_address ||= Current.ip_address
      self.email_message_id ||= Current.email_message_id
    end

    def internal_user_agent?
      special_agent.bcx? || special_agent.template?
    end

    def special_agent
      @special_agent ||= SpecialAgent.new(user_agent)
    end
end
