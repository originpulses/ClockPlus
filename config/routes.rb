Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/', to: 'frontend#home', as: 'home'
  get '/zone_json', to: 'frontend#zone_json', as: 'zone_json'
  post '/calculate_local_time', to: 'frontend#calculate_local_time', as: 'calculate_local_time'
  
  get '/search_zone_values/:search_term', to: 'zone#search_zone_values', as: 'search_zone_values'
  
end
