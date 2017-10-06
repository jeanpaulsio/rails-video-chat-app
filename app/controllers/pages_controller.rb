class PagesController < ApplicationController
  def home
    redirect_to rooms_path if user_signed_in?
    @room = Room.new
  end
end
