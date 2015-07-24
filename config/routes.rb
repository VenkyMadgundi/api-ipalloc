Rails.application.routes.draw do
  get 'devices' => 'devices#index'
  post 'addresses/assign/' => 'addresses#assign'
  root 'devices#index'
end
