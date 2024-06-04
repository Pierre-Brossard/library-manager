import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="series-tabs"
export default class extends Controller {
  static targets = ['tab', 'content'];

  switchTabs(event) {
    event.preventDefault();
    this.tabTargets.forEach((tab) => tab.classList.remove('active'));
    event.currentTarget.classList.add('active');
    this.showContent(event.currentTarget);
  }

  showContent(activeTab) {
    const targetId = activeTab.getAttribute('data-target-id');
    this.contentTargets.forEach((content) => {
      if (content.id === targetId) {
        content.style.display = 'block';
      } else {
        content.style.display = 'none';
      }
    });
  }
}
