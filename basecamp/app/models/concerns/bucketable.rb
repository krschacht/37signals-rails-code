# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

module Bucketable
  extend ActiveSupport::Concern

  included do
     after_create { create_bucket! account: account unless bucket.present? }
  end
end
