export default {
   hide(source, state){
    var toggleHideEvent = new CustomEvent("toggle-hide", {
      "detail": {
        'source': source,
        'hide': state
      }
    })
    const root = document.getElementsByTagName("body")[0]
    if (root.dataset['toggleReady']) {
        root.dispatchEvent(toggleHideEvent)
    } else {
      root.addEventListener('toggle-ready', function() {
        root.dispatchEvent(toggleHideEvent)
      }, { 'once': true })
    }
  }
}
