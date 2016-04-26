class SiteController < ApplicationController

  def users_home
    check_log_session
  end

  def companies_home
    check_log_session
  end

  def employees_home
    check_log_session
  end

  def activity_user_nike
  api_response = Site.all_activities_nike
  render json: api_response, status: 201
  end

  def activity_user_runtastic
  api_response = Site.all_activities_runtastic
  render json: api_response, status: 201
  end

  private

  def check_log_session
    if user_signed_in?
      redirect_to user_path(current_user)
    elsif company_signed_in?
     redirect_to company_path(current_company)
    elsif employee_signed_in?
     redirect_to employees_validate_path
    end
  end

end
