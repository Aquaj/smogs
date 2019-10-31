import { Controller } from 'stimulus';
import { scroll } from 'central-dispatcher';

export default class extends Controller {
  connect() {
    if (this.element.style.display != 'none') { scroll.disable(); }
  }

  open() {
    this.element.style.display = null;
    scroll.disable();
  }

  // Can be reopened
  softClose() {
    this.element.style.display = 'none';
    scroll.allow();
  }

  // Cannot be reopened
  hardClose() {
    this.element.remove();
    scroll.allow();
  }
}
