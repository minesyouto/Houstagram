class Comment < ApplicationRecord
    
    belongs_to :user
    belongs_to :post
    #空欄で投稿できないようにバリデーションをかける
    validates :content, presence: true
end
