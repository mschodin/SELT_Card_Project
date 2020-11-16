Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :room do
    resources :pile do
      post 'deck', to:'deck#create'
    end
    resources :deck do
      get 'draw', to:'deck#draw'
    end
  end
  root :to => redirect('/room')
  post 'room/join'
end
