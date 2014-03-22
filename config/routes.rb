# -*- encoding : utf-8 -*-
CabApp::Application.routes.draw do

  get "vendor_response/index"
  match 'vendor_response/:id/submit_response' => 'vendor_response#submit_response',
        :as => :vendor_response,
        :via => :get
  match '/requesters/logout' , controller: 'requesters#logout'
  match '/support_centers/update' , controller: 'support_centers#update'
  match '/cab_requests/show' , controller: 'cab_requests#show'
  match '/support_centers/show' , controller: 'support_centers#show'
  match '/support_centers/update_cab_request_status', controller: 'support_centers#update_cab_request_status'
  match '/anonymous/new' , controller: 'anonymous#new'
  match '/vendors/change_order_up', controller: 'vendors#change_order_up'
  match '/vendors/change_order_down', controller: 'vendors#change_order_down'
  resources :cab_requests
  resources :admins
  resources :requesters
  resources :vendors
  resources :support_centers


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep User::ProductsController in mind you can assign values other than :controller and :action

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
  #     # Directs /admin/products/* to User::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with 'root'
  # just remember to delete public/index.html.
   root :to => 'tranquil-basin-1474.herokuapp.com/saml/init'

  # See how all your routes lay out with 'rake routes'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
