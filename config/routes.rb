Blog::Application.routes.draw do
  resources :sales

  resources :pieces do
    get 'copy', on: :member
    get 'find', on: :collection
    resources :sales
  end

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root to: 'seed#index'

  resources :clients do
    get 'find', on: :collection
    resources :sales
  end

end
