class User < ActiveRecord::Base
  attr_accessible :admin, :email, :moderator, :mphone, :name, :raiting
end
