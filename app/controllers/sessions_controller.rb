class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user && @user
      login!(@user)
      redirect_to root_url
    else
      @user = User.new({ username: params[:user][:username] })
      flash.now[:errors] = "Invalid login details"
      render :new
    end
  end

  def destroy
    current_user && logout!
    @user = User.new
    # redirect_to new_session_url
    render json: @user
  end

  def guest
    @user = User.find_by_credentials(
      "baloo", "password"
    )
  end
end
