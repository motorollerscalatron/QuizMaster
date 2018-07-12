Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',     to: 'static_pages#help'
  get  '/signup',   to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :challenge
    end
  end
  get '/questions/manage', to: 'questions#manage', as: :manage_questions
  resources :questions,  only: [:show, :new, :index, :create, :edit, :update, :destroy]
  resources :challenges, only: [:new, :create]
end
