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
        render :show
    end
end

private

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
        :address,
        :prefecture_name,
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
