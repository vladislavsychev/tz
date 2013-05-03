class OffersController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  before_filter :correct_code, only: :bang

  def show
     @offer = Offer.find(params[:id])
  end

  def create
#    store_location
    @contract = Contract.find(params[:offer][:contract_id])
    unless @contract.close_contract? 
      offer = current_user.offers.create(params[:offer])
       unless offer.id == nil
        UserMailer.new_offer_email(offer).deliver
        flash[:success] = "Your offer #{offer.id}, price #{offer.price} put on."
       else
        flash[:error] = "Your offer reject."
       end
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

  def bang
    offer_for_bang = Offer.find(params[:id])
    unless offer_for_bang.nil?
          o_taken = offer_for_bang.toggle!(:taken) 
          c_closed = offer_for_bang.contract.toggle!(:close_contract)
       if o_taken && c_closed
          UserMailer.offer_taken_email(offer_for_bang).deliver
          flash[:success] = "Bang! Offer taken. Pre order closed."
       else
          flash[:error] = "Wrong taken."
       end
       
       redirect_to offer_for_bang.contract

     else
        redirect_to root_path
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

    def correct_code
       redirect_to root_path unless params[:q] == Offer.find(params[:id]).contract.created_at.to_i.to_s.split('').reverse.join[0..3]
    end

end
