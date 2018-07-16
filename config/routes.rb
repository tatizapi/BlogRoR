Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

	resources :articles do
		resources :comments, only: [:index, :create, :destroy, :edit, :update]
	end

  get '/articles/:article_id/comments/:comment_id/new/(:parent_id)',
    to: 'comments#new', as: :new_article_comment

	root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
