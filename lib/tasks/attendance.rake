namespace :attendance do
  desc "出勤確認メール"
  task :mail => :environment do
        EventApplicant.all.each do |application|
          event = Event.find(application.event_id)
          user = User.find(application.applicant_id)
          if event.start.day == Date.today.day
              AttendanceMailer.creation_email(user, event).deliver_now
          end
        end
  end
end