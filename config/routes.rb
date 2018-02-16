Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    namespace :v1 do
      scope :sign_ups do
        post '/create' => 'sign_ups#create'
      end
    end
  end
end
