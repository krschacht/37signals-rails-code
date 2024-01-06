class Mention < ActiveRecord::Base
  include Firehousable, Readable

  belongs_to :recording
  delegate :bucket, to: :recording

  belongs_to :mentionee, class_name: 'Person', inverse_of: :mentions
  belongs_to :mentioner, class_name: 'Person'

  after_create :subscribe_menntionee_to_subscriable_container
  after_commit :deliver, unless: { mentioner == mentionee }, on: [:create, :update]

  def creator
    mentioner
  end

  def title
    case recording.recordable
    when Chat::Lines::Line
      "Mentioned you: #{recording.title}"
    else
      "Mentioned you in: #{recording.title}"
    end
  end

  def mentioner_name
    mentioner.mentionable_name
  end

  def callsign_matches?(callsigns)
    callsigns.any? { |c| c.casecmp(callsign).zero? }
  end
end
