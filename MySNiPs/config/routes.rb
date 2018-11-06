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
    get 'users/new' => 'users#new', as: :new_user
    # create (post) action for when sign up form is submitted:
    post 'users' => 'users#create'

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

  get '/api/v1/users' => 'users#index'
  get '/api/v1/users/:id' => 'users#show'
  get '/api/v1/genomas/' => 'genomas#index'
  get '/api/v1/genomas/:id' => 'genomas#show'
  post '/api/v1/upload' => 'genomas#create'
  post '/api/v1/authenticate', to: 'authentication#authenticate'

  # app.post '/authenticate', params: {"email":"example@mail.com","password":"123123123"}
  # app.response.body
  # app.get '/items', { params:{}, headers: {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDQwNjQ2NzB9.XrBdfItP9KIejiAUtl4rE1tPjWbB3yva1zNdtGq6iUM"}}

end
