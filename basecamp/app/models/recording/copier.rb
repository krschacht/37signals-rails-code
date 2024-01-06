# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class Recording::Copier
  # ...
  private
     def copy_recording
      Event.suppress do
       @destination_recording = destination_bucket.record(source_recording.recordable, parent: destination_parent, **copyable_attributes)
      end
     end
end