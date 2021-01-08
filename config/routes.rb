# frozen_string_literal: true

Rails.application.routes.draw do
  get 'editor/index'
  get 'editor/token'

  root to: 'editor#index'
end
