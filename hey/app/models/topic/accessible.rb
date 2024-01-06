# https://dev.37signals.com/active-record-nice-and-blended/

module Topic::Accessible
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :destroy
    scope :accessible_to, ->(contact) { not_deleted.joins(:accesses).where accesses: { contact: contact } }
  end

  # ...
end
