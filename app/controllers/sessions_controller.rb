class SessionsController < ApplicationController
  skip_before_action :login_required

  def top
  end
  
  def register
  end

  def new
    if params[:locale] == :en
      @submit = 'Login'
    else
      @submit = 'ログインする'
    end
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to events_path
    else
      redirect_to :login, alert: 'ログインに失敗しました。' # application.html.slimにalert表示を書き加えた
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end