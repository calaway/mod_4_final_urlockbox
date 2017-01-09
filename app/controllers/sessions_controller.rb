class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root, notice: "Sign In Successful"
    else
      redirect_to :login, notice: "Sign In Unsuccessful"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :login
  end
end
