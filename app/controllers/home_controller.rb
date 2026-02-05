class HomeController < ApplicationController
  def index
    @chores = current_user.chores.active.order("title")
    @doers = current_user.doers.active.order("name")
  end
end
