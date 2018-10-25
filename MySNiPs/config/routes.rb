Rails.application.routes.draw do
  get 'genes/import_from_file'
  get 'genotypes/import_from_file'

  get 'genes/create'
  get 'genotypes/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  root 'welcome#index'
end
