class User::OmniauthCallbacksController < ApplicationController
  def google_oauth2
    authorization   # コールバック
  end

  def failure
    redirect_to root_path
  end

  private
  # コールバックのメソッド定義
  def authorization   # APIから取得したユーザー情報はrequest.env["omniauth.auth"]に格納されてる
    sns_info = User.from_omniauth(request.env["omniauth.auth"]) 
    #request.env["omniauth.auth"]に格納されている情報は以下の通り
        #provider => プロバイダー(googleなど)
        #uid => プロバイダーの固有の識別子
        #info => ユーザー情報(ハッシュ)
            #name => 表示名
            #email => メールアドレス
            #nickname => ユーザー名(Twitterの@名など)
            #その他いろんな情報が格納されている
    
    @user = sns_info[:user]    # deviseのヘルパーを使うため、＠user に代入(ハッシュ(モデルの返り値)から値を取得)

    if @user.persisted? # ユーザー登録済み(ログイン処理)
      sign_in_and_redirect @user, event: :authentication   # authenticationのcallbackメソッドを呼んで、@user でログイン
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else                # ユーザー未登録(新規登録画面へ遷移)
      @sns_id = sns_info[:sns].id                  # ハッシュ(モデルの返り値)から取得した、認証データを一時的に保持(ユーザー登録ページに渡す)
      render template: new_user_registration_url   # ユーザー登録ページに遷移
    end
  end
end
