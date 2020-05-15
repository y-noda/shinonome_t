module Seed
  class SeedCategory
    CATEGORY = [
      {
        title: "「教科等指導Ⅹ」",
        short_description: "－授業研究の充実に向けて,（学習指導案の書き方など）－"
      },
      {
        title: "「情報教育と情報モラル」",
        short_description: ""
      },
      {
        title: "「健康教育」",
        short_description: "－学校保健・学校安全・食育－"
      },
    ]

    def self.seed
      CATEGORY.each do |category_info|
        category_record = Category.create({
          category_type: CategoryType.find_by(title: '初任者研修'),
          title: category_info[:title],
          description: "",
          short_description: category_info[:short_description]
          })
        category_record.save
      end
    end
  end
end
