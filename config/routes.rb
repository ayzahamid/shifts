# frozen_string_literal: true

Rails.application.routes.draw do
  resources :workers do
    resources :shifts
  end
end
