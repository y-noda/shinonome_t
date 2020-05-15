module Seed
  class SeedChecksheetAnswerGeneral

    GENERAL_USER_NAME = 'o_pxl2Qx8E01'
    GENERAL_USER_PASSWORD = 'LT5tYv6l'
    ADMINISTRATOR = false

    def self.seed
      general = User.find_by(name: GENERAL_USER_NAME)

      if general.nil?
        general = User.new(name: GENERAL_USER_NAME,
        password: GENERAL_USER_PASSWORD,
        password_confirmation: GENERAL_USER_PASSWORD,
        administrator: ADMINISTRATOR)
      end

      general.save

      Video.all.each do |video|
        checksheet_answer = ChecksheetAnswer.find_by(user_id: general.id, video_id: video.id)
        checksheet_answer = ChecksheetAnswer.new(user_id: general.id, video_id: video.id) if checksheet_answer.nil?

        checksheet_answer.answer = {}
        checksheet_answer.correct_answer = true

        checksheet_answer.save
      end
    end
  end
end
