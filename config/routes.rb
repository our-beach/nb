Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    namespace :v1 do
      resource :users do
        post ':id/authorization_requests' => 'users/authorization_requests#create'
        get ':id/authorization-token' => 'users/authorization_token#show'
      end
    end
  end
end
