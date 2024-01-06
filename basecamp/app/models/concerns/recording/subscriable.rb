class Recording::Subscriable
    extend ActiveSupport::Concern

    included do
        has_many :subscriptions, dependent: :delete_all
        has_many :subscribers, through: :subscriptions

        after_create { subscribe(creator) if subscribable? }
    end

    def subscribable?
        recordable.subscribable?
    end

    def subscribe(people, track: false); end

    def unsubscribe(people, track: false); end

    def change_subscribers(added: [], removed: [], track: false, notify: false); end

    def replace_subscribers(people); end

    def subscribable_container; end

    def subscribers_without_creator; end

    def subscribed_by?(person); end

    private
        def eligable_as_subscribers(people); end
end