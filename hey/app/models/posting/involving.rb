# https://dev.37signals.com/active-record-nice-and-blended/

module Posting::Involving
  extend ActiveSupport::Concern

  DEFAULT_INVOLVEMENTS_JOIN = "INNER JOIN `involvements` USE INDEX(index_involvements_on_contact_id_and_topic_id) ON `involvements`.`topic_id` = `postings`.`postable_id`"
  OPTIMIZED_FOR_USER_FILTERING_INVOLVEMENTS_JOIN = "STRAIGHT_JOIN `involvements` USE INDEX(index_involvements_on_account_id_and_topic_id_and_contact_id) ON `involvements`.`topic_id` = `postings`.`postable_id`"

  included do
    scope :involving, ->(contacts, involvements_join: DEFAULT_INVOLVEMENTS_JOIN) do
      where(postable_type: "Topic")
        .joins(involvements_join)
        .where(involvements: { contact_id: Array(contacts).map(&:id) })
        .distinct
    end

    scope :involving_optimized_for_user_filtering, ->(contacts) do
      # STRAIGHT_JOIN ensures that MySQL reads topics before involvements
      involving(contacts, involvements_join: OPTIMIZED_FOR_USER_FILTERING_INVOLVEMENTS_JOIN)
        .use_index(:index_postings_on_user_id_and_postable_and_active_at)
        .joins(:user)
        .where("`users`.`account_id` = `involvements`.`account_id`")
        .select(:id, :active_at)
    end
  end
end
