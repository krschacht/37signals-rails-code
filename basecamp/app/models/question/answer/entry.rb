class Question::Answer::Entry
  attr_reader :question_recording, :bucket

  class << self
    def for(reminder)
      new reminder.recording, person: reminder.person, group_on: reminder.localized_remind_at.to_date
    end
  end

  def initialize(question_recording, person:, group_on:)
    @question_recording = question_recording
    @bucket = @question_recording.bucket
  end
end
