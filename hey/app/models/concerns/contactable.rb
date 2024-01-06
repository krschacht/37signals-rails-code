# https://dev.37signals.com/active-record-nice-and-blended/

module Contactable
  extend ActiveSupport::Concern

  TYPES = %w[ User Extenzion Alias Person Service Tombstone ]

  included do
    has_one :contact, as: :contactable, inverse_of: :contactable, touch: true
    belongs_to :account, default: -> { contact&.account }
  end
end