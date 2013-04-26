class ContractsController < ApplicationController
  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(params[:contract])
    if @contract.save
#    Tell the UserMailer to send validation email to contractor_email
      flash[:success] = "OK. Contract made. Read email and valid contract"
      redirect_to @contract
    else
      render 'new'
    end
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def valid
   @contract = Contract.find(params[:contract_id])
   if params[:q] == @contract.created_at.to_i.to_s.split('').reverse.join[0..5]
     @contract.toggle!(:active)
     flash[:success] = "OK. Now the contract is active. Good luck!"
     redirect_to @contract
   else
     flash[:error] = "Wrong number. Lets try more?"
     redirect_to @contract
   end
  end
end
