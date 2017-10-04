# :nodoc:
class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = current_user.rooms
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = "You created the room: #{@room.name}!"
      redirect_to @room
    else
      flash[:notice] = 'Sorry, that room is taken!'
      redirect_to root_path
    end
  end

  def show; end

  private

  def set_room
    @room = Room.friendly.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
