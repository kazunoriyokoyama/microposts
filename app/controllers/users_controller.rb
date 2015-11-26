class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user =User.new(user_params)
    if @user.save
       flash[:success] = "Welcome to the Sample App!"
       redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to @user
      
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @user  = User.find(params[:id])
    @followings=@user.following_users
    @following_users = User.page(params[:page])
    render 'followings'
  end

  
  def followers
   @user  = User.find(params[:id])
   @followers = @user.follower_users
   @follower_users = User.page(params[:page])
   render 'followers'
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :area, :password, :password_confrimation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
    
  def correct_user
    @user = User.find(params[:id])
    
    redirect_to(root_url) unless @user == current_user
  end
  
  
end
