class Person::RemoveInaccessibleRecordsJob < ApplicationJob
  queue_as :background

  after_reader :person, :bucket

  def perform(person, bucket)
    @person, @bucket = person, bucket

    unless person.buckets.include?(bucket)
      remove_inaccessible_records
    end
  end

  private

    def remove_inaccessible_records
      Person::UnsubscribeFromBucketJob.perform_now(person, bucket)

      if person.user
        remove_inaccessible_readings
        remove_inaccessible_bookmarkings
      end

      remove_inaccessible_email_dropboxes
    end

    def remove_inaccessible_readings
      person.user.readings.for_bucket(bucket).find_each(batch_size: 100, &:destroy)
    end

    def remove_inaccessible_bookmarkings
      person.user.bookmarkings.for_bucket(bucket).find_each(batch_size: 100, &:destroy)
    end

    def remove_inaccessible_email_dropboxes
      person.user.email_dropboxes.for_bucket(bucket).find_each(batch_size: 100, &:destroy)
    end
end
