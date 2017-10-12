class IceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ice_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
