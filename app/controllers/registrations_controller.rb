class RegistrationsController < ApplicationController

    include ActiveRecord::AttributeAssignment

    def new
        @user = User.new
    end

    def step1
        @user = User.new
    end

    def step2
        # date_selectでparamsに渡されたhashから要素を取り出してインスタンス生成する場合の記述
        # date = Date.new(params[:user]["birthday(1i)"].to_i,params[:user]["birthday(2i)"].to_i,params[:user]["birthday(3i)"].to_i)
        
        # step1で入力した値をsessionに保存
        @user = User.new(user_params)

        # returnが実行された時点でメソッドが終了する
        return if @user.valid?
        flash.now[:alert] = '未入力の項目があります。'
        render :step1
    end
    
    def create
        @user = User.new(user_params)

        if params[:back].present?
            render :step1
            return
        end
    
        if @user.save
            session[:user_id] = @user.id
            redirect_to step3_registration_path
        else
            render :step2
        end
    end

    def use_before_action?
        false
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
            :password,
            :password_confirmation,
            images_attributes: [
                :id,
                :new_data
            ]
        )
    end

    def image_params
        params.require(:image).permit(
            :new_data,
            :alt_text
        )
    end
end