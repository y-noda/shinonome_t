module Seed
  class SeedCategoryType
    CATEGORY_TYPE = [
      "初任者研修"
    ]

    def self.seed
      CATEGORY_TYPE.each do |category_type|
        category_type_record = CategoryType.create(
          title: category_type
          )
        category_type_record.save
      end
    end
  end
end
