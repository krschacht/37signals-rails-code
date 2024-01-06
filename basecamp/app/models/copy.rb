# https://dev.37signals.com/vanilla-rails-is-plenty/

class Copy < Filing
  private
    def file_recording
      Current.set(person: creator) do
        Recording::Copier.new(
          source_recording: source_recording,
          destination_bucket: destination_bucket,
          destination_parent: destination_parent,
          filing: self
        ).copy
      end
    end
end