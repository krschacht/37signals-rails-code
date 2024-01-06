# video + https://dev.37signals.com/fractal-journeys/

class Event < ActiveRecord::Base
  include Relaying
  include Requested

  belongs_to :recording, required: false
  belongs_to :bucket
  belongs_to :creator, class_name: 'Person'

  has_one :detail, dependent: :delete, required: true

  validates_presence_of :action

  before_create :set_kind

  scope :chronologically, -> { order 'created_at asc, id desc' }
  scope :reverse_chronologically, -> { order 'created_at desc, id desc' }

  include Notifiable, Relaying, RecordableGid, Requested, Summarizable, Categorized, Appluadable
  include Firehouseable

  def action; end
  def kind; end

  def details
    @details ||= detail.particulars.except(*excluded_details)
  end

  private
    def set_kind; end
    def container_name; end
    def set_kind; end
    def set_kind; end
end
