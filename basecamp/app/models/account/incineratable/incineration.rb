class Account::Incineratable::Incineration
  def initialize(account)
    @account = account
  end

  def run
    if possible?
      incinerate_buckets
      incinerate_account
      incinerate_signal_account
    end
  end

  def possible?
    canceled? || due?
  end

  private
    def due?
      @account.canceled_at < Account::Incineratable::INCINERATABLE_AFTER.ago.end_of_day
    end

    def canceled?
      @account.canceled? && !@account.active
    end

    def incinerate_buckets
      @account.buckets.each do |bucket|
        Bucket::Incineratable::Incineration.new(bucket).run
      end
    end

    def incinerate_signal_account
      @account.signal_account.destroy if !Account.exists?(@account.id)
    end

    def incinerate_account
      @account.destroy
    end
end
