# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bee_templates, only: %i[new create index show] do
    get :token, on: :collection
  end

  root to: 'bee_templates#index'
end
