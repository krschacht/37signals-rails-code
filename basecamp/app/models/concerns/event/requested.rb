class Event::Requested
  extend ActiveSupport::Concern

  included do
    has_one :request, dependent: :delete, required: true
    before_validation :build_request, on: :create
  end
end
