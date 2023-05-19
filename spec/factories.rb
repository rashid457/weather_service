FactoryBot.define do
  factory :location do
    name {"Tampa"}                                               
    region {"Florida"}                                         
    country {"United States of America"}                         
    lat {"27.95"}                                              
    lon {"-82.46"}                                            
    condition {"Partly cloudy"}                                  
    icon {"https:////cdn.weatherapi.com/weather/64x64/day/116.png"}
    temparature {0.28e2}                                         
    wind {0.22e1}                                                
    humidity {70}                                                
    cloud {50}                                                   
    last_updated_at {1684418400}
  end
end


