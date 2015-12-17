class UsersController < ApplicationController
  #ユーザ登録後の詳細画面表示用(/users/x遷移時)
  def show
    @user = User.find(params[:id])
  end
  
  #ユーザ新規登録用(/signup遷移時)
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_path(@user)と同じ動作(/users/xへ遷移)
      # routes.rbでresources :users設定済みのため省略可
      redirect_to @user
    else
      # エラーメッセージ/投稿しようとした内容を含む
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end