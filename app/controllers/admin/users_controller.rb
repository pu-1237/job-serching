class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @q = User.all.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.full_name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.full_name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.full_name}」を削除しました。"

  end

  def payment
    
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
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building,   
      :station,
      :admin,
      :password,
      :password_confirmation,
      :new_profile_picture
    )
  end
end