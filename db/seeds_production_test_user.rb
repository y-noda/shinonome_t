module Seed
  class SeedProductionTestUser
    USER_INFO = [
      ['t_18k80h31', 'xcw6CdUA'],
      ['d_yIEr3YFh', 'tuTXLSiO'],
      ["o_pxl2Qx8E", "LT5tYv6l"]
    ]

    def self.seed

      USER_INFO.each do |info|
        1.upto(100) do |num|
          name = "#{info[0]}#{"%02d" % num}"
          general = User.find_by(name: name)

          if general.nil?
            general = User.new(
            name: name,
            password: info[1],
            password_confirmation: info[1],
            administrator: false)
          end

          general.save
        end
      end

    end

  end
end
