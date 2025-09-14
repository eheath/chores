class ChoresController < ApplicationController
  def index
  end

  def show
  end

  def new
    @chore = current_user.chores.new
  end

  def edit
  end

  def create
    @chore = current_user.chores.new(my_params)
    @chore.save
  end

  def destroy
  end

  private

  def my_params
    params.expect(chore: [:title, :notes, :points])
  end
end
