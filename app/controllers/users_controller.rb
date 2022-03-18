class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update,:destroy]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def show
    @user = User.find(params[:id])
    # debugger
  end
  def create
    @user = User.new(user_params)    # 不是最终的实现方式
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # 处理注册成功的情况
    else
         render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User was successfully destroyed."
    redirect_to @user # 处理注册成功的情况

  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)      # 处理更新成功的情况
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  #确保用户已登陆
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_url) unless @user==current_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 确保是管理员
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
