# https://dev.37signals.com/domain-driven-boldness/

module Contact::Petitioner
  extend ActiveSupport::Concern

  included do
    has_many :clearance_petitions, foreign_key: "petitioner_id", class_name: "Clearance", dependent: :destroy
  end

  # ...
end