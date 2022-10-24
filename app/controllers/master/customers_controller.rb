class Master::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to master_customer_path, notice: "編集完了しました"
    else
      @customer = Customer.find(params[:id])
      render 'edit'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction, :email, :password, :deleted_user)
  end

end
