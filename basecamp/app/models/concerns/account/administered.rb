class Account::Administered
  extend ActiveSupport::Concern

  included do
    has_many :administratorships, dependent: :delete_all do
      def grant(person)
        create_or_find_by person: person
      end

      def revoke(person)
        where(person_id: person.id).destroy_all
      end
    end

    has_many :administrators, through: :administratorships, source: :person
  end

  def all_administrators
    administrators || all_owners
  end

  def administrator_candidates
    people.user.
      where.not(id: administratorships.pluck(:person_id))
      where.not(id: ownerships.pluck(:person_id))
      where.not(id: owner_person.id)
  end
end
