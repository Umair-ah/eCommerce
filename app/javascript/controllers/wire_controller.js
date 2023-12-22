import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="wire"
export default class extends Controller {
  connect() {}

  initialize() {
    this.element.setAttribute("data-action", "wire#turbo_wire");
  }

  turbo_wire(event) {
    event.preventDefault();
    this.url = this.element.getAttribute("href");

    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
      .then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
