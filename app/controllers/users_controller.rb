class UsersController < ApplicationController

before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
before_filter :correct_user,   only: [:edit, :update]
before_filter :admin_user,     only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
   @user = User.find(params[:id])
  end

  def new
    redirect_to(root_path) if signed_in?
    @user = User.new
  end

  def create
    redirect_to(root_path) if signed_in?
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
  
  def edit
#    @user = User.find(params[:id])
  end

  def update
#   @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
    UserMailer.update_email(@user).deliver
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
       redirect_to(root_path) unless curent_user.admin?
    end
end
