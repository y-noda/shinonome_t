require 'rails_helper'

describe 'videos/show' do
  let(:video) { create(:video) }
  let(:user) { create(:user) }

  before do
    assign(:video, video)
    assign(:category, video.category)
    assign(:comments, video.comments)
    assign(:comment, Comment.new)
    assign(:current_user, user)

    view.stub(:current_user) { user }
  end

  it 'ビデオを表示する' do
    render

    # 雑 matcher だけど、View が表示エラーになってないことだけ分かればよい
    expect(rendered).to match /#{video.title}/
  end
end
