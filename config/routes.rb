Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants do
    collection do 
      get :search, :action => 'search', :as => 'search'
    end
  end
  resources :comments, :users
end
