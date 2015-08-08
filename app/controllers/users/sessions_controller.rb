class Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, except: :create
  respond_to :html, :json

  def create
    byebug
    super
  end
end
