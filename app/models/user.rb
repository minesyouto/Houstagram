class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  #フォロー、フォロワー機能の記述
  
  #中間テーブルとしてfollowing_relationshipsモデルを架空で作成。
  #class:name "Relationship"でRelationshipモデルの外部キーをfollowr_idに指定し、follower_idを参考に、
  #following_relationshipsモデルへアクセスするようにしている。
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  
  #through: :following_relationships で、中間テーブルにfollwoing_relationshipsを指定。
  #その結果、user.followingと打つだけでuserが中間テーブル(following_relationships)を取得し、その1つ1つのfollowing_idから
  #フォローしているUser達を取得できるようになる。
  has_many :following, through: :following_relationships
  
  #こちらも同様で架空のモデルfollowe_relationshipsモデルを作成し、それを中間テーブルに指定している。
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  
  #フォローしているかどうかを確認
  #find_byでフォローしているユーザーのUser.idを取得
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end
  
  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end
  
  #フォロー解除のメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end
  
  
         
  #すでにいいねをしているかどうかのチェック
  def already_liked?(post)
   self.likes.exists?(post_id: post.id)
  end
end
