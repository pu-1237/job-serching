class AttendanceMailer < ApplicationMailer
    default from: 'taskleaf1237@gmail.com'
    def creation_email(user, event)
        @user = user
        @event = event
        mail(
            subject: '出勤確認メール',
            to: @user.email,
        )
    end
end
