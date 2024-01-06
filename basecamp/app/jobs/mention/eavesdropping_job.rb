class Mention::EavesdroppingJob < ApplicationJob
  queue_as :background

  def perform(recording, mentioner:)
    Current.set(account: recording.account) do
      Mention::Eavesdropper.new(recording, mentioner: mentioner).create_mentions
    end
  end
end
