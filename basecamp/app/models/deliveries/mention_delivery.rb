class Deliveries::MentionDelivery < Deliveries::Delivery
  protected
    def notification
      MentionsNotifier.mention(deliverable, recipient)
    end

    def mail
      MentionsMailer.mention(deliverable)
    end
end
