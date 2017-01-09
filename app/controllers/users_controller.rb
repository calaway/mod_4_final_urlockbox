class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to :root, notice: "Sign In Successful"
    else
      redirect_to :signup, notice: user.errors.full_messages.join(". ")
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
