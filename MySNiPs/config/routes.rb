Rails.application.routes.draw do
  resources :genes
  resources :genotypes
  root 'welcome#index'
  get 'welcome/index'
  constraints(:ip => /127.0.0.1/) do
    get 'pages/secret'
    get 'import/genes' => 'genes#import'
    get 'import/genotypes' => 'genotypes#import'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # log in page with form:
  get '/login'     => 'sessions#new'
  # create (post) action for when log in form is submitted:
  post '/login'    => 'sessions#create'
  # delete action to log out:
  delete '/logout' => 'sessions#destroy'
  get 'users/new' => 'users#new', as: :new_user
  # create (post) action for when sign up form is submitted:
  post 'users' => 'users#create'
end
