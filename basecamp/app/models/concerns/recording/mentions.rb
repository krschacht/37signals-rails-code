class Recording::Mentions
  extend ActiveSupport::Concern

  included do
    has_many :mentions, dependent: :destroy
    after_save :remember_to_eavesdrop
    after_commit :eavesdrop_for_mentions, on: %i[ create update], if: :eavesdropping?
  end

  VERSIONED_MENTION_TYPES = %w( Upload )

  def versioned_mentions?
  end

  private
    def remember_to_eavesdrop
      @eavesdropping = active_or_archived_recordable_changed? || draft_became_active?
    end

  def active_or_archived_recordable_changed?
    (active? || archived?) && saved_change_to_recordable_id?
  end

  def eavesdropping?
    @eavesdropping && !Mention::Eavesdropper.suppressed? && has_mentions?
  end

  def eavesdrop_for_mentions
    Mention::EavesdroppingJob.perform_later self, mentioner: Current.person
  end

  def has_mention?
    Mention::Eavesdropper.new(self).has_mentions?
  end
end
