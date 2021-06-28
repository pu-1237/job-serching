class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :login_required, except: [:top], if: :use_before_action?
    before_action :set_locale

    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
        redirect_to login_path unless current_user
    end

    def require_admin
        redirect_to root_path unless current_user.admin?
    end

    # アプリの設定へ反映する
    def set_locale
        I18n.locale = locale
    end


    # 特定のコントローラではbefore_actionを使用しない判定に用いる
    def use_before_action?
        true
    end

end
