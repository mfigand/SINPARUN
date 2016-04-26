class CompaniesController < ApplicationController
  layout "companies"

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes company_params
      redirect_to action: :index
    else
      render "edit"
    end
  end

  def show
    @company = Company.find(params[:id])
    @branches = @company.branches
    @rewards = @company.rewards
  end

  def branches_map
    @company = Company.find(params[:company_id])
    @branches = @company.branches
  end

  private

  def company_params
   params.require(:company).permit(:name, :email, :password, :password_confirmation)
  end

end
