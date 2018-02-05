Rails.application.routes.draw do
    root to: 'employees#new'
    devise_for :employees, :controllers => { :registrations => "employees" }
    resources :employees
    resources :system_access_requests
    resources :employees do
        resources :system_access_requests
    end
end
