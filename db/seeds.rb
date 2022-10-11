# ユーザー登録
User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.last_name = '管理者'
    user.first_name = '太郎'
    user.last_name_kana = 'カンリシャ'
    user.first_name_kana = 'タロウ'
    user.number = '09000000001'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = true
end
User.find_or_create_by!(email: 'user_yamada@example.com') do |user|
    user.last_name = '山田'
    user.first_name = '次郎'
    user.last_name_kana = 'ヤマダ'
    user.first_name_kana = 'ジロウ'
    user.number = '09000000002'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
end
User.find_or_create_by!(email: 'user_tanaka@example.com') do |user|
    user.last_name = '田中'
    user.first_name = '三郎'
    user.last_name_kana = 'タナカ'
    user.first_name_kana = 'サブロウ'
    user.number = '09000000003'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
end
User.find_or_create_by!(email: 'user_suzuki@example.com') do |user|
    user.last_name = '鈴木'
    user.first_name = '四郎'
    user.last_name_kana = 'スズキ'
    user.first_name_kana = 'シロウ'
    user.number = '09000000004'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
end
User.find_or_create_by!(email: 'user_satou@example.com') do |user|
    user.last_name = '佐藤'
    user.first_name = '五郎'
    user.last_name_kana = 'サトウ'
    user.first_name_kana = 'ゴロウ'
    user.number = '09000000005'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
end
User.find_or_create_by!(email: 'user_saitou@example.com') do |user|
    user.last_name = '加藤'
    user.first_name = '花子'
    user.last_name_kana = 'サイトウ'
    user.first_name_kana = 'ハナコ'
    user.number = '09000000006'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
end

# イベント登録
60.times do |n|
    unless (n % 4 == 0 and n % 9 == 0)
        Event.create!(
            title: "サンプル#{n + 1}",
            description: '詳細',
            wages: 1000,
            start: DateTime.now.beginning_of_day + (n - 29).day,
            end: DateTime.now.beginning_of_day + (n - 29).day + 8.hour,
            limit: 5,
            deadline: DateTime.now.beginning_of_day + (n - 30).day,
            place: '場所',
            allowance: 2000,
            remark: 'なし'
        )
    else
        Event.create!(
            title: "サンプル#{n + 1}",
            description: '詳細',
            wages: 1000,
            start: DateTime.now.beginning_of_day + (n - 28).day,
            end: DateTime.now.beginning_of_day + (n - 28).day + 8.hour,
            limit: 5,
            deadline: DateTime.now.beginning_of_day + (n - 29).day,
            place: '場所',
            allowance: 2000,
            remark: 'なし'
        )
    end
end

# idを中間テーブルに登録
for i in 1..6 do
    for j in 1..60 do
        if j % (i + 1) == 0 
            @event = Event.find(j)
            if @event.deadline < DateTime.now
                EventApplicant.create(applicant_id: i, event_id: j, begin: @event.start ,finish: @event.end) 
            else
                EventApplicant.create(applicant_id: i, event_id: j) 
            end
        end
    end
end
