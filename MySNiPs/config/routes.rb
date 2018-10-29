Rails.application.routes.draw do
  get 'pages/secret'
  get 'genes/import_from_file'
  get 'genotypes/import_from_file'

  get 'genes/create'
  get 'genotypes/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  root 'welcome#index'

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
