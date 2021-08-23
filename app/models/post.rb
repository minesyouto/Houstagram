class Post < ApplicationRecord
    has_many :post_images, dependent: :destroy
    #Postモデルが複数の画像を持てるようにPostImageモデルと紐づける
    has_many :likes, dependent: :destroy
    #PostモデルとLikeモデルを紐づける
    accepts_attachments_for :post_images, attachment: :post_image
    #post_image(_id)をpostのviewにて表示させるための設定
    belongs_to :user
    
    has_many :post_items
    
    has_many :comments, dependent: :destroy
    
    acts_as_taggable
    
    validates :title, presence: true
    validates :content, presence: true
    #タイトル、本文を空欄で投稿させないためのバリデーション設定
end
