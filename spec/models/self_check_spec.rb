require 'rails_helper'

RSpec.describe SelfCheck, type: :model do
  it 'Factory' do
    expect(build(:self_check)).to be_valid
  end

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :answer }
  end
end
