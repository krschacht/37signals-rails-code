# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class ApplicationController < ActionController::Base
  include SetCurrentRequestDetails
end
