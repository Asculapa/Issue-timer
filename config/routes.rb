Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :v1 do
    resources :users, only: [:create]
    resources :tasks

    # Auth
    post '/login', to: 'users#login'
    get "/auto_login", to: "users#auto_login"

    scope '/services' do
      get '/', to: 'services#index'
      get '/:id', to: 'services#show'
      post '/', to: 'services#create'
    end

    scope '/timer' do
      get '/', to: 'timers#index'
    end
  end
end
