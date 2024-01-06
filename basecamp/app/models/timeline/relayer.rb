# https://dev.37signals.com/fractal-journeys/

class Timeline::Relayer
  def initialize(event)
    @event = event
  end

  def relay
    if relaying?
      record
      broadcast
    end
  end

  private
    attr_reader :event
    delegate :bucket, to: :event

    def record
      bucket.record Relay.new(event: event), parent: timeline_recording, visible_to_clients: visible_to_clients?
    end

    def broadcast
      TimelineChannel.broadcast_event(event, to: recipients)
    end
end