# == Schema Information
#
# Table name: contracts
#
#  id                :integer          not null, primary key
#  t_car             :integer
#  city_rent         :string(99)
#  date_rent         :date
#  time_rent         :string(5)
#  lease_time        :integer
#  body_contract     :text
#  contractor_mphone :string(12)
#  contractor_email  :string(140)
#  contractor_name   :string(50)
#  active            :boolean          default(FALSE)
#  close_contract    :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Contract < ActiveRecord::Base
  attr_accessible :body_contract, :close_contract, :contractor_email, :contractor_mphone, :contractor_name, :date_rent, :time_rent, :lease_time, :t_car

  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+[\.\_\ ]{0,2}[a-zA-Z0-9]+[\.\_\ ]{0,2}[a-zA-Z0-9]+\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_MPHONE_REGEX = /\A\d{6,11}\z/
  VALID_T_CAR_REGEX = /\A\d{1,2}\z/
  VALID_LEASE_TIME_REGEX = /\A\d{1,2}\z/

  validates :contractor_email, format: { with: VALID_EMAIL_REGEX }
  validates :contractor_name, format: { with: VALID_NAME_REGEX }
  validates :contractor_mphone, format: { with: VALID_MPHONE_REGEX }
  validates :t_car, format: { with: VALID_T_CAR_REGEX }
  validates :lease_time, format: { with: VALID_LEASE_TIME_REGEX }
  validates :body_contract, presence: true, length: { maximum: 2048 }
  validates :date_rent, presence: true
  validates :time_rent, presence: true, length: { maximum: 5}

  before_save { |contract| contract.date_rent = date_rent.to_date }
  before_save { |contract| contract.contractor_email = contractor_email.downcase }

end
