Mathorg::Application.routes.draw do
  get "static_pages/ratings_guide"
  root "explanations#index"

  get "ratings_guide" => "static_pages#ratings_guide" 
  post "services/preview" => "services#preview"
  get "search/results"
  get "search" => "search#index"

  post "upvote"   => "votables#upvote"
  post "downvote" => "votables#downvote"
  post "rate"     => "votables#rate"

  get "feedback" => "feedbacks#index"
  resources :feedbacks do 
  end

  get "topicables/edit_topic_list"
  patch "topicables/update_topic_list"

  devise_for :users
  resources :users, :only => [:show]
  post "users/delete_notification"

  resources :problem_sets

  resources :topics do
    get :autocomplete_topic_name, on: :collection
  end

  resources :explanations

  resources :comments
  
  resources :problems do 
    post "merge"
    get "mark"
    resources :solutions do
      member do
        get :comments
      end
    end
  end

  mathjax 'mathjax'

  #get 'topics/:id' => 'topics#show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
