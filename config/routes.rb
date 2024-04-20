Rails.application.routes.draw do
  scope '(:locale)', locale: /pt-BR|en/ do
    devise_for :users
    root 'posts#index'

    resources :posts do
      resources :comments, only: %i[create destroy]
    end

    resources :categories
  end
end
