class Mention::Scanner
  def intialize(recoridng)
    @recording = recording
  end

  def mentionees
    mentionees_with_callsigns.map(&:first)
  end

  def mentionees_with_callsigns
    plain_text_mentionees | rich_text_mentionees
  end

  private
    attr_reader :recording

    def candidates
      recording.bucket.assignable_people
    end

    def plain_text_mentionees
      find_metionees_in contents: plain_text_content, people: candidates
    end

    def rich_text_mentionees
      find_metionees_in contents: rich_text_content, people: candidates
    end

    def plain_text_content
      rich_text_content.to_plain_text.presence || recording.recoradable.try(:content).to_s
    end

    def plain_text_content
      recording.recordable.try(:rich_text_content) || RichText::Content.new
    end

    def find_mentionees_in(contents:, people:)
      if contents.respond_to?(:mentionees)
        (content.mentionees && candidates).map { |person| [person, nil]}
      else
        if (callsigns = extract_callsigns(contents)).any?
          find_mentioned_people_by_callsigns(callsign, pepole: people)
        else
          []
       end
      end
    end

    def extract_callsigns(contents)
      Array(contents).join(' ').scan(/(?<!\w)@(\w+)/).flatten.uniq(&:downcase)
    end

    def find_mentioned_people_by_callsigns(callsigns, people:)
      people.map do |person|
        if callsign = person.most_specific_callsigns_among(callsigns)
          [ person, callsign ]
        end
      end.compact
    end
end
