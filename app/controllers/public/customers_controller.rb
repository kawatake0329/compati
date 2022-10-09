class Public::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer), notice: '編集成功.'
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction, :email, :password)
  end
end
