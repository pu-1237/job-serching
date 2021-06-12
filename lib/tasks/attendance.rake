namespace :attendance do
  desc "出勤確認メール"
  task :mail => :environment do
    Event.all.each do |event|
      User.all.each do |user|
        if EventApplicant.find_by(event_id: event.id, applicant_id: user.id)
          AttendanceMailer.creation_email(user, event).deliver_now
        end
      end
    end
  end
end