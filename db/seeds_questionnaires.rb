module Seed
  class SeedQuestionnaires
    def self.seed
      Category.all.each do |category|
        Questionnaire.create(
          category: category,
          question: "この研修講座で、一番印象に残っていることを書いてください。",
          choice_a: "選択肢1",
          choice_b: "選択肢2",
          choice_c: "選択肢3",
          choice_d: "選択肢4",
          question_type: "free",
          order: 1
        )

        Questionnaire.create(
          category: category,
          question: "この研修講座は、あなた自身にとって、「何を学ぶことができましたか」、「どういう意義がありましたか」、また、「今後の教育活動にどのように生かしますか」。それぞれの研修について振り返りながら、自由に書いてください。",
          choice_a: "選択肢1",
          choice_b: "選択肢2",
          choice_c: "選択肢3",
          choice_d: "選択肢4",
          question_type: "free",
          order: 2
        )

        Questionnaire.create(
          category: category,
          question: "この研修講座にかかわって、さらにこんな研修をしてみたいなと思うことがあれば、書いてください。(講座の感想や願望ではなく、前向きな提案です。)",
          choice_a: "選択肢1",
          choice_b: "選択肢2",
          choice_c: "選択肢3",
          choice_d: "選択肢4",
          question_type: "free",
          order: 3
        )
      end
    end
  end
end
