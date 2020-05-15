class Video < ApplicationRecord 
  validates_presence_of :title
  validates_presence_of :description

  belongs_to :category
  has_many :comments
  has_many :progresses
  has_many :video_checksheets
  has_many :checksheets, through: :video_checksheets
  has_one :checksheet_answer

  has_attached_file :videofile
  validates_attachment :videofile, content_type: { content_type: ['video/mp4'] }

  has_attached_file :worksheet
  has_attached_file :slide

  has_attached_file :thumbnail, styles: { small: '320x320>' }
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/(png|jpeg|jpg)\z/

  validates :videofile, attachment_presence: true
  validates :thumbnail, attachment_presence: true
  validates :minutes, presence: true
  validates :seconds, presence: true

  validates :minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 60 }

  def watched?(user)
    Progress.exists?(user: user, video: self)
  end

  def checksheet_answered?(user)
    ChecksheetAnswer.exists?(user: user, video: self)
  end

  def checksheet_complete?(user)
    ChecksheetAnswer.find_by(user: user, video: self).try(:correct_answer)
  end

  def videourl(category_id)
    return videofile.url if can_upload_file?

    # Heroku上でファイルアップロードできないがゆえの処理
    # 必要ならファイルをS3にホストしてvideofile.urlを返すようにする
    case category_id
    when 1
      case self.id
      when 3
        'http://test3.entaworks.co.jp/shinonome/videos/01_A.mp4'
      when 2
        'http://test3.entaworks.co.jp/shinonome/videos/01_B.mp4'
      when 1
        'http://test3.entaworks.co.jp/shinonome/videos/01_C.mp4'
      else
        'http://test3.entaworks.co.jp/shinonome/videos/01_A.mp4'
      end
    when 2
      case id
      when 6
        'http://test3.entaworks.co.jp/shinonome/videos/02_A.mp4'
      when 5
        'http://test3.entaworks.co.jp/shinonome/videos/02_B.mp4'
      when 4
        'http://test3.entaworks.co.jp/shinonome/videos/02_C.mp4'
      else
        'http://test3.entaworks.co.jp/shinonome/videos/02_A.mp4'
      end
    when 3
      case id
      when 9
        'http://test3.entaworks.co.jp/shinonome/videos/03.mp4'
      when 8
        'http://test3.entaworks.co.jp/shinonome/videos/04.mp4'
      when 7
        'http://test3.entaworks.co.jp/shinonome/videos/05.mp4'
      else
        'http://test3.entaworks.co.jp/shinonome/videos/03.mp4'
      end
    else
      'http://test3.entaworks.co.jp/shinonome/videos/01_A.mp4'
    end
  end

  def thumbnail_url(style = :original)
    return thumbnail.url(style) if can_upload_file?

    "imgChapterList_0#{id}.png"
  end

  def checksheeturl
    case self.id
    when 3
      '/checksheets/guidance_1'
    when 2
      '/checksheets/guidance_2'
    when 1
      '/checksheets/guidance_3'
    when 6
      '/checksheets/ict_1'
    when 5
      '/checksheets/ict_2'
    when 4
      '/checksheets/ict_3'
    when 9
      '/checksheets/health_1'
    when 8
      '/checksheets/health_2'
    when 7
      '/checksheets/health_3'
    else
      '/checksheets/guidance_1'
    end
  end

  def playtime
    min = minutes || 0
    sec = seconds || 0

    "#{min}分#{'%02d' % sec}秒"
  end

  def worksheeturl
    return worksheet.url if can_upload_file?

    'http://test3.entaworks.co.jp/shinonome/docs/ＩＣＴ_ワークシート.pdf'
  end

  def slideurl
    return slide.url if can_upload_file?

    'http://test3.entaworks.co.jp/shinonome/docs/1_0810教科等指導X.pdf'
  end

  def format_worksheet_file_size
    return Filesize.new(self.worksheet_file_size.to_s, Filesize::SI).pretty if can_upload_file?

    '227KB'
  end

  def format_slide_file_size
    return Filesize.new(self.slide_file_size.to_s, Filesize::SI).pretty if can_upload_file?

    '1.9MB'
  end

  def videofilename
    if videofile.present? && can_upload_file?
      ":#{videofile_file_name}"
    else
      ''
    end
  end

  def thumbnailfilename
    if thumbnail.present? && can_upload_file?
      ":#{thumbnail_file_name}"
    else
      ''
    end
  end

  def worksheetfilename
    unless have_worksheet?
      return ""
    end

    if worksheet.present? && can_upload_file?
      ":#{worksheet_file_name}"
    else
      ''
    end
  end

  def slidefilename
    unless have_slide?
      return ""
    end
    if slide.present? && can_upload_file?
      ":#{slide_file_name}"
    else
      ''
    end
  end

  def have_worksheet?
    worksheet.present?
  end

  def have_slide?
    slide.present?
  end

  private

  def can_upload_file?
    ENV['SHINONOME_FILE_UPLOAD_DISABLED'].nil?
  end

end
