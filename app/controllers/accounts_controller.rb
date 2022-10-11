class AccountsController < ApplicationController

def index
    @user = current_user
end
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

def entries
    # クエリストリングをTimeオブジェクトに変換、ない場合は現在の時刻を取得
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    # 取得したTimeオブジェクトでデータを取得
    events_month = Event.where(start: @month.all_month)
    # current_userの申し込んだイベントを配列に格納する
    events = events_month.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
    # 配列に対してページネイトする
    @events = Kaminari.paginate_array(events).page(params[:page]).per(5)
end

# 給与明細
def payments
    @events = Event.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
end

# 月ごとの給与明細
def list
    # current_userの申し込んだイベントを配列に格納する
    events = Event.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
    @events = events.find_all{ |event| event.start.year.to_s == params[:year] && sprintf('%02d', event.start.month)== params[:month] }
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
