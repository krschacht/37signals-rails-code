class My::Notifications::SettingsController < ApplicationController
    after_action :track_update_for_customer, only: :update

    def show
    end

    def edit; end

    def update
        update_platforms
        update_presentation
        update_granularity
        update_schedule
        update_bundle

        redirect_to edit_my_notifications_settings_url, notice: 'Settings save!'
    end

    private
        def default_schedule; end

        def update_platforms; end

        def update_presentation; end

        def update_granularity
            Current.user.notifications.granularity.choice = params[:granularity]
        end

        def update_schedule; end
end