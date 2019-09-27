Rails.application.routes.draw do
  namespace :admin do
    resources :stories do
      resources :arcs do
        resources :updates
        resources :pages
      end
    end
  end

  resources :stories, param: :slug, only: [:index, :show] do
    resources :pages, params: :position, only: [:index, :show]

    resources :arcs, param: :slug, only: [:index, :show] do
      resources :pages, params: :position, only: [:index, :show]
    end
  end
end
