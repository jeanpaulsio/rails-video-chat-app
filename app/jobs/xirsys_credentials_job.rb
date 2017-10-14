require 'rest-client'
require 'json'

# API Calls to xirsys.com
class XirsysCredentialsJob < ApplicationJob
  queue_as :default

  def perform(room_id)
    FetchIceServers.new(room_id).run
  end
end
