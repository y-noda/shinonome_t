require 'csv'
namespace :reset_progress_test_users_task do
    desc "Reset Progress form test users"

    task users: :environment do
        users = User.where('name LIKE ?', "t_%")
        users.each do |user|
            progress = Progress.where(user: user)
            if progress.present?
                progress.destroy_all
            end
        end
      end
end