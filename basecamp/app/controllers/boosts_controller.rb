# https://dev.37signals.com/vanilla-rails-is-plenty/

class BoostsController < ApplicationController

  def create
    @boost = @boostable.boosts.create!(content: params[:boost][:content])
  end

  # ...
end