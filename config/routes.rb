Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/messages/:uuid', to: 'messages#show', defaults: { format: :json }
      post '/messages', to: 'messages#create', defaults: { format: :json }
      post '/view_decrypted/:uuid', to: 'messages#view_decrypted', defaults: { format: :json }
    end
  end
end
