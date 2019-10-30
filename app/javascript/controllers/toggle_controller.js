import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["hide"]

  connect() {
    this.data.set('ready', true)
    var readyEvent = new CustomEvent("toggle-ready")
    this.element.dispatchEvent(readyEvent)
  }

  hide() {
    const info = event.detail;
    const source = info.source;

    for (var i = 0; i < this.hideTargets.length; i = i + 1) {
      var toHide = this.hideTargets[i];

      if (toHide.dataset['toggleSource'] !== source) { continue };

      if (info.hide) {
        toHide.style.display = 'none';
      } else {
        toHide.style.display = null;
      }
    }
  }
}
