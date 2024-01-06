# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

module Event::Requested
  extend ActiveSupport::Concern

  included do
     has_one :request, dependent: :delete, required: true
     before_validation :build_request, on: :create
  end
end