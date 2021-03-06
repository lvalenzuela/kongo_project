Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get "/:locale" => "trainings#index"
  root 'trainings#index'

  scope "(:locale)", locale: /es|en/ do
    resources :users do
      collection do 
        get :search
        get :user_login
        post :login
        get :profile
        get :logout
        get :change_password
        post :update_password
      end
    end

    resources :trainings do
      collection do
        get :index
        get :search
      end
    end

    resources :job_profiles do
      collection do
        get :index
        get :search
        get :edit_trainings
        post :save_trainings
      end
    end

    resources :employees do
      collection do
        get :index
        get :search
        get :contractor_select
        get :bulk_new
        get :example_creation_file
        post :creation_file_config
        post :bulk_create
        get :new_document
        post :create_document
        get :edit_contractors
        post :create_contractor_employee
        delete :destroy_contractor
        put :save_active_contractor
      end
    end

    resources :contractors do 
      collection do 
        get :index
        get :search
        get :new_service
        post :bind_service
        get :new_employee
        post :create_employee
        get :bulk_new_employees
        post :employees_file_config
        get :employees_file_example
        post :bulk_create_employees
      end
    end

    resources :services do
      collection do
        get :index
        get :search
      end
    end
  end

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
