Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api/docs'
  mount Rswag::Ui::Engine => '/api/docs'

  scope(path: '/api') do
    devise_for :users
  end

  # All other routes are handled by the frontend
  get '*path' => 'web#show', as: :web
  root to: 'web#show'
end
