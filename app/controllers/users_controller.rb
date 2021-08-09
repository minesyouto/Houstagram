class UsersController < ApplicationController
    def after_sign_in_path_for(resource)
        redirect_to root
    end
end
