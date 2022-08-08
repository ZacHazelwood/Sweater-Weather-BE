Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      get '/munchies', to: 'munchies#index'
    end
  end
end
