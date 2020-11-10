Rails.application.routes.draw do
  # get 'deck/new'
  # get 'deck/draw'
  # get 'deck/show'
  # get 'deck/create'
  # get 'deck/delete'
  # get 'deck/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :room do
    resources :deck do
      get 'draw', to:'deck#draw'
    end
  end
  root :to => redirect('/room')
end
