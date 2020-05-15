module Seed
  class SeedGeneral
    GENERAL_USER_NAME = 'general'
    GENERAL_USER_PASSWORD = 'password'
    ADMINISTRATOR = false

    def self.seed

      0.upto(100) do |num|
        general = User.find_by(name: "general_#{num}")

        if general.nil?
          general = User.new(name: "general_#{num}",
          password: GENERAL_USER_PASSWORD,
          password_confirmation: GENERAL_USER_PASSWORD,
          administrator: ADMINISTRATOR)
        end

        general.save
      end

    end
  end
end
