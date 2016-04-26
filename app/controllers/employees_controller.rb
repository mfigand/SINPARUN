class EmployeesController < ApplicationController
  layout "employees"

  def index
    @branch = Branch.find(params[:branch_id])
    @employees = @branch.employees
  end

  def new
    @branch = Branch.find(params[:branch_id])
    @employee = Employee.new
  end

  def create
    @branch = Branch.find(params[:branch_id])
    @employee = Employee.new employee_params
    @employee.branch_id = params[:branch_id]
    if @employee.save
      flash[:notice] = "Employee created succesfully"
      redirect_to company_branch_employees_path(current_company.id,params[:branch_id])
    else
      flash[:alert] = "ALERT Employee not created"
      render 'new'
    end
  end

  def show
    @branch = Branch.find(params[:branch_id])
    @employee = Employee.find(params[:id])
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to company_branch_employees_path(current_company.id,params[:branch_id])
  end

  private

  def employee_params
   params.require(:employee).permit(:name, :email, :password, :phone)
  end


end
