class RegistrationStepsController < ApplicationController
    include Wicked::Wizard
    steps :second

    def show
        @user = current_user
        render_wizard
    end

    def update
        @user = current_user
        @user.update(user_params)
        render_wizard @user
    end

    private

    def finish_wizard_path
        users_path(current_user)
    end

    def user_params
        params.require(:user).permit(
            :last_name,
            :first_name,
            :last_name_kana,
            :first_name_kana,
            :gender,
            :birthday,
            :email,
            :number,
            :postcode,
            :prefecture_code,
            :address_city,
            :address_street,
            :address_building,
            :station,
            :password,
            :password_confirmation,
            :new_profile_picture
        )
    end
end
