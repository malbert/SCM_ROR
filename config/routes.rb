ScmRor::Application.routes.draw do
  resources :events

  resources :posts

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  match '/logout' => 'user_sessions#destroy'
  
  resources :clubs

  get "session/user_session"
  get "public/index"

  root :to => "public#index"
  
  resources :languages
  resources :users
  resource :user_sessions, :controller => :user_sessions_controller
  resource :user_session
  resource :clubs
  
  resource :membergrades do
    get 'delete'
  end

  resources :members do
    resources :arts do
      get 'generate_gradeform'
    end
  end
  
  resources :arts do
    resources :grades
  end
  
  match "/dashboard" => "dashboard#show"
  match "/contactus" => "public#contactus"

  resources :clubs do
    resources :arts do
      get 'disable'
    end
    resources :members do
      get 'member'
      get 'show'
    end
    resources :events do
      get 'events'
      get 'events_future'
    end
    member do
      get 'new_member'      
    end
    get 'edit_public'
    put 'update_public'
    get 'edit_arts'
  end
  
  # root :controller => :users, :action => :index
end
