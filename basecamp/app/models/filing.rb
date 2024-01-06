# https://dev.37signals.com/vanilla-rails-is-plenty/

class Filing < ApplicationRecord
  after_create_commit :process_later, unless: :completed?

  def process_later
    FilingJob.perform_later self
  end

  def process
    # ...
    file_recording
    # ...
  end
end