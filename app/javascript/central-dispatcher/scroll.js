scroll = {
  allow() {
    scroll.toggle(true);
  },

  disable() {
    scroll.toggle(false);
  },

  toggle(state) {
    const body = document.getElementsByTagName('body')[0];
    // if not present, flip it
    if (state === undefined) { state = !(body.style.overflow === null); }

    if (state) {
      body.style.overflow = null;
    } else {
      body.style.overflow = 'hidden';
    }
  }
}

export default scroll
