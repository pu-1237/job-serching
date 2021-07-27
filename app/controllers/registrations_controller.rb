class RegistrationsController < ApplicationController

    include ActiveRecord::AttributeAssignment

    def new
        @user = User.new
    end

    def step1
        @user = User.new
    end

    def step2
        # date_selectでparamsに渡されたhashから要素を取り出してインスタンス生成
        date = Date.new(params[:user]["birthday(1i)"].to_i,params[:user]["birthday(2i)"].to_i,params[:user]["birthday(3i)"].to_i)
        # step1で入力した値をsessionに保存
        session[:email] = user_params[:email]
        session[:password] = user_params[:password]
        session[:password_confirmation] = user_params[:password_confirmation]
        session[:last_name] = user_params[:last_name]
        session[:first_name] = user_params[:first_name]
        session[:last_name_kana] = user_params[:last_name_kana]
        session[:first_name_kana] = user_params[:first_name_kana]
        session[:gender] = user_params[:gender]
        session[:birthday] = date
        session[:number] = user_params[:number]
        session[:postcode] = user_params[:postcode]
        session[:prefecture_code] = user_params[:prefecture_code]
        session[:address_city] = user_params[:address_city]
        session[:address_street] = user_params[:address_street]
        session[:station] = user_params[:station]
        @user = User.new(
            email: session[:email],
            password: session[:password],
            password_confirmation: session[:password_confirmation],
            last_name: session[:last_name],
            first_name: session[:first_name],
            last_name_kana: session[:last_name_kana],
            first_name_kana: session[:first_name_kana],
            gender: session[:gender],
            birthday: session[:birthday],
            number: session[:number],
            postcode: session[:postcode],
            prefecture_code: session[:prefecture_code],
            address_city: session[:address_city],
            address_street: session[:address_street],
            station: session[:station],
        )
    end
    
    def create
        @user = User.new(user_params
        )

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