class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        # Tell the UserMailer to send a welcome Email after save
        UserMailer.welcome_email(@user).deliver
      flash[:success] = "Welcome to the TaxiZi! Good luck and best deal."
      redirect_to @user
    else
      render 'new'
    end
  end
end
