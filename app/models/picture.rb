class Picture < ActiveRecord::Base
  #validates :title, presence: true
  #validates :image, presence: true
  mount_uploader :image, ImageUploader

  belongs_to :user
  #attachment :image
  validate :add_error_picture
 
  def add_error_picture
    if title.blank?
      errors[:base] << "タイトルを入力してください。"
    end

    if image.blank?
      errors[:base] << "画像ファイルを選択してください。"
    end
  end

end
