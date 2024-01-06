class Recording::Incineratable::Incineration
  class RecordableNeedsIncineration < StandardError; end

  def initialize(recording)
    @recording = recording
  end

  def run
    return unless possible?

    incinerate_children(@recording)
    incinerate_depdenents(@recording)
  end

  def possible?
    incineratable_via_self? || incineratable_via_bucket?
  end

  private
    def incineratable_via_self?
      @recording.deleted? && due? && !incineratable_via_ancestor?
    end

    def incineratable_via_bucket?
      incineratable_bucket? && !has_incineratable_ancestor?
    end

    def incineratable_bucket?
      Bucket::Incineratable::Incineration.new(@recording.bucket).possible?
    end

    def due?
      @recording.updated_at < Recording::Incineratable::INCINERATABLE_AFTER.ago.end_of_day
    end

    def incinerate_children(recording)
      @recording.descendants.each do |child|
        incinerate_depdenents(child)
      end
    end
    
    def incinerate_depdenents(recording)
      Bucket.no_touching do
        Recording.no_touching do
          incinerate_recordables(recording)

          incinerate_recording(recording)
        end
      end
    end

    def incinerate_recording(recording)
      if recordable_incinerated?(recording)
        recording.destroy
      else
        rerun_incineration
      end
    end

    def incinerate_recordables(recording); end

    def incinerate_recordable(recording, recordable)
      Recordable::Incineration.new(recording, recordable).run
    end

    def recordable_incinerated?(recording); end


    # Recordables can be shared between recordings and may enconter a
  # race condition when bening incinerated. Retry incineration in this case.
    def rerun_incineration
      raise RecordableNeedsIncineration.new("Recording's recordable was no incinerated. Retry incineration.")
    end
end
