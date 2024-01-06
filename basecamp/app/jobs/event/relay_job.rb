# https://dev.37signals.com/fractal-journeys/

class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end