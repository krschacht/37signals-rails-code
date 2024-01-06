# https://dev.37signals.com/active-record-nice-and-blended/

class Reports::Users::ProgressController < ApplicationController
  def show
    @events = Timeline::Aggregator.new(Current.person, filter: current_page_by_creator_filter).events
  end
end
