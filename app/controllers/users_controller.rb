class UsersController < ApplicationController

before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
before_filter :correct_user,   only: [:edit, :update]
before_filter :admin_user,     only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
   @user = User.find(params[:id])

# contracts with taken offer of user
   @contracts_id_mytaken = @user.offers.
                           where(:taken => true).map(&:contract_id).uniq  
   @contracts_taken = @user.contracts.
                     where("contract_id IN (?)", @contracts_id_mytake).uniq

# contracts with nottaken offers of user
   @contracts_id_nottaken = @user.offers.
                           where(:taken => nil).map(&:contract_id).uniq

   @contracts_nottaken = @user.contracts.
                     where("contract_id IN (?)", @contracts_id_nottaken).
                     where(:close_contract => false).
                     where(["date_rent >= ?", Time.now]).uniq

   @contracts = @contracts_nottaken
   
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
    @user = User.find(params[:id])
    
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

# begin new destroy for pictures
  def delete_asset
    user = User.find(params[:user_id])
      asset = user.attached_assets.find(params[:pic])
      asset.asset.clear
      asset.destroy
      user.save(:validate => false)
   redirect_to edit_user_path(current_user)
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
       redirect_to(root_path) unless curent_user.admin?
    end
end
