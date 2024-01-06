# https://dev.37signals.com/domain-driven-boldness/
module Person::Tombstonable
  # ...

  def decease
    case
    when deceasable?
      erect_tombstone
      remove_administratorships
      remove_accesses_later
      self
    when deceased?
      nil
    else
      raise ArgumentError, "an account owner cannot be removed. You must transfer ownership first"
    end
  end
end