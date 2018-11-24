Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'generate', to: 'maze#generate'
  post 'show-path', to: 'maze#show_path'
  root 'maze#index'
end
