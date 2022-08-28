class Master::CustomerController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.save
      redirect_to master_post_path, notice: "編集完了しました"
    else
      @customer = Customer.find(params[:id])
      render 'edit'
    end
  end

  private


end
