class ChoresController < ApplicationController
  def index
  end

  def show
  end

  def new
    @chore = current_user.chores.new
  end

  def edit
    @chore = current_user.chores.active.find(params[:id])
  end

  def create
    @chore = current_user.chores.new(my_params)
    if @chore.save
      render :create
    else
      render :new
    end
  end

  def update
    @chore = current_user.chores.active.find(params[:id])
    if @chore.update(my_params)
      render :update
    else
      render :edit
    end
  end

  def destroy
    @chore = current_user.chores.active.find(params[:id])
    @chore.destroy
  end

  private

  def my_params
    params.expect(chore: [ :title, :notes, :points, :days ])
  end
end
