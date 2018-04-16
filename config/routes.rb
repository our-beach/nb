Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    namespace :v1 do
      resource :users do
        post ':id/authorization_requests' => 'users/authorization_requests#create'
        post ':id/authorization-tokens' => 'users/authorization_tokens#create'
      end
    end
  end
end
