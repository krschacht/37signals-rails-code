class Document < ActiveRecord::Base
    include Recordable, RichText, PlainText

    rich_text_attribute :content
    plain_text_attribute :title

    def title
        super.presence || 'Untitled'
    end

    def auto_position?
        true
    end

    def subscribable?
        true
    end

    def exportable?
        true
    end

    def exportable_filename
        ActiveStorage::Filename.new("#{title.strip}.html")
    end
end
