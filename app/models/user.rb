# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  mphone     :string(255)
#  raiting    :integer
#  admin      :boolean
#  moderator  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :admin, :email, :moderator, :mphone, :name, :raiting, :password, :password_confirmation 
  
  has_secure_password

  before_validation :make_name
 
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+[\.\_\ ]{0,2}[a-zA-Z0-9]+[\.\_\ ]{0,2}[a-zA-Z0-9]+\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_MPHONE_REGEX = /\A\d{6,11}\z/

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :mphone, presence: true, format: { with: VALID_MPHONE_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }  
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }

  private
   def make_name
     self.name = email.split('@').first.upcase if name.empty?
     if self.name.size < 4
       self.name += ".Zi"
     end
   end
end

