class PingsController < ApplicationController
  newrelic_ignore :only => :ping

  def ping
    head :ok
  end
end
