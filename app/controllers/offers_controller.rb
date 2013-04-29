class OffersController < ApplicationController

  before_filter :signed_in_user

  def create
    store_location
    @contract = Contract.find(params[:offer][:contract_id])
    @offer = current_user.offers.build(params[:offer]) unless current_user.nil?
    if @offer.save
      flash[:success] = "Your offer put in."
    else
      flash[:error] = "Something wrong! Your offer reject."
    end 
    redirect_to @contract
  end

  def destroy
    if !current_user.nil? && current_user.admin?
    end
  end
end
