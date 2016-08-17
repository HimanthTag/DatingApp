Datingapp::Application.routes.draw do
  

  # resources :relationship_interests


  # resources :user_settings


  resources :states


  resources :pokemongo_teams


  resources :ethnicities


  resources :profile_likes


  resources :user_messages do
    member do
      delete 'destroy', :as => "destroy_user_message"
      get 'message_conversation', :action=>'message_conversation', :as => "message_conversation"
    end
  end


  resources :user_friends


  resources :group_messages do
    member do
      get 'new_group_msg', :as => "new_group_msg"
      get 'new_group_msg_cmt', :as => "new_group_msg_cmt"
    end
  end


  resources :group_users


  resources :groups do
    member do
      get 'add_member'
      get 'add_member_to_group'
      put 'update_group_image'
    end
  end

  # resources :users do
  #   collection do
  #     #match 'search' => 'user#search', via: [:get, :post], as: :search
  #   end
  # end


  resources :relationships


  resources :genders


  resources :user_interests
  resources :interests

  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations",
    :passwords => "users/passwords",
    :sessions => "users/sessions"
  }

  resources :chat_conversations do
    resources :chat_messages
  end

  resources :landing do
    collection do
      get 'privacy'
    end
  end


  match 'users/:id/edit', :to => 'users#edit', :as => 'edit_user', :via => [:get]
  match 'users/:id', :to => 'users#update', :as => 'user', :via => [:put]

  match 'search' => 'user#search', via: [:get, :post], as: :search

  match 'users_list', :to => 'users#index', :as => 'users_list', :via => [:get]
  match 'pending_friends', :to => 'users#pending_friends', :as => 'pending_friends', :via => [:get]
  match 'add_friend', :to => 'users#add_friend', :as => 'add_friend', :via => [:get]
  match 'view_user/:id', :to => 'users#show', :as => 'view_user', :via => [:get]
  match 'settings', :to => 'users#settings', :as => 'settings', :via => [:get]
  match 'update_settings', :to => 'users#update_settings', :as => 'update_settings', :via => [:post]
  

  match 'make_profile_picture', :to => 'users#make_profile_picture', :as => 'make_profile_picture', :via => [:get]
  match 'delete_image', :to => 'users#delete_image', :as => 'delete_image', :via => [:get]
  match 'check_email_availability', :to => 'users#check_email_availability', :as => 'check_email_availability', :via => [:get]  

  match 'accept_friend', :to => 'user_friends#accept_friend', :as => 'accept_friend', :via => [:get]
  match 'accept_new_friend', :to => 'users#accept_new_friend', :as => 'accept_new_friend', :via => [:get]
  match 'remove_friend', :to => 'user_friends#remove_friend', :as => 'remove_friend', :via => [:get]
  match 'remove_sent_request', :to => 'user_friends#remove_sent_request', :as => 'remove_sent_request', :via => [:get]  

  match 'like_profile', :to => 'profile_likes#like_profile', :as => 'like_profile', :via => [:get]

  match 'new_user_msg', :to => 'user_messages#new_user_msg', :as => 'new_user_msg', :via => [:get]
  
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'landing#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
