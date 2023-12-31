class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
        before_action :get_date
        def get_date
            @now = Time.now.in_time_zone("Tokyo")
            @abs_this_year = @now.year
            @abs_this_month = @now.month

            @day = @now.day
            @hour = @now.hour
            @minute = @now.min
            @zone = @now.zone
        end
        
        def after_sign_in_path_for(resource)
            index_path(year: @abs_this_year, month: @abs_this_month)
        end

        def after_sign_out_path_for(resource)
            root_path
        end

        protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
            devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
        end
end
