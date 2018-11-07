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

  get '/api/v1/users' => 'users#index'
  get '/api/v1/users/:identifier' => 'users#show'
  get '/api/v1/genomas/' => 'genomas#index'
  get '/api/v1/genomas/:identifier' => 'genomas#show'
  post '/api/v1/upload' => 'genomas#create'
  post '/api/v1/authenticate', to: 'authentication#authenticate'

  # app.post '/api/v1/authenticate', params: {"identifier":"001","password":"654654"}
  # app.response.body
  # app.get '/api/v1/genomas/', { params:{}, headers: {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1NDE4MjAzMzZ9.GN79Z6B_Uyzfrq4mUD-w1NUvhe5P8b0Wb1GyOaJ84Uc"}}
  # app.post '/api/v1/upload', { params:{identifier: "0000002"}, headers: {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1NDE4MjAzMzZ9.GN79Z6B_Uyzfrq4mUD-w1NUvhe5P8b0Wb1GyOaJ84Uc"}}

  # curl -H "Content-Type: application/json" -X POST -d '{"identifier":"001", "password":"654654"}' http://localhost:3000/api/v1/authenticate
  # curl -H "Content-Type: application/json" -H "Authorization: eyJhbGciOiJIUzI1/genomas1c2VyX2lkIjoyLCJleHAiOjE1NDE4MTg2MzZ9.JkPxB0zeMtw75oSTE8hbYVtid_utB6ogWV08woQ9Hms" http://localhost:3000/api/v1/genomas

end
