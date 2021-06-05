class CancelMailer < ApplicationMailer
    default from: 'taskleaf1237@gmail.com'

    def creation_email(user, event)
        @user = user
        @event = event
        mail(
            subject: 'キャンセル完了メール',
            to: @user.email,
        )
    end
end
