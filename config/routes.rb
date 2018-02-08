Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
    resources :users, :only => [:index, :show, :edit, :update]  do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
      member do
        get :both_followed
      end
  end
  # 請依照專案指定規格來設定路由

  resources :tweets, :only => [:index] do
    member do
      post :like
      post :unlike      
    end
  end
  root "tweets#index"

end
