class ChoresController < ApplicationController
  def index
  end

  def show
  end

  def new
    @chore = current_user.chores.new
  end

  def edit
    @chore = current_user.chores.detect{|c| c.id == params[:id].to_i}
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
    @chore = current_user.chores.detect{ |c| c.id == params[:id].to_i }
    if @chore.update(my_params)
      render :update
    else
      render :edit
    end
  end

  def destroy
    @chore = current_user.chores.detect{|c| c.id == params[:id].to_i}
    @chore.delete if @chore.present?
  end

  private

  def my_params
    params.expect(chore: [:title, :notes, :points, :days])
  end
end
