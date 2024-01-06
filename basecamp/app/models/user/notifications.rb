class User::Notifications
    include RedisConnectable
    set_redis :notifications, clearable: true

    attr_reader :user

    delegate :person, to: :user
    delegate :time_zone, to: :person
    delegate :snoozed?, :off_by_choice?, :off_by_schedule?, :on?, to: :state

    def initialize(user)
        @user = user
    end

    def scheduled; end
    def snoozed; end
    def platforms; end

    def granularity
        @granularity ||= User::Notifications::Granularity.new(self)
    end

    def presentation
    end

    def bundled
    end

    def accepts?(deliverable); end

    def on!; end

    def off!; end

    def state; end

    private
        def user_key
            "notifications/user:#{user.id}"
        end

        def toggle_key
            "#{user_key}/toggle"
        end

        def instrument(action, details = {}); end

        def firehouse; end
end
