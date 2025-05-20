import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  logVisit(event) {
    const button = event.currentTarget
    const message = document.getElementById('location-message')
    const errorMessage = document.getElementById('error-message')

    button.disabled = true
    message.classList.remove('hidden')
    errorMessage.classList.add('hidden')

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => this.sendVisitLog(position.coords),
        (error) => this.handleGeolocationError(error)
      )
    } else {
      this.handleGeolocationError({ message: "Geolocation is not supported by this browser." })
    }
  }

  sendVisitLog(coords) {
    const message = document.getElementById('location-message')
    const errorMessage = document.getElementById('error-message')

    fetch(this.urlValue, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        latitude: coords.latitude,
        longitude: coords.longitude
      })
    })
    .then(response => {
      if (response.ok) {
        window.location.reload() // Refresh to show new log
      } else {
        throw new Error('Failed to log visit')
      }
    })
    .catch(error => {
      errorMessage.textContent = error.message
      errorMessage.classList.remove('hidden')
    })
    .finally(() => {
      message.classList.add('hidden')
    })
  }

  handleGeolocationError(error) {
    const message = document.getElementById('location-message')
    const errorMessage = document.getElementById('error-message')
    const buttons = document.querySelectorAll('[data-controller="visit"]')

    errorMessage.textContent = `Error getting location: ${error.message}`
    errorMessage.classList.remove('hidden')
    message.classList.add('hidden')

    buttons.forEach(button => {
      button.disabled = false
    })
  }
}