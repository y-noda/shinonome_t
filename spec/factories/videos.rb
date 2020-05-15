FactoryBot.define do
  factory :video do
    category
    videofile { fixture_file_upload(Rails.root.join('spec', 'materials', 'test.mp4'), 'video/mp4') }
    description { 'description' }
    worksheet { fixture_file_upload(Rails.root.join('spec', 'materials', 'test.xlsx'), 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
    slide { fixture_file_upload(Rails.root.join('spec', 'materials', 'test.pptx'), 'application/vnd.openxmlformats-officedocument.presentationml.presentation') }
    title { 'title' }

    thumbnail { fixture_file_upload(Rails.root.join('spec', 'materials', 'demo_thumbnail.png'), 'image/png') }
    minutes { 4 }
    seconds { 33 }
  end
end
