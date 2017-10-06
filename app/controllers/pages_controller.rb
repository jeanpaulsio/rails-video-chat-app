class PagesController < ApplicationController
  def home
    redirect_to rooms_path unless current_user.is_a? GuestUser
    @room = Room.new
  end
end
