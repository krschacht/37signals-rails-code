# https://dev.37signals.com/active-record-nice-and-blended/

class Timeline::Aggregator
  def initialize(person, filter: nil)
    @person = person
    @filter = filter
  end

  def events
    Event.where(id: event_ids).preload(:recording).reverse_chronologically
  end

  private
    def event_ids
      event_ids_via_optimized_query(1.week.ago) || event_ids_via_optimized_query(3.months.ago) || event_ids_via_regular_query
    end

    # Fetching the most recent recordings optimizes the query enormously for large sets of recordings
    def event_ids_via_optimized_query(created_since)
      limit = extract_limit
      event_ids = filtered_ordered_recordings.where("recordings.created_at >= ?", created_since).pluck("relays.event_id")
      event_ids if event_ids.length >= limit
    end

    def event_ids_via_regular_query
      filtered_ordered_recordings.pluck("relays.event_id")
    end

    # ...
end
