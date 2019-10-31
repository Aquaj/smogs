import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["source", "destination"]

  connect() {
    for (var i = 0; i < this.destinationTargets.length; i = i + 1) {
      var destination = this.destinationTargets[i];
      var destinationId = destination.dataset['eventForwarderId'];

      var coherenceChecker = new Set();
      var matchingSources = this.matchingSources(destination)
      for (var j = 0; j < matchingSources.length; j = j + 1) {
        var source = matchingSources[j];
        var hide = source.dataset['eventForwarderHide'] === 'true';

        destination.style.display = (hide ? 'none' : null)
        coherenceChecker.add(hide);
      }

      if (coherenceChecker.size > 1) {
        throw "Conflictual data-event-forwarder-hide instructions for data-event-forwarder-id: '" + destinationId +"'."
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
        return destination.dataset['eventForwarderId'] === source.dataset['eventForwarderId']
    })
  }

  matchingSources(destination) {
    return this.sourceTargets.filter(function(source) {
        return source.dataset['eventForwarderId'] === destination.dataset['eventForwarderId']
    })
  }
}
