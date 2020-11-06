Rails.application.routes.draw do
  # get 'Deck/new'
  # get 'Deck/draw'
  # get 'Deck/show'
  # get 'Deck/create'
  # get 'Deck/delete'
  # get 'Deck/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :room do
    resources :deck
  end
  root :to => redirect('/room')
end
