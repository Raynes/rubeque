Rubeque::Application.routes.draw do
  resources :following, only: [:create, :destroy]

  resources :votes

  resources :users, only: :index
  namespace :user do
    root :to => "problems#index"
  end

  resources :problems do
    get 'unapproved', on: :collection
    put 'approve', on: :member

    resources :solutions, except: [:new] do
      get "share", on: :collection
    end
  end

  resources :audits

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  resources :settings, only: [:edit, :update] do
    get "edit", on: :collection
    put "update", on: :collection
  end

  get "static/index"
  match 'help' => 'static#help', :via => :get, :as => :help
  match 'problem_submission' => "static#problem_submission", via: :get, as: "submission_help"

  root to: "static#home"
end
