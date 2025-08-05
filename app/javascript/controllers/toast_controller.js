// app/javascript/controllers/toast_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.show()
  }

  show() {
    this.element.classList.remove("opacity-0", "translate-y-2")
    this.element.classList.add("opacity-100", "translate-y-0")
    
    // Auto hide after 4 seconds
    setTimeout(() => {
      this.hide()
    }, 4000)
  }

  hide() {
    this.element.classList.remove("opacity-100", "translate-y-0")
    this.element.classList.add("opacity-0", "translate-y-2")
    
    // Remove element after animation
    setTimeout(() => {
      if (this.element.parentNode) {
        this.element.parentNode.removeChild(this.element)
      }
    }, 300)
  }

  dismiss() {
    this.hide()
  }
}
