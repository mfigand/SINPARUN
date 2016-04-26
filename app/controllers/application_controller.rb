class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if user_signed_in?
      user_path(current_user.id)
    elsif company_signed_in?
     company_path(current_company.id)
   elsif employee_signed_in?
     employees_validate_path
   end
 end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:name, :avatar)
    end

end
