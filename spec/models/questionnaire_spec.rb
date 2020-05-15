require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  it '正当なファクトリである' do
    expect(build(:questionnaire)).to be_valid
  end

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of :question }
  end

  describe 'リレーション' do
    it { is_expected.to belong_to(:category) }
  end
end
