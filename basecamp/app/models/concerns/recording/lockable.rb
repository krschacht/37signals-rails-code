class Recording::Lockable
    extend ActiveSupport::Concern

    included do
        has_one :lock, dependent: :destroy
    end

    def lock_by(user)
        transaction do
            create_lock! user: user unless locked?
        end
    end

    def locked?
        lock.present?
    end

    def locked_by?(user)
        locked? && lock.user == user
    end

    def unlock
        update! lock: nil
    end
end