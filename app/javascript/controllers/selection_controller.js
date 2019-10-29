import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["submit", "count", "selectable", "selector"]

  connect() {
    this.selectorTarget.style.display = "none";
    this.selectPreselectedOptions();
    this.showOrHideSubmitButton();
    this.updateCount();
  }

  toggleSelection(event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    const toggled = event.currentTarget;

    const shouldBeSelected = !toggled.classList.contains('selected')
    if (shouldBeSelected) {
      this.matchingSelectorOption(toggled).selected = true;
      this.selectVisually(toggled);
    } else {
      this.matchingSelectorOption(toggled).selected = false;
      this.deselectVisually(toggled);
    }
    this.updateCount();
    this.showOrHideSubmitButton();
  }

  showOrHideSubmitButton() {
    const selector = this.selectorTarget;
    var anySelected = this.selecteds().length !== 0

    this.submitTarget.style.display = (anySelected ? 'block' : 'none')
  }

  updateCount() {
    if (this.hasCountTarget) {
      const count = this.selecteds().length;

      const counters = this.countTargets;
      for (var i = 0; i < counters.length; i = i+1) {
        var counter = counters[i];
        var originalText;

        if (count === 0) {
          counter.style.display = 'none';
        } else {
          counter.style.display = null;
        }

        if ('originalText' in counter.dataset) {
          originalText = counter.dataset['originalText'];
        } else {
          originalText = counter.innerText;
          counter.dataset['originalText'] = originalText;
        }

        counter.innerText = originalText.replace(/{{count}}/g, count);
      }
    }
  }

  selectPreselectedOptions() {
    const selector = this.selectorTarget;

    for (var i = 0; i < selector.children.length; i = i + 1) {
      const option = selector.children[i];

      if (option.selected) {
        this.selectVisually(this.matchingSelectable(option)) ;
      }
    }
  }

  selectVisually(selectable) {
    selectable.classList.add('selected')
  }

  deselectVisually(selectable) {
    selectable.classList.remove('selected')
  }

  selecteds() {
    const selector = this.selectorTarget;
    const selectedCollection = []

    for (var i = 0; i < selector.children.length; i = i + 1) {
      const option = selector.children[i];
      if (option.selected) {
        selectedCollection.push(option);
      }
    }
    return selectedCollection;
  }

  matchingSelectable(selectorOption) {
    const selectables = this.selectableTargets;

    for(var i = 0; i < selectables.length; i = i + 1) {
      const selectable = selectables[i]
      if (selectable.dataset['id'] == selectorOption.value) {
        return selectable;
      }
    }
    return null;
  }

  matchingSelectorOption(selectable) {
    const selector = this.selectorTarget;

    for (var i = 0; i < selector.children.length; i = i + 1) {
      const option = selector.children[i];
      if (selectable.dataset['id'] == option.value) {
        return option;
      }
    }
    return null;
  }
}
