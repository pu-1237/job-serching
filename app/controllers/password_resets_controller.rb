class PasswordResetsController < ApplicationController

  before_action :get_user,   only: [:edit, :update]
  # before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest 
      @user.send_password_reset_email
      redirect_to sent_password_resets_path
    else
      flash.now[:danger] = "存在しないメールアドレスです"
      render 'new'
    end
  end

  def update
    #新しいパスワードが空文字になっていないかを確認する。
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    #新しいパスワードが正しければ、更新する。
    elsif @user.update(user_params)
      redirect_to :login
      flash[:success] = "パスワードが更新されました"
    #無効なパスワードであれば失敗させる。
    else
      render 'edit'
    end
  end

  def use_before_action?
    false
  end

  private

    def get_user
      @user = User.find_by(email: params[:email])
    end

    #取得したユーザーが有効なユーザーかどうかを確認する
    #def valid_user
    #  unless (@user && @user.activated? &&
    #    @user.authenticated?(:reset, params[:id]))
    #    redirect_to root_url
    #  end
    #end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定の有効期限が切れてます"
        redirect_to new_password_reset_url
      end
    end
end
