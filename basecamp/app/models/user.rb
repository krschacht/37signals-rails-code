class User < ActiveRecord::Base
    include Personable
    include SinglaeUser

    include Applause, Appearant, Announce, Assigner, Bookmarker, Devicee,
            Drafter, Locker, Notifiee, Profiled, Reader, Reportee

    def attributes_for_person
    end

    def enroll(enrolle_params)
    end

    def settings
    end
end