Viento::Application.routes.draw do

  root to: 'start#index'

  devise_for :users,
             # :path_prefix => 'auth',
             path_names: {sign_in: "login", sign_out: "logout"},
             controllers: {
              registrations: 'registrations',
              #omniauth_callbacks: "omniauth_callbacks"
             }

  resources :users


  resources :sales do
    get 'filter', on: :collection
  end

  resources :pieces do
    get 'copy', on: :member
    get 'find', on: :collection
    resources :sales
  end

  resources :clients do
    get 'find', on: :collection
    get 'export', on: :collection
    resources :sales
  end

  # Analysis routes

  match 'analysis' => 'analysis#index', as: :analysis_menu
  match 'analysis/size' => 'analysis#by_size', as: :analysis_size
  match 'analysis/color' => 'analysis#by_color', as: :analysis_color
  match 'analysis/fabric' => 'analysis#by_fabric', as: :analysis_fabric
  match 'analysis/collection' => 'analysis#by_collection', as: :analysis_collection

  resources :emails, :only => [:new, :create]

end
