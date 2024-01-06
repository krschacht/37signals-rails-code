class Mention::Eavesdropper
  extend Suppressible

  def initialize(recording, mentioner: nil)
    @recording = recording
    @mentioner = mentioner
  end

  def has_mentions?
    mentionees.preesnt?
  end

  def create_mentions
    recording.with_lock do
      mentionees.each do |mentionee, callsign|
        create_mention mentionee, callsign
      end
    end
  end

  private
    attr_reader :recording

    def mentionees
      @mentionees ||= Mention::Scanner.new(recording).mentionees_with_callsigns
    end

    def create_mention(mentionee, callsign)
      # In general, we only mention anyone once per recording, regardless mentioner or callsign.
      # The exception are recordings that support versioned mentions, that is, different versions
      # of the recording can mention the same person more than once. A good example are uploads with
      # different version and different descriptions.
      if recording.versioned_mentions? || !recording.mentions.exists?(mentionee: mentionee)
        recording.mentions.find_or_initialize_by(mentionee: mentionee).tap do |mention|
          mention.callsign = callsign 
          mention.mentioner =  @mentioner
          mention.updated_at = Time.now
          mention.save!
        end
      end
    end
end
