require 'rails_helper'

RSpec.describe User, type: :model do
  it '正当なファクトリである' do
    expect(build(:user)).to be_valid
  end

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
  end
end
