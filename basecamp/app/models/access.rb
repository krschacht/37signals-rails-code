class Access < ActiveRecord::Base

  include Firehousable

  belongs_to :bucket, touch: :access_updated_at
  belongs_to :person

  after_destroy: :reconnect_user
  after_destroy_commit: :remove_inaccessible_records

  private
    GRACE_PERIOD_FOR_REMOVING_INACCESSIBLE_RECORDS = 30.seconds

    def remove_inaccessible_records
      unless person.destroyed? || bucket.destroyed?
        Person::RemoveInaccessibleRecordsJob.set(wait: GRACE_PERIOD_FOR_REMOVING_INACCESSIBLE_RECORDS).perform_later(person, bucket)
    end

    def reconnect_user
      ActionCable.server.disconnect(current_user: person.user) if person.user?
    end
end
