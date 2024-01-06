# https://dev.37signals.com/good-concerns/

module Account::Closable
  def terminate
    purge_or_incinerate if terminable?
  end

  private
    def purge_or_incinerate
      eligible_for_purge? ? purge : incinerate
    end

    def purge
      Account::Closing::Purging.new(self).run
    end

    def incinerate
      Account::Closing::Incineration.new(self).run
    end
end