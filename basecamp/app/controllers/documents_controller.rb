class DocumentsController < ApplicationController
  include SetRecordable, ValutScoped, BucketScoped
  include LockRecording
  include Subscribers, RecordingStatusParam

  def index; end

  def show; end

  def new; end

  def create
    @recording = @bucket.record new_docuemnt, parnet: @vault, status: status_param, subscribers: find_subscribers

    respond_to do |format|
      format.any(:html, :js) { redirect_to edit_subscriptions_or_recordabl_url(@recording)}
      format.json { render :show, status: :created }
    end
  end

  def edit
  end

  def update
  end

  private
    def new_docuemnt
  Document.new params.require(:document).permit(:title, :content)
    end
end
