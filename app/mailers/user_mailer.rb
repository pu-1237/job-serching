class UserMailer < ApplicationMailer
    default from: 'taskleaf1237@gmail.com'

    def password_reset(user)
        @user = user
        mail(
            subject: 'パスワード再設定メール',
            to: @user.email,
        )
    end
end
