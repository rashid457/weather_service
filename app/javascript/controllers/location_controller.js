import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0,
};

// Connects to data-controller="location"
export default class extends Controller {

  static targets = ['search']

  connect() {
    navigator.geolocation.getCurrentPosition(this.success, this.error, options);
  }

  success(pos) {
    const crd = pos.coords;

    fetch(`/weather?coordinates=${crd.latitude.toFixed(2)},${crd.longitude.toFixed(2)}`,{ headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => { 
      var image = document.querySelector(".location_icon")
      image.setAttribute('src', data['icon'])
      image.setAttribute('alt', data['condition'])

      document.querySelector(".location_condition").innerHTML = `Condition: ${data['condition']}`
      document.querySelector(".location_name").innerHTML = `City: ${data['name']}`
      document.querySelector(".location_temparature").innerHTML = `Temparature : ${data['temparature']} <span>&#176;</span>`
      document.querySelector(".location_wind").innerHTML = `Wind : ${data['wind']} Kmph`
      document.querySelector(".location_humidity").innerHTML = `Humidity : ${data['humidity']}%`
      document.querySelector(".location_cloud").innerHTML = `cloud : ${data['cloud']} oktas`
      document.querySelector("#search").value = data['name']
    })
  }
  
  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  search(e){
    fetch(`/weather?search=${this.searchTarget.value}`,{ headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => { 
      var image = document.querySelector(".location_icon")
      image.setAttribute('src', data['icon'])
      image.setAttribute('alt', data['condition'])
  
      document.querySelector(".location_condition").innerHTML = `Condition: ${data['condition']}`
      document.querySelector(".location_name").innerHTML = `City: ${data['name']}`
      document.querySelector(".location_temparature").innerHTML = `Temparature : ${data['temparature']} <span>&#176;</span>`
      document.querySelector(".location_wind").innerHTML = `Wind : ${data['wind']} Kmph`
      document.querySelector(".location_humidity").innerHTML = `Humidity : ${data['humidity']}%`
      document.querySelector(".location_cloud").innerHTML = `cloud : ${data['cloud']} oktas`
      document.querySelector("#search").value = data['name']
    })
  }
}

