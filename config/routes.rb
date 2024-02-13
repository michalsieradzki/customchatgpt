Rails.application.routes.draw do
  Rails.application.routes.draw do
    resources :chats, only: [:index, :create]
    root 'chats#index'
  end
end
