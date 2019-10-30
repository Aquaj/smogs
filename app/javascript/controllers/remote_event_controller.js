import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["source", "destination"]

  connect() {
    for (var i = 0; i < this.destinationTargets.length; i = i + 1) {
      var destination = this.destinationTargets[i];
      var destinationId = destination.dataset['remoteClickId'];

      var coherenceChecker = new Set();
      var matchingSources = this.matchingSources(destination)
      for (var j = 0; j < matchingSources.length; j = j + 1) {
        var source = matchingSources[j];
        var hide = source.dataset['remoteClickHide'] === 'true';

        destination.style.display = (hide ? 'none' : null)
        coherenceChecker.add(hide);
      }

      if (coherenceChecker.size > 1) {
        throw "Conflictual data-remote-click-hide instructions for data-remote-click-id: '" + destinationId +"'."
      };
    }
  }

  transfer() {
    var matchingDestinations = this.matchingDestinations(event.target)
    for (var i = 0; i < matchingDestinations.length; i = i + 1) {
      var destination = matchingDestinations[i];
      var redispatchingEvent = new event.constructor(event.type, event);
      destination.dispatchEvent(redispatchingEvent);
    }
  }

  matchingDestinations(source) {
    return this.destinationTargets.filter(function(destination) {
        return destination.dataset['remoteClickId'] === source.dataset['remoteClickId']
    })
  }

  matchingSources(destination) {
    return this.sourceTargets.filter(function(source) {
        return source.dataset['remoteClickId'] === destination.dataset['remoteClickId']
    })
  }
}
