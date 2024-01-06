class Recordable::Incineration
  def initialize(recording, recordable)
    @recording = recording
    @recordable = recordable
  end

  def run
    @recordable.destroy if possible?
  end

  def possible?
    !referenced_currently_by_other_recordings? && !referenced_currently_by_other_events?
  end

  private
    def referenced_currently_by_other_recordings?
      @recordable.recordings.where.not(id: @recording).exists?
    end

    def referenced_currently_by_other_events?
      @recordable.events.where.not(recording: @recording).exists?
    end
end
