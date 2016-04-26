Rails.application.routes.draw do
  devise_for :employees
  devise_for :companies
  devise_for :users

  root to: "site#users_home"

  get '/users', to: 'site#users_home'
  get '/companies', to: 'site#companies_home'
  get '/employees', to: 'site#employees_home'
  get '/api_sinparun/nike', to: 'site#activity_user_nike'
  get '/api_sinparun/runtastic', to: 'site#activity_user_runtastic'

  get '/users/sync_account/nike', to: 'users#sync_account_nike'
  get '/users/sync_account/runtastic', to: 'users#sync_account_runtastic'
  get '/users/check_id_activity', to: 'users#check_id_activity'
  get '/users/branches_map/:company_id', to: 'users#branches_map', as: 'users_branches_map'

  get '/branches_map/:company_id', to: 'companies#branches_map', as: 'branches_map'

  get '/employees/validate', to: 'employees#validate'
  get '/validate_response', to: 'employees#validate_response'

  get '/users/rewards', to: 'rewards#all_rewards'

  get '/search_coupon', to: 'coupons#search_coupon'
  get '/users/rewards_map', to: 'coupons#rewards_map'
  get '/users/edit_coupon/:id', to: 'coupons#edit_coupon', as: 'edit_coupon'

  resources :users do
    resources :races, :coupons
  end

  resources :companies do
    resources :branches, :rewards do
      resources :rewards, :employees
    end
  end

  resources :employees do
    resources :coupons
  end

end
