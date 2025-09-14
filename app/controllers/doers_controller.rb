class DoersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @doer = current_user.doers.new
  end

  def edit
  end

  def create
    @doer = current_user.doers.new(my_params)
    @doer.save
  end

  def destroy
  end

  private

  def my_params
    params.expect(doer: [:name, :phone])
  end
end
