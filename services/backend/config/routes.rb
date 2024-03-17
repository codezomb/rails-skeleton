Rails.application.routes.draw do
  defaults format: :json do
    devise_for :users

    root to: 'root#index'
  end
end
