class SnsLogin < ApplicationRecord
  belongs_to :user, optional: true
  #初めてSNS認証でユーザー登録する場合にはまだuser_idが存在しないためユーザー情報が見つからないと言われるので外部キーのnil許可を与える
end
