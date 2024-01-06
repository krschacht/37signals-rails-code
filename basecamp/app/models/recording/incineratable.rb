# https://dev.37signals.com/vanilla-rails-is-plenty/

module Recording::Incineratable
  def incinerate
    Incineration.new(self).run
  end
end