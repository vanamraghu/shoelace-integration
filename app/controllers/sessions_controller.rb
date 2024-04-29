class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(user_params)
    if @user
      session[:user_id] = @user.id
      redirect_to posts_url
    else
      flash.now[:alert] = "Please provide username and password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    if session[:user_id].nil?
      puts 'session id is deleted'
    else
      puts 'session id is not deleted'
    end
    redirect_to posts_url, notice: "Logged out successfully", status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
