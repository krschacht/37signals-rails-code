# https://dev.37signals.com/active-record-nice-and-blended/

module Contact::Contactables
  extend ActiveSupport::Concern

  included do
    delegated_type :contactable, types: Contactable::TYPES, inverse_of: :contact, dependent: :destroy
  end
end