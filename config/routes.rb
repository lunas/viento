Blog::Application.routes.draw do
  resources :pieces

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root to: 'seed#index'

  resources :clients

end
