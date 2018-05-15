class ApplicationController < ActionController::Base

    # Devise override
    def after_sign_in_path_for(resource)
        edit_user_registration_path
    end

    # Devise override
    def after_sign_out_path_for(resource)
        new_user_session_path
    end
end
