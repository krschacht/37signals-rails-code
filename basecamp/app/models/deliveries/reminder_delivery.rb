class Deliveries::ReminderDelivery < Deliveries::Delivery
  delegate :recording, to: :deliverable

  protected
    def deliver?
      super && !question_answered?
    end

    def notification
      ReminderNotifier.reminder(deliverable)
    end

    def aggergate_after
      5.minutes
    end

    def question_answered?
      recording.question? && Question::Answer::Entry.for(deliverable).answer_recording
    end
end
