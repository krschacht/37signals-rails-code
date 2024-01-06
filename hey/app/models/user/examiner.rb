# https://dev.37signals.com/domain-driven-boldness/
# https://dev.37signals.com/good-concerns/

module User::Examiner
  extend ActiveSupport::Concern

  included do
    has_many :clearances, foreign_key: "examiner_id", class_name: "Clearance", dependent: :destroy
  end

  def approve(contacts)
    # ...
  end

  def approve(contacts)
    # ...
  end

  def has_approved?(contact)
    # ...
  end

  def has_denied?(contact)
    # ...
  end
end