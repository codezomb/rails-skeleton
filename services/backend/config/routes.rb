# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api/docs'
  mount Rswag::Ui::Engine => '/api/docs'

  scope(path: '/api') do
    defaults format: :json do
      devise_for :users
    end
  end
end
