import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-content"
export default class extends Controller {
  static targets = ["bookDefault", "bookInfos"]

  visible() {
    this.bookInfosTarget.classList.toggle('d-none')
    this.bookDefaultTarget.classList.toggle("d-none");
  }

}
