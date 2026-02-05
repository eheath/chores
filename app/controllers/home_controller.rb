class HomeController < ApplicationController
  def index
    @chores = current_user.chores.order("title").all
  end
end
