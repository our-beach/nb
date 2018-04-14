Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    namespace :v1 do
      scope :users do
        post '/' => 'users#create'
        post '/authorization-request' => 'users/authorization_requests#create'
        post '/authorization-tokens' => 'users/authorization_tokens#create'
      end

      scope :sign_ups do
        post '/' => 'sign_ups#create'
        patch '/:id' => 'sign_ups#update'
      end
    end
  end
end
