class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :login_required, except: [:top], if: :use_before_action?
    before_action :set_locale

    class Forbidden < StandardError; end

    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end

    private

    def rescue_bad_request(exception)
        render "errors/bad_request", status: 403, layout: "error",
        formats: [:html]
    end

    def rescue_not_found(exception)
        render "errors/not_found", status: 404, layout: "error",
        formats: [:html]
    end

    def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error",
        formats: [:html]
    end

    def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error",
        formats: [:html]
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
        redirect_to login_path unless current_user
    end

    def require_admin
        raise Forbidden unless current_user.admin?
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
