class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_admin_access, except: [:show, :edit, :update]
  before_action :check_user_access, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    set_flash(@user, false)
  end

  def update
    @user.update_without_password(user_params)
    set_flash(@user, false)
  end

  def destroy
    @user.destroy
    set_flash(@user, true)
  end

  private

  def check_user_access
    check_access_and_redirect(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :department_id, :role)
  end
end
