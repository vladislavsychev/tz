# -*- encoding : utf-8 -
class UsersController < ApplicationController

before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
before_filter :correct_user,   only: [:show, :edit, :update]
before_filter :admin_user,     only: [:destroy, :index]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
   @user = User.find(params[:id])

# contracts with taken offer of user
   contracts_id_mytaken = @user.offers.
                           where(:taken => true).map(&:contract_id).uniq  
   @contracts_taken = @user.contracts.
                     where("contract_id IN (?)", contracts_id_mytaken).
                     where(["date_rent >= ?", Time.now]).uniq

# contracts with nottaken offers of user
   contracts_id_nottaken = @user.offers.
                           where(:taken => false).map(&:contract_id).uniq

   @contracts_nottaken = @user.contracts.
                     where("contract_id IN (?)", contracts_id_nottaken).
                     where(:close_contract => false).
                     where(["date_rent >= ?", Time.now]).uniq
   
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
      flash[:success] = "Вы новый пользователь Такси Zi. Добро пожаловать!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
#    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(params[:user])
    UserMailer.update_email(user).deliver
      flash[:success] = "Личная информация успешно отредактирована."
      sign_in user
      redirect_to user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален."
    redirect_to users_url
  end

# begin new destroy for pictures
  def delete_asset
    user = User.find(params[:user_id])
      if user == current_user
         asset = user.attached_assets.find(params[:pic])
         asset.asset.clear
         asset.destroy
         user.save(:validate => false)
         sign_in user
         redirect_to edit_user_path(user)
      else
         redirect_to root_path
      end
  end
  
  def newpass
      user = User.find_by_email(params[:user][:email])
      unless user.nil?
        newpass = ((0..9).to_a + ('A'..'X').to_a).shuffle.join[0..7]
        user.update_attributes(:password => newpass, :password_confirmation => newpass)
        user[:password] = newpass
        UserMailer.newpass_email(user).deliver
        respond_to do |format|
          format.html { redirect_to signin_path }
          format.js
        end
      end
  end

  def posts
    if !params[:email].empty? && !params[:name] && !params[:phone] && !params[:content] 
     asqer[:email] = params[:email]
     asqer[:name] = params[:name]
     asqer[:phone] = params[:phone]
     asqer[:content] = params[:content]
     UserMailer.posts_email(asqer).deliver
    end
     redirect root_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
       redirect_to(root_path) unless current_user.admin?
    end
end
