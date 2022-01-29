import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field"]

  reset() {
    this.fieldTarget.value = "";
  }
}
