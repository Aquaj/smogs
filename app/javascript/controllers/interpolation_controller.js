import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["text"]

  connect() {
    this.data.set('ready', true)
    var readyEvent = new CustomEvent("interpolation-ready")
    this.element.dispatchEvent(readyEvent)
  }

  interpolate() {
    const info = event.detail;
    const interpolationKey = info.source + "." + info.type;
    const regexp = new RegExp("{{"+interpolationKey+"}}", "g");

    for (var i = 0; i < this.textTargets.length; i = i + 1) {
      var text = this.textTargets[i];
      var originalText;

      if ('originalText' in text.dataset) {
        originalText = text.dataset['originalText'];
      } else {
        originalText = text.innerText;
        text.dataset['originalText'] = originalText;
      }

      if (!regexp.test(originalText)) { continue };

      if (info.whenEmpty === "hide") {
        if (info.value === null) {
          text.style.display = 'none';
        } else {
          text.style.display = null;
        }
      }

      text.innerText = originalText.replace(regexp, info.value);
    }
  }
}
