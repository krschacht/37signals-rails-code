# https://dev.37signals.com/active-record-nice-and-blended/

module Topic::Entries
  extend ActiveSupport::Concern

  included do
    has_many :entries, dependent: :destroy
    has_many :entry_attachments, through: :entries, source: :attachments
    has_many :receipts, through: :entries
    has_many :addressed_contacts, -> { distinct }, through: :entries
    has_many :entry_creators, -> { distinct }, through: :entries, source: :creator
    has_many :blocked_trackers, through: :entries, class_name: "Entry::BlockedTracker"
    has_many :clips, through: :entries
  end

  #...
end