class AccountsController < ApplicationController

def show
    @user = current_user
end

def edit
    @user = current_user
end

def update
    @user = current_user

    if @user.update(user_params)
        redirect_to account_path, notice: "アカウント情報を更新しました。"
    else
        render :edit
    end
end

private

def user_params
    params.require(:user).permit(:email, :new_profile_picture, :password, :password_conformation)
end

end
