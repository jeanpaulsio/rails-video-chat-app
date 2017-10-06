require 'rest-client'
require 'json'

# :nodoc:
class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_user
  before_action :set_room, only: %i[show edit update destroy
                                    toggle_status claim authenticate]

  def authenticate
    if params[:thingy] == @room.password
      flash[:success] = 'Correct Password'
      redirect_to action: 'show', thingy: params[:thingy]
    else
      flash[:notice] = 'INCORRECT PASSWORD'
    end
  end

  def index
    @rooms = @user.rooms
    @all_rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = 'Invite by sharing this link: ' \
                        "#{request.original_url}/#{@room.slug}"
      redirect_to @room
    else
      flash[:notice] = 'Sorry, that room is taken!'
      redirect_to root_path
    end
  end

  def show
    ask_for_password(@room, params[:thingy]) unless @room.password.nil? || @room.user == current_user

    response       = RestClient.put ENV['GET_XIRSYS_ICE'], accept: :json
    @json_response = response.to_json
  end

  def toggle_status
    if (@user.is_a? GuestUser) || (@room.user != @user)
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

    if @user.is_a? GuestUser
      flash[:notice] = 'You must register to claim this room!'
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

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.friendly.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :user_id)
  end

  def ask_for_password(room, password = nil)
    render 'rooms/authenticate' unless password == room.password
  end
end
