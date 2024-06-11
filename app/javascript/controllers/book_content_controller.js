import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-content"
export default class extends Controller {
  static targets = ["bookDefault", "bookInfos"]

  visible() {
    this.bookInfosTarget.classList.toggle('d-none')
    this.bookDefaultTarget.classList.toggle("d-none");
  }

  addFavorite(event){
    fetch(event.currentTarget.value, { headers: {"Accept": "text/plain"} })
      .then((res) => res.text())
      .then((data) => {
        this.element.outerHTML = data
  })
  }

  addCollection(event){
    fetch(event.currentTarget.value, { method: 'POST', headers: {"Accept": "text/plain"} })
      .then((res) => res.text())
      .then((data) => {
        this.element.outerHTML = data
  })
  }

  addAsRead(event){
    fetch(event.currentTarget.value, { headers: {"Accept": "text/plain"} })
      .then((res) => res.text())
      .then((data) => {
        this.element.outerHTML = data
  })
  }

  stop_bubbling(event) {
    event.stopPropagation()
  }
}
