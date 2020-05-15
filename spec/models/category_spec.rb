require 'rails_helper'

RSpec.describe Category, type: :model do
  it '正当なファクトリである' do
    expect(build(:category)).to be_valid
  end

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to have_many(:videos) }
    # it { is_expected.to validate_presence_of(:category_type) }
    # it { is_expected.to validate_presence_of(:short_description) }
    # it { is_expected.to validate_presence_of(:description) }
  end
end
