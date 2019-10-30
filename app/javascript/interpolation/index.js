export default function(info) {
  var interpolationEvent = new CustomEvent("interpolation-needed", {
    "detail": info
  })
  const root = document.getElementsByTagName("body")[0]
  if (root.dataset['interpolationReady']) {
      root.dispatchEvent(interpolationEvent)
  } else {
    root.addEventListener('interpolation-ready', function() {
      root.dispatchEvent(interpolationEvent)
    }, { 'once': true })
  }
}
