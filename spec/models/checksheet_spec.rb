require 'rails_helper'

RSpec.describe Checksheet, type: :model do
  it '正当なファクトリである' do
    expect(build(:checksheet)).to be_valid
  end

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of :question }
  end
end
