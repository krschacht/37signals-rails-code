class User::Notifications::Granularity
    attr_reader :notifications
    delegate :user, :redis, to: :notifications

    OPTIONS = %w( pings_and_mentions everything )
    DEFAULT = 'everything'

    delegate :pings_and_mentions?, :everything?, to: :choice
    
    def initialize(notifications)
        @notifications = notifications
    end

    def choice=(option)
        redis.set granularity_key, option.presence_in(OPTIONS) || DEFAULT
    end

    def allows?(deliverable)
        case
        when everything? 
            true
        when pings_and_mentions?
            deliverable_is_a?(Mention) || ping?(deliverable)
        end
    end

    private
        def choice
            @choice ||= (redis.get(granularity) || DEFAULT).inquiry
        end

        def granularity_key
            "#{notifications.send(:user_key)}/granularity"
        end

        def ping?(deliverable)
        end

        def chat_line_event?(deliverable)
        end
end