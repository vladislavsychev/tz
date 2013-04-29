# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  mphone          :string(255)
#  raiting         :integer
#  admin           :boolean
#  moderator       :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :mphone, :name, :raiting, :password, :password_confirmation 
    
  has_secure_password

  has_many :offers, :dependent => :destroy, :order => 'offers.created_at DESC'
  has_many :contracts, :through => :offers, :readonly => true
#  has_many :photos, :dependent => :destroy

  before_validation :make_name
  before_validation { self.password_confirmation = password if password_confirmation.empty? }
 
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+[\.\_\ ]{0,2}[a-zA-Z0-9]+[\.\_\ ]{0,2}[a-zA-Z0-9]+\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_MPHONE_REGEX = /\A\d{6,11}\z/

  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, format: { with: VALID_NAME_REGEX }
  validates :mphone, format: { with: VALID_MPHONE_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }  
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  private

   def make_name
     self.name = email.split('@').first.to_s.upcase if name.empty? || name.blank?
     if self.name.to_s.size < 4
       self.name = self.name.to_s + ".Zi"
     end
   end

   def create_remember_token
     self.remember_token = SecureRandom.urlsafe_base64
   end

end

