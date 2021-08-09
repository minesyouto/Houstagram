class PostImage < ApplicationRecord
    belongs_to :post
    attachment :post_image
    #post_image(_id)をpostのviewにて表示させるための設定
    
end
