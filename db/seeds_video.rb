module Seed
  class SeedVideo
    include ActionDispatch::TestProcess

    VIDEO = [
      [
        {title: '学習指導案の書き方',
        description: '<li>○学習指導案について</li><li>○学習指導案の項目について</li><li>○おわりに</li>',
        order: 3},
        {title: '授業づくりの基本',
        description: '<li>○指導事項について</li><li>○児童の実態把握</li><li>○教材について</li><li>○指導の具体</li>',
        order: 2},
        {title: 'よりよい授業を目指して',
        description: '<li>○よりよい授業とは</li><li>○授業研究について</li>',
        order: 1},
      ],
      [
        {title: '情報モラル',
        description: '<li>○インターネットの特性と情報モラル</li><li>○著作権の保護について</li>',
        order: 3},
        {title: '授業におけるＩＣＴの活用',
        description: '<li>○拡大提示の効果的な活用</li><li>○協働学習や個別学習での活用</li>',
        order: 2},
        {title: '教育の情報化と情報教育',
        description: '<li>○教育の情報化</li><li>○情報教育</li><li>○ＩＣＴの特長</li><li>○ＩＣＴを活用する意義</li>',
        order: 1},
      ],
      [
        {title: '食育',
        description: '<li>○食育の基本的な考え方</li><li>○学校における食育の在り方</li><li>○給食指導について</li>',
        order: 3},
        {title: '学校安全',
        description: '<li>○学校安全の考え方</li><li>○学校安全の領域と内容</li><li>○学校安全計画の作成</li><li>○安全教育の目標</li><li>○学校における安全管理</li>',
        order: 2},
        {title: '学校保健',
        description: '<li>○健康観察</li><li>○健康診断</li><li>○要観察者の継続観察・指導</li><li>○救急処置</li><li>○感染症予防</li><li>○学校環境衛生</li>',
        order: 1},
      ],
    ]

    def self.seed
      Category.all.each do |category|
        for num in 1..3 do
          videoinfo = VIDEO[category.id - 1][num - 1]
          Video.create(
            title: videoinfo[:title],
            description: videoinfo[:description],
            category: category,
            videofile: File.new(Rails.root.join('spec', 'materials', 'test.mp4')),
            order: videoinfo[:order],
            minutes: 0,
            seconds: 0,
            thumbnail: File.new(Rails.root.join('spec', 'materials', 'demo_thumbnail.png'))
          )
        end
      end
    end
  end
end
