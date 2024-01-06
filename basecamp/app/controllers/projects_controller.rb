# https://dev.37signals.com/globals-callbacks-and-other-sacrileges/

class ProjectsController < ApplicationController
  def create
     ProjectRecorder.new(account).record(create_project_params, Current.person, request)

     @template ? create_from_template : create_without_template
  end

  private
     def create_without_template
      @project = Current.account.projects.create! create_project_params

      # ...
     end
end
