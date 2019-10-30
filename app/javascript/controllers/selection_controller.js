import { Controller } from "stimulus"
import { interpolate, toggle } from "../central-dispatcher"

export default class extends Controller {
  static targets = ["selectable", "selector"]

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

    this.changeSelectionState(toggled)

    this.updateCount();
    this.showOrHideSubmitButton();
  }

  showOrHideSubmitButton() {
    const anySelected = this.selecteds().length !== 0

    toggle.hide('interpolation', !anySelected)
  }

  updateCount() {
    const count = this.selecteds().length;
    interpolate({
      "source": "selection",
      "type": "count",
      "value": (count === 0 ? null : count),
      "whenEmpty": "hide"
    })
  }

  selectPreselectedOptions() {
    const selector = this.selectorTarget;

    for (var i = 0; i < selector.children.length; i = i + 1) {
      const option = selector.children[i];

      this.changeSelectionState(this.matchingSelectable(option), option.selected) ;
    }
  }

  changeSelectionState(selectable, newState = null) {
    // When newState is not specified, flip to other
    if (newState === null) { newState = !this.isSelected(selectable) }
    this.matchingSelectorOption(selectable).selected = newState;
    this.toggleVisualSelection(selectable, newState);
  }

  toggleVisualSelection(selectable, newState) {
    selectable.classList.toggle('selected', newState)
  }

  isSelected(selectable) {
    return selectable.classList.contains('selected')
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
      if (selectable.dataset['id'] == selectorOption.value) { return selectable; }
    }
    return null;
  }

  matchingSelectorOption(selectable) {
    const selector = this.selectorTarget;

    for (var i = 0; i < selector.children.length; i = i + 1) {
      const option = selector.children[i];
      if (selectable.dataset['id'] == option.value) { return option; }
    }
    return null;
  }
}
