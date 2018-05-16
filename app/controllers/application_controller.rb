class ApplicationController < ActionController::Base

    #TODO bug here?
    # Devise override
    def after_sign_in_path_for(resource)
        users_path
    end

    # Devise override
    def after_sign_out_path_for(resource)
        new_user_session_path
    end
end