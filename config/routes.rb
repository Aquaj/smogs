Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]

  namespace :admin do
    resources :stories do
      resources :arcs do
        resources :updates
        resources :pages
      end
    end
  end

  resources :stories, param: :slug, only: [:index, :show] do
    resources :pages, params: :position, controller: 'story_pages', only: [:show]

    resources :arcs, param: :slug, only: [:show] do
      resources :pages, params: :position, controller: 'arc_pages', only: [:show]
    end
  end
end
