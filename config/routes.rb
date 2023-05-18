Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "locations#show" 
  get "/weather", to:"locations#get_weather"
  get "/location_search", to: "locations#search"
end
