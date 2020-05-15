module Seed
  class SeedChecksheetGuidance

    # チャプター１
    checksheet_1_1 = [
      'よりよい授業について、最も適切なものを次の①～④から一つ選んでください。',
      '①　教員の指導の工夫という視点からみるとき、児童が仲良く活動している授業が、最もよい授業といえる。',
      '②　教員側の教えたいことよりも、児童の学びたいことを優先的に教えていくようにすることがよりよい授業である。',
      '③　よりよい授業とひとことでいっても、教員の省察からも、児童の様相からも、様々な視点で言い表すことができる。',
      '④　常に自分が考えるよりよい授業を意識することが大切なので、教員同士で話し合うような機会は設けなくてもよい。',
      '3',
      'radio'
    ]
    checksheet_1_2 = [
      '授業研究について、最も適切なものを次の①～④から一つ選んでください。',
      '①　授業研究は、指導の工夫を意識し、児童の様子を見取っていれば十分といえる。',
      '②　授業研究は、授業における課題を明らかにすることを主たる目的として行われる。',
      '③　授業研究は、実際に実践を行う研究授業を公開すれば、授業研究が終了したと考えてよい。',
      '④　授業研究は、一般的にＲ-ＰＤＣＡサイクルを意識しながら行われる。',
      '4',
      'radio'
    ]
    checksheet_1_3 = [
      '授業研究では、課題解決に向けて行う授業実践の成果をどうしていくことが大切だと考えられますか。最も適切なものを次の①～④から一つ選んでください。',
      '①　見直しすること',
      '②　記録すること',
      '③　次の授業に活用すること',
      '④　整理・分類すること',
      '3',
      'radio'
    ]

    # チャプター２
    checksheet_2_1 = [
      '児童に指導すべき事項は何を拠りどころにすべきでしょうか。正しいものを次の①～④から一つ選んでください。',
      '①　学習指導要領',
      '②　教科書',
      '③　副読本',
      '④　辞書',
      '1',
      'radio'
    ]
    checksheet_2_2 = [
      '指導事項に関わっては、児童のどのような実態を把握することが大切でしょうか。最も適切なものを次の①～④から一つ選んでください。',
      '①　普段の生活の様子',
      '②　身に付いている力や付いていない力の現状',
      '③　家庭での学習時間',
      '④　友達関係が良好かどうか',
      '2',
      'radio'
    ]
    checksheet_2_3 = [
      '具体的な指導の構成をする際、どのようなことを大切にすべきでしょうか。正しいものを次の①～④から一つ選んでください。',
      '①　どのタイミングでどんな活動を盛り込むのか、教員が明確な意図をもつこと。',
      '②　教員が児童の好みに応じて、児童が楽しむ活動をできる限り数多く盛り込むようにすること。',
      '③　教科書に書かれている通りの活動だけを盛り込むようにすること。',
      '④　教員が指導事項に関する知識を児童に伝える活動を中心として盛り込むこと。',
      '1',
      'radio'
    ]

    # チャプター３
    checksheet_3_1 = [
      '学習指導案の役割として、授業をつくる際には、どのような働きを有していますか。最も適切なものを次の①～④から一つ選んでください。',
      '①　参考資料',
      '②　設計図',
      '③　記録文書',
      '④　データベース',
      '2',
      'radio'
    ]
    checksheet_3_2 = [
      '単元の目標に照らし合わせ、評価の観点別に、どのような学習状況が実現していればよいのかを具体的に想定して示したものをなんというでしょうか。正しいものを次の①～④から一つ選んでください。',
      '①　評価規準',
      '②　評価基準',
      '③　自己評価',
      '④　相互評価',
      '1',
      'radio'
    ]
    checksheet_3_3 = [
      '本時案における本時の目標を書く際、留意することはどんなことでしょう。最も適切なものを次の①～④から一つ選んでください。',
      '①　具体的な学習活動を児童の立場から書くこと。',
      '②　どのような力をどのような学習活動を通して児童に身に付けさせるのかを書くこと。',
      '③　指導の工夫点などについて、授業の時間の流れに添って書くこと。',
      '④　評価基準や評価方法、準備物を書くこと。',
      '2',
      'radio'
    ]

    CHECKSHEETS_1 = [
      checksheet_1_1,
      checksheet_1_2,
      checksheet_1_3
    ]

    CHECKSHEETS_2 = [
      checksheet_2_1,
      checksheet_2_2,
      checksheet_2_3
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
                             choice_a: m[1],
                             choice_b: m[2],
                             choice_c: m[3],
                             choice_d: m[4],
                             correct: m[5],
                             answer_type: 'radio')
        end

        checksheet.save

        video = 3

        video_checksheet = VideoChecksheet.find_by(video_id: video, checksheet_id: checksheet.id, order: order)
        video_checksheet = VideoChecksheet.new(video_id: video, checksheet_id: checksheet.id, order: order) if video_checksheet.nil?
        video_checksheet.save
      end

      CHECKSHEETS_2.each_with_index do |m, i|
        checksheet = Checksheet.find_by(question: m[0])
        order = i + 1

        if checksheet.nil?
          checksheet = Checksheet.new(question: m[0],
                             choice_a: m[1],
                             choice_b: m[2],
                             choice_c: m[3],
                             choice_d: m[4],
                             correct: m[5],
                             answer_type: 'radio')
        end

        checksheet.save

        video = 2

        video_checksheet = VideoChecksheet.find_by(video_id: video, checksheet_id: checksheet.id, order: order)
        video_checksheet = VideoChecksheet.new(video_id: video, checksheet_id: checksheet.id, order: order) if video_checksheet.nil?
        video_checksheet.save
      end

      CHECKSHEETS_3.each_with_index do |m, i|
        checksheet = Checksheet.find_by(question: m[0])
        order = i + 1

        if checksheet.nil?
          checksheet = Checksheet.new(question: m[0],
                             choice_a: m[1],
                             choice_b: m[2],
                             choice_c: m[3],
                             choice_d: m[4],
                             correct: m[5],
                             answer_type: 'radio')
        end

        checksheet.save

        video = 1

        video_checksheet = VideoChecksheet.find_by(video_id: video, checksheet_id: checksheet.id, order: order)
        video_checksheet = VideoChecksheet.new(video_id: video, checksheet_id: checksheet.id, order: order) if video_checksheet.nil?
        video_checksheet.save
      end
    end
  end
end
