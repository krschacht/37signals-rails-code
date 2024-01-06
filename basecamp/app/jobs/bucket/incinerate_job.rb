class Bucket::IncinerateJob < ApplicationJob
  queue_as :incineration
  retry_on Recording::Incineratable::Incineration::RecordableNeedsIncineration

  def self.schedule(bucket)
    set(wait: Bucket::Incineratable::INCINERATION_AFTER).perform_later(bucket)
  end

  def perform(bucket)
      bucket.incinerate
  end
end
