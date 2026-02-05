class DoersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @doer = current_user.doers.new
  end

  def edit
    @doer = current_user.doers.active.find(params[:id])
  end

  def create
    @doer = current_user.doers.new(my_params)
    @doer.save
  end

  def update
    @doer = current_user.doers.active.find(params[:id])

    if @doer.update(my_params)
      render :update
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def my_params
    params.expect(doer: [ :name, :phone ])
  end
end
