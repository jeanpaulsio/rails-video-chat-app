# :nodoc:
class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy
                                    toggle_status claim]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
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

  def toggle_status
    unless @room.user == current_user
      flash[:notice] = 'You must own this room to do that!'
      redirect_to @room
      return
    end

    @room.status = params[:status]
    @room.save
    flash[:notice] = 'Room status updated'
    redirect_to @room
  end

  def claim
    if @room.user
      flash[:notice] = 'Room has been taken'
      redirect_to @room
      return
    end

    @room.user   = current_user
    @room.status = 'unrestricted'
    @room.save
    flash[:success] = 'Room claimed'
    redirect_to @room
  end

  private

  def set_room
    @room = Room.friendly.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :user_id)
  end
end
