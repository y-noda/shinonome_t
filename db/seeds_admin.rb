module Seed
  class SeedAdmin
    ADMIN_USER_NAME = 'admin'
    ADMIN_USER_PASSWORD = 'UGDXdsxA5iPA006W'
    ADMINISTRATOR = true

    def self.seed
      admin = User.find_by(name: ADMIN_USER_NAME)

      if admin.nil?
        admin = User.new(name: ADMIN_USER_NAME,
                         password: ADMIN_USER_PASSWORD,
                         password_confirmation: ADMIN_USER_PASSWORD,
                         administrator: ADMINISTRATOR)
      end

      admin.save
    end
  end
end
