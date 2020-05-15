require 'csv'
namespace :import_users_task do
    desc "Import users from csv"

    task users: :environment do
        path = File.join Rails.root, "db/csv/2019ID.CSV"
        CSV.foreach(path, headers: true) do |row|
            user = User.new(name: row["id"],
                password: row["password"],
                password_confirmation: row["password"],
                administrator: false)
            user.save
        end
    end
end
