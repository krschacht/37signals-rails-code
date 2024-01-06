class Tombstone < ActiveRecord::Base
    include Personable

    serialize :details

    def self.for(deceased)
        
    end

    # Define query methods for the original personable type: was_user?, was_client?
    Personable::TYPES.each do |type|
    end
end
