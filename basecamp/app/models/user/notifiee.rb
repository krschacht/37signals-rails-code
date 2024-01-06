module User::Notifiee
    extend ActiveSupport::Concern

    included do; end

    def notifications
        @notifications ||= User::Notifications.new(self)
    end

    private
        def default_to_hiding_badge_counts; end
end


# Current.user.notifications
# User::Notifications.new(Current.user)
