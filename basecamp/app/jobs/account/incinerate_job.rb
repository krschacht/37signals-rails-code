class Account::IncinerateJob < ApplicationJob
  queue_as :incineration
  retry_on Recording::Incineratable::Incineration::RecordableNeedsIncineration

  def self.schedule(account)
    set(wait: Account::Incineratable::INCINERATABLE_AFTER).perform_later(account)
  end

  def perform(account)
    SignalId::Database.on_master { account.incinerate }
  end
end
