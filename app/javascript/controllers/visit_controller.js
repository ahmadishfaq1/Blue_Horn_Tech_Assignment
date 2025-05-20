import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.message = document.getElementById('location-message')
    this.errorMessage = document.getElementById('error-message')
    this.buttons = document.querySelectorAll('[data-controller="visit"]')
    this.successMessage = null
  }

  async logVisit(event) {
    const button = event.currentTarget
    button.disabled = true
    this.message.classList.remove('hidden')
    this.errorMessage.classList.add('hidden')

    if (!navigator.geolocation) {
      this.handleGeolocationError({ message: "Geolocation is not supported by this browser." })
      return
    }

    try {
      const position = await this.getCurrentPosition()
      await this.sendVisitLog(position.coords)
    } catch (error) {
      this.handleGeolocationError(error)
    }
  }

  getCurrentPosition() {
    return new Promise((resolve, reject) => {
      navigator.geolocation.getCurrentPosition(resolve, reject)
    })
  }

  async sendVisitLog(coords) {
    try {
      const response = await fetch(this.urlValue, {
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

      const body = await response.json()
      this.message.classList.add('hidden')

      if (response.ok) {
        this.showSuccess(body.message || "Visit logged successfully.")
      } else {
        this.showError(body.error || "Failed to log visit")
      }
    } catch (error) {
      this.message.classList.add('hidden')
      this.showError(error.message || "Network error")
    } finally {
      this.enableButtons()
    }
  }

  handleGeolocationError(error) {
    this.errorMessage.textContent = `Error getting location: ${error.message}`
    this.errorMessage.classList.remove('hidden')
    this.message.classList.add('hidden')
    this.enableButtons()
  }

  showError(msg) {
    this.errorMessage.textContent = msg
    this.errorMessage.classList.remove('hidden')
    if (this.successMessage) this.successMessage.classList.add('hidden')

    // Auto-hide error message after 5 seconds
    clearTimeout(this.hideTimeout)
    this.hideTimeout = setTimeout(() => {
      this.errorMessage.classList.add('hidden')
    }, 2000)
  }

  showSuccess(msg) {
    if (!this.successMessage) {
      this.successMessage = document.createElement('div')
      this.successMessage.id = 'success-message'
      this.successMessage.className = 'mt-4 text-sm text-green-600'
      document.querySelector('.bg-white.shadow.rounded-lg.p-6').appendChild(this.successMessage)
    }
    this.successMessage.textContent = msg
    this.successMessage.classList.remove('hidden')
    this.errorMessage.classList.add('hidden')

    // Auto-hide success message after 5 seconds
    clearTimeout(this.hideTimeout)
    this.hideTimeout = setTimeout(() => {
      this.successMessage.classList.add('hidden')
    }, 1000)

    setTimeout(() => {
      location.reload()
    }, 500)
  }

  enableButtons() {
    this.buttons.forEach(button => button.disabled = false)
  }
}