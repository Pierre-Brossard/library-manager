import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-book"
export default class extends Controller {
  static targets = ['button', 'form']

  toggleForm() {
    if (this.formTarget.classList.contains("d-none")) {
      this.formTarget.classList.remove("d-none");
      this.buttonTarget.innerText = "Cacher le formulaire";
    } else {
      this.formTarget.classList.add("d-none");
      this.buttonTarget.innerText = "Mettre à jour";
    }
  }
}
