Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :schools do
      resources :tracks
      resources :courses
  end
end