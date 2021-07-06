class RegistrationsController < ApplicationController

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
    
        if @user.save
            session[:user_id] = @user.id
            redirect_to register_path
        else
            render :new
        end
    end

    def use_before_action?
        false
    end

    private

    def user_params
        params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :number, :postal_code, :address, :station, :password, :password_confirmation, :new_profile_picture)
    end
end