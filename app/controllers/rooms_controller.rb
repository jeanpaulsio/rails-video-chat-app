require 'rest-client'
require 'json'

# :nodoc:
class RoomsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, only: %i[index edit new update]
  before_action :set_room,           only: %i[show edit update destroy
                                              toggle_status claim authenticate]
  rescue_from ActiveRecord::RecordNotFound, with: :room_not_found
  rescue_from SocketError, with: :socket_error

  def authenticate
    password_hash = @room.check_hashed_password(@room.password)

    if password_hash == params[:password]
      flash[:success] = "You are now in the room: #{@room.name}"
      redirect_to action: 'show', password: password_hash
    else
      flash[:notice] = 'You entered the incorrect password!'
    end
  end

  def index
    @rooms = @user.rooms
  end

  def new
    @room = Room.new
  end

  # TODO refactor this into an API controller
  def create
    @room = Room.new(room_create_params)

    respond_to do |format|
      if @room.save
        format.html do
          flash[:success] = 'You created a room!'
          redirect_to @room
        end

        format.json { render :show, status: :created, location: @room }
      else
        format.html do
          flash[:notice] = 'Sorry, that room is taken!'
          redirect_to root_path
        end

        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    unless @room.user == current_user
      flash[:notice] = 'You cannot edit this room'
      redirect_to @room
    end
  end

  def update
    if @room.update_attributes(room_update_params)
      flash[:success] = 'You added a password to this room'
    else
      flash[:notice] = 'Something went wrong'
    end

    redirect_to @room
  end

  def show
    ask_for_password(@room, params[:password]) unless
      @room.password.nil? ||
      @room.user == current_user

    if @room.password
      flash.now[:notice] = 'This is a password protected room'
    end

    return if Rails.env == 'test'
    XirsysCredentialsJob.perform_later(@room.slug)
  end

  def toggle_status
    if (@user.is_a? GuestUser) ||
       (@room.user != @user) ||
       (params[:status] == 'restricted')
      flash[:notice] = 'You are not allowed to do that!'
      redirect_to @room
      return
    end

    @room.status = params[:status]
    @room.save
    flash[:notice] = 'Room status updated'
    redirect_to @room
  end

  def claim
    if @room.user || (@user.is_a? GuestUser)
      flash[:notice] = 'You are not allowed to do that!'
      redirect_to @room
      return
    end

    claim_room
  end

  private

  def set_user
    @user = current_user
  end

  def set_room
    @room = Room.friendly.find(params[:id])
  end

  def room_create_params
    params.require(:room).permit(:name, :user_id, :password)
  end

  def room_update_params
    params.require(:room).permit(:password)
  end

  def ask_for_password(room, password = nil)
    render 'rooms/authenticate' unless password == room.password
  end

  def claim_room
    @room.user   = current_user
    @room.status = 'unrestricted'
    @room.save
    flash[:success] = 'Room claimed'
    redirect_to @room
  end

  def room_not_found
    flash[:notice] = 'That room does not exist, would you like to create it?'
    redirect_to new_room_path
  end

  def socket_error
    flash[:notice] = 'TODO: Something went wrong with the WebRTC stuff'
    redirect_to root_path
  end
end
