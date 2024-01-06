# https://dev.37signals.com/vanilla-rails-is-plenty/

module Recording::Copyable
  extend ActiveSupport::Concern

  included do
    has_many :copies, foreign_key: :source_recording_id
  end

  def copy_to(bucket, parent: nil)
    copies.create! destination_bucket: bucket, destination_parent: parent
  end
end