class Master::SpecsController < ApplicationController

  def index
    @spec = Spec.new
    @specs = Spec.all
  end

  def create
    @spec = Spec.new(spec_params)
    if @spec.save
      redirect_to master_specs_path
    else
      redirect_to request.referer
    end
  end

  def edit
    @spec = Spec.find(params[:id])
  end

  def update
    @spec = Spec.find(params[:id])
    if @spec.update(spec_params)
      redirect_to master_specs_path
    else
      render 'edit'
    end
  end

  def destroy
    @spec = Spec.find(params[:id])
    if @spec.destroy
      redirect_to master_specs_path
    else
      render 'index'
    end
  end

  private

  def spec_params
    params.require(:spec).permit(:name)
  end
end
