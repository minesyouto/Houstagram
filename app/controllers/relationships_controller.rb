class RelationshipsController < ApplicationController
    
    def create
      @user = User.find(params[:following_id])
      current_user.follow(@user)
    end
    #備忘録
    #ここで呼び出している.followメソッドはUserモデルで作成したメソッド。
    #User.find(params[:following_id])で中間テーブルからfollowing_id => user.idを取得し、followメソッドを実行している
    
    def destroy
        @user = User.find(params[:id])
        current_user.unfollow(@user)
    end
end
