import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-visible"
export default class extends Controller {
  static targets = ['hidden']

  connect() {
    console.log(this.hiddenTarget)
  }

  toggle() {
    this.hiddenTarget.classList.toggle('d-none')
  }
}
