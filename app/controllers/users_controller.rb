class UsersController < ApplicationController
  include SessionsHelper
  before_action :set_user, only: [:show]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  # sighup後の詳細表示画面(/users/[id])
  def show
    @user = User.find(params[:id])
    # ユーザーに紐付いたマイクロポストを作成日時が新しいものから取得
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  # signup用
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "signup success!!"
      # 詳細表示画面もログイン後かつ正しいユーザのみアクセスさせるため、
      # まずはログインさせる
      redirect_to login_url
    else
      # エラーメッセージ(@user.error)を含めてsignup画面をレンダリング
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params_update)
      flash[:success] = "edit success!!"
      redirect_to @user , notice: '変更結果に間違いないかご確認ください'
    else
      # エラーメッセージ(@user.error)を含めてedit画面をレンダリング
      render 'edit'
    end
  end

  private

  #singup用。signupは簡単にするため登録情報は少なめに。
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  #追加登録（編集）用
  def user_params_update
    params.require(:user).permit(:name, :email, :profile, :location,
                                 :age, :birthday,
                                 :password, :password_confirmation)
  end

  #ログイン済みユーザか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "まずはログインしてくださいね"
      redirect_to login_url
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  #正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path 
    end
  end
end