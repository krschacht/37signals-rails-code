# https://dev.37signals.com/vanilla-rails-is-plenty/

class Projects::InvitationTokens::SignupsController < Projects::InvitationTokens::BaseController
  def create
    @signup = Project::InvitationToken::Signup.new(signup_params)

    if @signup.valid?
      claim_invitation @signup.create_identity!
    else
      redirect_to invitation_token_join_url(@invitation_token), alert: @signup.errors.first.message
    end
  end
end