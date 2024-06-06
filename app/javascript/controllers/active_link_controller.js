import { Controller } from "@hotwired/stimulus"

// Se connecte à data-controller="active-link"
export default class extends Controller {
  static targets = ["link"]

  active(event) {
    this.linkTargets.forEach(target => target.classList.remove("active"));
    event.currentTarget.classList.add("active");
  }
}
