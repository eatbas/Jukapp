class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  attr_accessible :username

  def email_required?
    false
  end
end
