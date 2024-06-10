import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-book-form"
export default class extends Controller {
  static targets = ['serie', 'illustrator']

  connect() {
    console.log(this.illustratorTarget)
  }

  toggle_illustrator(event) {
    if (['BD', 'Manga', 'Livre illustré'].includes(event.target.value)) {
      this.illustratorTarget.classList.remove("d-none");
    } else {
      this.illustratorTarget.classList.add("d-none");
    }
  }



  toggle_serie(event) {
    if (event.target.value == '') {
      this.serieTarget.classList.remove('d-none')
    } else {
      this.serieTarget.classList.add("d-none");
    }
  }
}
