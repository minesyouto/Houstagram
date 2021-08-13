class Relationship < ApplicationRecord
    #自分をフォローしているユーザー
    #class_nameで参照先のテーブルを指定
    #follower,followingクラスは存在しないクラスだが参照先のテーブルを指定することによって存在しないクラスを参照することを防ぐ。
    belongs_to :follower, class_name: "User"
    
    #自分がフォローしているユーザー
    belongs_to :following, class_name: "User"
    
    #バリデーション
    validates :follower_id, presence: true
    validates :following_id, presence: true
    
end
