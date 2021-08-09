class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    add_flash_types :success, :info, :warning, :danger



    private

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :username, :name])
          devise_parameter_sanitizer.permit(:sign_in,keys:[:email, :username])
        end
end
