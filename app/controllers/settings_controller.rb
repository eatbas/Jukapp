class SettingsController < ApplicationController
  def index
    @rooms = Room.all
  end
end
