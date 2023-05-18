json.name @location.name
json.region @location.region
json.country @location.country
json.lat @location.lat
json.lon @location.lon
json.condition @location.condition
json.icon @location.icon.gsub("64x64", "128x128")
json.temparature @location.temparature.to_f
json.wind @location.wind.to_f
json.humidity @location.humidity
json.cloud @location.cloud
