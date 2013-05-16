# -*- encoding : utf-8 -
class ContractsController < ApplicationController

before_filter :correct_code, only: [:valid, :close, :update, :destroy]

  def index
    ind = params[:in]
    outd = params[:out]

    unless ind.nil? || outd.nil? || ind.empty? || outd.empty? 
      @contracts = Contract.
                 where(:active => true, :close_contract => false).
                 where(:date_rent => ind.to_date.beginning_of_day..outd.to_date.end_of_day).
                 paginate(page: params[:page])
    else
      @contracts = Contract.
                 where(:active => true, :close_contract => false).
                 where(["date_rent >= ?", Time.now]).
                 paginate(page: params[:page])
    end
  end


  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(params[:contract])
    if @contract.save
#    Tell the UserMailer to send validation email to contractor_email
      UserMailer.activate_contract_email(@contract).deliver
      flash[:success] = "Ваш заказ предварительно принят. Вам на email отправлено письмо. Прочитайте его и подтвердите заказ."
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
         @offer = @current_user.offers.build(:contract_id => @contract.id)
       end
      else
       @offers = @contract.offers.where(:taken => true)
      end

  end

  def edit
     @contract = Contract.find(params[:id])
  end

  def update
   unless @contract.offers.any?
    if correct_code && @contract.update_attributes(params[:contract])
      flash[:success] = "Pre order updated"
      redirect_to @contract
    else
      render 'edit'
    end
   else
     flash[:error] = "Заказ разрешается редактировать только до первого предложения."
     redirect_to @contract
   end
  end

  def valid
    if correct_code
      @contract.toggle!(:active)
      flash[:success] = "Заказ подтвержден. Потенциальным исполнителям выслана информация."
      UserMailer.info_email(@contract)
    end
      redirect_to @contract || root_path
  end

  def close
     if correct_code
       @contract.toggle!(:close_contract)
       flash[:success] = "Заказ закрыт."
     end
       redirect_to @contract || root_path
  end

  def destroy
    if correct_code
      Contract.find(params[:id]).destroy
      flash[:success] = "Заказ удален."
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
       if (params[:q] == @contract.created_at.to_i.to_s.split('').reverse.join[0..3]) || (!current_user.nil? && current_user.admin?)
         return true
       else
         flash[:error] = 'Ошибка в Пин-коде.'
         return false
       end
     else
       redirect_to root_path
     end
  end
end
