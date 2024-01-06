# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class ProjectRecorder
  def initialize(account)
     @account = account
  end

  def record(params, creator, request)
     Project.transaction do
      @account.projects.create!(params, request).tap do |project|
       project.bucket.events.create! creator: creator, action: :create, request: Event::Request.create_from(request)
      end
     end
  end
end