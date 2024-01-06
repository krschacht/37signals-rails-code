# https://dev.37signals.com/active-record-nice-and-blended/

module Contact::Designatable
  extend ActiveSupport::Concern

  included do
    has_many :designations, class_name: "Box::Designation", dependent: :destroy
  end

  def designate_to(box)
    if box.imbox?
      # Skip designating to Imbox since it’s the default.
      undesignate_from(box.identity.boxes)
    else
      update_or_create_designation_to(box)
    end
  end

  def undesignate_from(box)
    designations.destroy_by box: box
  end

  def designation_within(boxes)
    designations.find_by box: boxes
  end

  def designated?(by:)
    designation_within(by.boxes).present?
  end

  private
    def update_or_create_designation_to(box)
      if designation = designation_within(box.identity.boxes)
        designation.update!(box: box)
      else
        designations.create!(box: box)
      end
    end
end
