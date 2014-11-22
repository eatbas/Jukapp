class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_many :favorites
  has_one  :room

  def email_required?
    false
  end
end
