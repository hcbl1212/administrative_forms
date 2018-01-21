Rails.application.routes.draw do
  resources :employees
  resources :employess do
      resources :system_access_requests
  end
  root to: 'employees#new'
end
