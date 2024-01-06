# https://dev.37signals.com/vanilla-rails-is-plenty/

class Project::InvitationToken::Signup
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :name, :email_address, :password, :time_zone_name, :account

  validate :validate_email_address, :validate_identity, :validate_account_within_user_limits

  def create_identity!
    # ...
  end
end
