class Recording < ActiveSupport::Base
    include Tree, Status

    include Applaudable, Attachable, Bookmarkable, Cancelable, Categoriazble, Colored, Copyable, Creators,
            Dockable, Firehouseable, Incineratable, Indexed, Invalidation, Lockable, Mentions, Movable, Notify,
            OrderedChildren, Positioned, Preloadable, Printable, Publishing, Readable, Recordables, Remindable, Replyable,
            Threadable

    include Eventable
    include Assignable
    include Completable

    belongs_to :bucket, touch: true
    belongs_to :creator, class_name: "Person", default: -> { Current.person }

    scope :reverse_chronologically, -> { order 'recordings.created_at desc, recordings.id desc' }

    delegate :account, to: :bucket

    # Duck type with objects that have a recording. E.g. applaudable.recording when applaudable is a Recording0
    def recording
        self
    end
end