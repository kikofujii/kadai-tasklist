class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーの登録に成功しました"
      redirect_to root_url
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました"
      render :new
    end
  end

  def new
    @user = User.new
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
