Rails.application.routes.draw do
  get 'games/new', to: 'games#new', as: 'new_game'
  post 'games/score', to: 'games#score'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
