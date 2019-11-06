Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]

  namespace :admin do
    resources :unpublished_pages, only: [:index]
    resources :page_uploads, only: [:create]
    resources :partial_publications, only: [:create]
    resources :publications, only: [:create]
  end

  resources :pages, param: :position, only: [:show]

  # FIXME: Develop proper arc and story management features so we can uncomment
  #        this.
  # resources :stories, param: :slug, only: [:index, :show] do
  #   resources :pages, params: :position, controller: 'story_pages', only: [:show]

  #   resources :arcs, param: :slug, only: [:show] do
  #     resources :pages, params: :position, controller: 'arc_pages', only: [:show]
  #   end
  # end
end
