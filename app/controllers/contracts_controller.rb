class ContractsController < ApplicationController

before_filter :correct_code, only: [:valid, :close, :update, :destroy]

  def index
    @contracts = Contract.
                 where(:active => true, :close_contract => false).
                 where(["date_rent >= ?", Time.now]).
                 paginate(page: params[:page])
  end


  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(params[:contract])
    if @contract.save
#    Tell the UserMailer to send validation email to contractor_email
      UserMailer.activate_contract_email(@contract).deliver
      flash[:success] = "Pre order made. Read email and valid contract"
      redirect_to @contract
    else
      render 'new'
    end
  end

  def show
    @contract = Contract.find(params[:id])
    unless @contract.close_contract?
       @offers = @contract.offers.all

       if signed_in?
         @offer = @current_user.offers.build(:contract_id => @ccontract.id)
       end

    else
       @offers = @contract.offers.where(:taken => true)
    end
  end

  def edit
     @contract = Contract.find(params[:id])
  end

  def update
    if correct_code && @contract.update_attributes(params[:contract])
      flash[:success] = "Pre order updated"
      redirect_to @contract
    else
      render 'edit'
    end

  end

  def valid
    if correct_code
      @contract.toggle!(:active)
      flash[:success] = "Now the pre order is active."
    end
      redirect_to @contract || root_path
  end

  def close
     if correct_code
       @contract.toggle!(:close_contract)
       flash[:success] = "Now the pre order is finish"
     end
       redirect_to @contract || root_path
  end

  def destroy
    if correct_code
      Contract.find(params[:id]).destroy
      flash[:success] = "Pre order destroyed."
      redirect_to contracts_url
    else
      redirect_to @contract || root_path
    end
  end

private

# функция возвращает TRUE если текущий юзер админ или код активации верен
  def correct_code
    @contract = Contract.find(params[:id])
     unless @contract.nil?
       if (params[:q] == @contract.created_at.to_i.to_s.split('').reverse.join[0..5]) || (!current_user.nil? && current_user.admin?)
         return true
       else
         flash[:error] = 'Incorrect code activation.'
         return false
       end
     end
  end
end
