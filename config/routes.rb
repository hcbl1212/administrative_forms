Rails.application.routes.draw do
    root to: 'employees#new'
    devise_for :employees, :controllers => { :registrations => "employees" }
    resources :employees, only: [:index]
    resources :system_access_requests
    resources :employees do
        get 'pending_system_access_requests', to: 'system_access_requests#pending'
        get 'not_pending_system_access_requests', to: 'system_access_requests#not_pending'
    end
    resources :resources
end
