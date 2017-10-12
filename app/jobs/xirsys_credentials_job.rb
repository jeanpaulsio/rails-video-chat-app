require 'rest-client'
require 'json'

# API Calls to xirsys.com
class XirsysCredentialsJob < ApplicationJob
  queue_as :default

  def perform(room_id)
    response = RestClient.put ENV['GET_XIRSYS_ICE'], accept: :json
    ActionCable.server.broadcast "ice_#{room_id}", response
  end
end
