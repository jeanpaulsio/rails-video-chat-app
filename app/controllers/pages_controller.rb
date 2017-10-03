class PagesController < ApplicationController
  def home
    @room = Room.new
  end
end
