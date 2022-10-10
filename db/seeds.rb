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
User.find_or_create_by!(email: 'user_jirou@example.com') do |user|
    user.last_name = 'ユーザー'
    user.first_name = '次郎'
    user.last_name_kana = 'ユーザー'
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
User.find_or_create_by!(email: 'user_saburou@example.com') do |user|
    user.last_name = 'ユーザー'
    user.first_name = '三郎'
    user.last_name_kana = 'ユーザー'
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
User.find_or_create_by!(email: 'user_sirou@example.com') do |user|
    user.last_name = 'ユーザー'
    user.first_name = '四郎'
    user.last_name_kana = 'ユーザー'
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
User.find_or_create_by!(email: 'user_gorou@example.com') do |user|
    user.last_name = 'ユーザー'
    user.first_name = '五郎'
    user.last_name_kana = 'ユーザー'
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
User.find_or_create_by!(email: 'user_hanako@example.com') do |user|
    user.last_name = 'ユーザー'
    user.first_name = '花子'
    user.last_name_kana = 'ユーザー'
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

30.times do |n|
    unless (n % 5 == 0)
        Event.create!(
            title: "サンプル#{n + 1}",
            description: '詳細',
            wages: 1000,
            start: DateTime.now.beginning_of_day + (n +1).day,
            end: DateTime.now.beginning_of_day + (n + 1).day + 9.hour,
            limit: 5,
            deadline: DateTime.now.beginning_of_day + (n).day,
            place: '場所',
            allowance: 2000,
            remark: 'なし'
        )
    else
        Event.create!(
            title: "サンプル#{n + 1}",
            description: '詳細',
            wages: 1000,
            start: DateTime.now.beginning_of_day + (n).day,
            end: DateTime.now.beginning_of_day + (n).day + 7.hour,
            limit: 5,
            deadline: DateTime.now.beginning_of_day + (n - 1).day,
            place: '場所',
            allowance: 2000,
            remark: 'なし'
        )
    end
end
