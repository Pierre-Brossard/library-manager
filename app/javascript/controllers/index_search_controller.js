import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="index-search"
export default class extends Controller {
  static targets = ['input', 'list'];

  search() {
    const url = `/books?query=${this.inputTarget.value}`;
    fetch(url, { headers: { Accept: 'text/plain' } })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data;
      });
  }
}
