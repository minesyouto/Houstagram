class PostImage < ApplicationRecord
    belongs_to :post
    attachment :post_image
    has_many :post_tags
    #post_image(_id)をpostのviewにて表示させるための設定
    
end
