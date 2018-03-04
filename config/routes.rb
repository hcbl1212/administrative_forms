Rails.application.routes.draw do
    root to: 'employees#new'
    devise_for :employees, :controllers => { :registrations => "employees" }
    get 'system_access_request_external_action', to: 'system_access_requests#external_action'
    resources :system_access_requests
    resources :employees, only: [:index]
    resources :employees do
        get 'pending_system_access_requests', to: 'system_access_requests#pending'
        get 'not_pending_system_access_requests', to: 'system_access_requests#not_pending'
    end
    resources :resources
end
