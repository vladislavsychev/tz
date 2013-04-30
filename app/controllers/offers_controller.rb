class OffersController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    store_location
    @contract = Contract.find(params[:offer][:contract_id])
    if !@contract.close_contract? && current_user.offers.create(params[:offer])
       flash[:success] = "Your offer put on."
    else
       flash[:error] = "Your offer reject."
    end 
    redirect_to @contract
  end

  def destroy
    @offer.destroy
    if current_user.admin? 
      redirect_to @offer.contract  
    else
      redirect_to current_user
    end
  end

private

    def correct_user
        if current_user.admin?
          @offer = Offer.find_by_id(params[:id])
        else 
          @offer = current_user.offers.find_by_id(params[:id])
        end
      redirect_to root_url if @offer.nil? || @offer.contract.close_contract?
    end

end
