module Seed
  class SeedChecksheetHeals

    # チャプター１　学校保健
    checksheet_1_1 = [
      '健康観察の目的について要点を整理しましょう。',
    ]
    checksheet_1_2 = [
      '緊急時における教職員の対応についてまとめましょう。',
    ]

    # チャプター２　学校安全
    checksheet_2_1 = [
      '「安全教育」の目標を踏まえて、あなたなら児童生徒にどのような力を身に付けさせたいですか。',
    ]
    checksheet_2_2 = [
      '学校における「危機管理」の意識を持ち続けるために、あなたなら具体的にどのように取り組みますか。',
    ]

    # チャプター３　食育
    checksheet_3_1 = [
      'あなたなら学校の教育活動のどのような場面で食育に取り組みますか。',
    ]
    checksheet_3_2 = [
      '給食の時間における食育の留意点についてまとめましょう。',
    ]
    checksheet_3_3 = [
      '食育を推進するための手立てについてまとめましょう。',
    ]

    CHECKSHEETS_1 = [
      checksheet_1_1,
      checksheet_1_2
    ]

    CHECKSHEETS_2 = [
      checksheet_2_1,
      checksheet_2_2
    ]
    CHECKSHEETS_3 = [
      checksheet_3_1,
      checksheet_3_2,
      checksheet_3_3
    ]

    def self.seed
      CHECKSHEETS_1.each_with_index do |m, i|
        checksheet = Checksheet.find_by(question: m[0])
        order = i + 1

        if checksheet.nil?
          checksheet = Checksheet.new(question: m[0],
                             choice_a: '',
                             choice_b: '',
                             choice_c: '',
                             choice_d: '',
                             correct: '',
                             answer_type: 'freedom')
        end

        checksheet.save

        video = 9

        video_checksheet = VideoChecksheet.find_by(video_id: video, checksheet_id: checksheet.id, order: order)
        video_checksheet = VideoChecksheet.new(video_id: video, checksheet_id: checksheet.id, order: order) if video_checksheet.nil?
        video_checksheet.save
      end

      CHECKSHEETS_2.each_with_index do |m, i|
        checksheet = Checksheet.find_by(question: m[0])
        order = i + 1

        if checksheet.nil?
          checksheet = Checksheet.new(question: m[0],
                             choice_a: '',
                             choice_b: '',
                             choice_c: '',
                             choice_d: '',
                             correct: '',
                             answer_type: 'freedom')
        end

        checksheet.save

        video = 8

        video_checksheet = VideoChecksheet.find_by(video_id: video, checksheet_id: checksheet.id, order: order)
        video_checksheet = VideoChecksheet.new(video_id: video, checksheet_id: checksheet.id, order: order) if video_checksheet.nil?
        video_checksheet.save
      end

      CHECKSHEETS_3.each_with_index do |m, i|
        checksheet = Checksheet.find_by(question: m[0])
        order = i + 1

        if checksheet.nil?
          checksheet = Checksheet.new(question: m[0],
                             choice_a: '',
                             choice_b: '',
                             choice_c: '',
                             choice_d: '',
                             correct: '',
                             answer_type: 'freedom')
        end

        checksheet.save

        video = 7

        video_checksheet = VideoChecksheet.find_by(video_id: video, checksheet_id: checksheet.id, order: order)
        video_checksheet = VideoChecksheet.new(video_id: video, checksheet_id: checksheet.id, order: order) if video_checksheet.nil?
        video_checksheet.save
      end
    end
  end
end
