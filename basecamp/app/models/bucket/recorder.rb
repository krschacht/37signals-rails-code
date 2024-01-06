# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class Bucket::Recorder
  def initialize(bucket)
     @bucket = bucket
  end

  def record(recordable, children: nil, parent: nil, position: nil, scheduled_posting_at: nil, **options)
     # ...
  end
end
