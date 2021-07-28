# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.last_name = '管理者'
    user.first_name = '太郎'
    user.last_name_kana = 'カンリシャ'
    user.first_name_kana = 'タロウ'
    user.number = '090-0000-0000'
    user.postcode = 1111111
    user.prefecture_code = 1
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password'
    user.password_confirmation = 'password'
    user.gender = 'male'
    user.admin = true
end
