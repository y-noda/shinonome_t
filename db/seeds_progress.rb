module Seed
  class SeedProgress
    GENERAL_USER_NAME = 'o_pxl2Qx8E01'

    def self.seed
      general = User.find_by(name: GENERAL_USER_NAME)
      Video.all.each do |video|
        progress = Progress.new(user: general, video: video)
        progress.save
      end
    end
  end
end
