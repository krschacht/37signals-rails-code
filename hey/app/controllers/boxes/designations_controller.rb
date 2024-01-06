# https://dev.37signals.com/vanilla-rails-is-plenty/

class Boxes::DesignationsController < ApplicationController
  include BoxScoped

  before_action :set_contact, only: :create

  def create
    @contact.designate_to(@box)

    respond_to do |format|
      format.html { refresh_or_redirect_back_or_to @contact, notice: "Changes saved. This might take a few minutes to complete." }
      format.json { head :created }
    end
  end

  # ...
end
