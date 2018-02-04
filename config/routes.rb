Rails.application.routes.draw do
  resources :employees
  resources :employees do
      resources :system_access_requests
  end
  root to: 'employees#new'
end
