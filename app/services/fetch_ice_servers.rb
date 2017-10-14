require 'rest-client'
require 'json'

# Get ICE STUN and TURN list
class FetchIceServers
  def initialize(room_id)
    @room_id = room_id
  end

  def run
    broadcast_list(ice_server_list)
  end

  def ice_server_list
    response = RestClient.put ENV['GET_XIRSYS_ICE'], accept: :json
    response
  end

  def broadcast_list(response)
    ActionCable.server.broadcast "ice_#{@room_id}", response
  end
end
