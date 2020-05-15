require 'rails_helper'

RSpec.describe Video, type: :model do
  it '正当なファクトリである' do
    expect(build(:video)).to be_valid
  end

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:thumbnail) }

    it { is_expected.to validate_presence_of(:minutes) }
    it { is_expected.to validate_presence_of(:seconds) }

    it do
      is_expected.to validate_numericality_of(:minutes)
        .is_greater_than_or_equal_to(0)
        .only_integer
    end

    it do
      is_expected.to validate_numericality_of(:seconds)
        .is_greater_than_or_equal_to(0)
        .is_less_than(60)
        .only_integer
    end
  end

  describe 'Content Type のバリデーション' do
    let (:image_file) { File.new("#{Rails.root}/spec/materials/demo_thumbnail.png") }
    let (:movie_file) { File.new("#{Rails.root}/spec/materials/test.mp4") }
    let (:pptx_file) { File.new("#{Rails.root}/spec/materials/test.pptx") }
    let (:xslx_file) { File.new("#{Rails.root}/spec/materials/test.xlsx") }
    let (:pdf_file) { File.new("#{Rails.root}/spec/materials/test.pdf") }

    describe 'worksheet のバリデーション' do
      it '画像を許可する' do
        expect(build(:video, worksheet: image_file)).to be_valid
      end

      it '動画を許可する' do
        expect(build(:video, worksheet: movie_file)).to be_valid
      end

      it 'pptx を許可する' do
        expect(build(:video, worksheet: pptx_file)).to be_valid
      end

      it 'xslx を許可する' do
        expect(build(:video, worksheet: xslx_file)).to be_valid
      end

      it 'pdf を許可する' do
        expect(build(:video, worksheet: pdf_file)).to be_valid
      end
    end

    describe 'slide のバリデーション' do
      it '画像を許可する' do
        expect(build(:video, slide: image_file)).to be_valid
      end

      it '動画を許可する' do
        expect(build(:video, slide: movie_file)).to be_valid
      end

      it 'pptx を許可する' do
        expect(build(:video, slide: pptx_file)).to be_valid
      end

      it 'xslx を許可する' do
        expect(build(:video, slide: xslx_file)).to be_valid
      end

      it 'pdf を許可する' do
        expect(build(:video, slide: pdf_file)).to be_valid
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe '#playtime' do
    subject { build(:video) }

    it '分秒をフォーマットして返す' do
      subject.minutes = 4
      subject.seconds = 3
      expect(subject.playtime).to eq('4分03秒')
    end

    context '古いレコードで分秒が nil のとき' do
      it '分秒を 0 でフォーマットして返す' do
        subject.minutes = nil
        subject.seconds = nil
        expect(subject.playtime).to eq('0分00秒')
      end
    end
  end
end
