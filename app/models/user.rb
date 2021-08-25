class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
         
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_items
  #SNS認証のためのアソシエーション
  has_many :sns_login
  
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
  
  #SNS認証のコールバックの際に呼ばれるメソッド
  def self.from_omniauth(auth)       # snsから取得した、providerとuidを使って、既存ユーザーを検索
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create  # sns認証したことがあればアソシエーションで取得、なければSns_credentialsテーブルにレコード作成
  
    # snsのuser or usersテーブルに対し、SNS認証で取得したメールアドレスが登録済みの場合は、取得 or なければビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
      email: auth.info.email
    )
    if user.persisted?   # userが登録済みの場合：そのままログインするため、snsのuser_idを更新しとく
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }   # user、snsをハッシュで返す(コントローラーがこれを受け取る)
  end
end
