# == Schema Information
#
# Table name: offers
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  user_id     :integer
#  price       :integer
#  adword      :string(255)
#  taken       :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Offer < ActiveRecord::Base
  attr_accessible :adword, :price, :contract_id

  belongs_to :user
  belongs_to :contract

#  default_scope :order => 'offers.price DESC'

# полагаю что цена не будет меньше трех цифр и больше 6  
  VALID_PRICE_REGEX = /\A\d{3,6}\z/

  validates :price, format: { with: VALID_PRICE_REGEX }
  validates :adword, length: { maximum: 140 } 
  validates :contract_id, presence: true
  validates :user_id, presence: true  

end
