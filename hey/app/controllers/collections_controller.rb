# https://dev.37signals.com/active-record-nice-and-blended/

class CollectionsController < ApplicationController
  def show
    @topics = @collection.topics.active.accessible_to(Acting.contact)
    # ...
  end
end