class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_many :favorites

  def email_required?
    false
  end
end
