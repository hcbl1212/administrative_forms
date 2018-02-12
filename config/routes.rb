Rails.application.routes.draw do
  namespace :admin do
    resources :employees
    resources :departments
    resources :groups
    resources :resources
    resources :roles
    resources :signatures
    resources :softwares
    resources :software_roles
    resources :system_access_fields
    resources :system_access_requests
    resources :system_access_request_departments
    resources :system_access_request_groups
    resources :system_access_request_softwares
    resources :system_access_request_system_access_fields

    root to: "employees#index"
  end

    root to: 'employees#new'
    devise_for :employees, :controllers => { :registrations => "employees" }
    resources :employees
    resources :employees do
        get 'pending_system_access_requests', to: 'system_access_requests#pending'
        get 'not_pending_system_access_requests', to: 'system_access_requests#not_pending'
    end
    resources :resources
end
