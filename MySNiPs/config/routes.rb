Rails.application.routes.draw do
  resources :genes
  resources :genotypes
  resources :cards
  resources :report
  root 'welcome#index'
  get 'welcome/index'

  constraints(:ip => /127.0.0.1/) do
    # Reads a file that will fill the Gene and Genoma table from a file
    get '/import' => 'import#from_file'

    # Test-purpose only signup page that adds a user to the database
    get 'signup' => 'signup#new', as: :new_signup
    # create (post) action for when sign up form is submitted:
    post 'signup' => 'signup#create'

    # Reads a file that will fill the Cards table from a file, using Gene and Genoma
    get '/match' => 'matches#make_report'

    get '/logout' => 'sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # log in page with form:
  get '/login'     => 'sessions#new'

  # create (post) action for when log in form is submitted:
  post '/login'    => 'sessions#create'

  # delete action to log out:
  delete '/logout' => 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      get '/users' => 'users#index'
      get '/users/:identifier' => 'users#show'
      get '/genomas/' => 'genomas#index'
      get '/genomas/:identifier' => 'genomas#show'
      post '/upload' => 'genomas#create'
      post '/authenticate', to: 'authentication#authenticate'
    end
  end
end
