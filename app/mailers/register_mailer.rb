class RegisterMailer < ApplicationMailer
    default from: 'taskleaf1237@gmail.com'

    def creation_email(user)
        @user = user
        mail(
            subject: 'ユーザー登録完了メール',
            to: @user.email,
        )
    end
end
