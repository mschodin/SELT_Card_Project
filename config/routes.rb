Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :room do
    get 'leave', to:'room#leave'
    #try 'card/:card_id' and use /card/53?deck_id=3
    post 'card/:card_id/to_deck/:deck_id', to:'room#move_card'
    post 'card/:card_id/to_pile/:pile_id', to:'room#move_card'
    post 'card/:card_id/to_gamehand/:gamehand_id', to:'room#move_card'

    resources :pile do
      post 'deck', to:'deck#create'
    end
    resources :deck do
      get 'draw', to:'deck#draw'
    end
  end
  root :to => redirect('/room')
  post 'room/join'
  # get 'room/leave'
end
