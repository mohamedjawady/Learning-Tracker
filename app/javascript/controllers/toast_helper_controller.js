// app/javascript/controllers/toast_helper_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    message: String,
    type: String
  }

  // Helper method to show toast notifications dynamically
  static showToast(message, type = 'success') {
    const toastContainer = document.getElementById('toast-container') || this.createToastContainer()
    
    const toast = document.createElement('div')
    toast.setAttribute('data-controller', 'toast')
    toast.className = `transform transition-all duration-300 ease-in-out opacity-0 translate-y-2 max-w-sm ${this.getToastClasses(type)}`
    
    toast.innerHTML = `
      <div class="flex items-center justify-between">
        <div class="flex items-center">
          <i class="${this.getToastIcon(type)} mr-3 text-lg"></i>
          <span>${message}</span>
        </div>
        <button onclick="this.parentElement.parentElement.remove()" class="ml-4 text-white hover:text-gray-200">
          <i class="fas fa-times"></i>
        </button>
      </div>
    `
    
    toastContainer.appendChild(toast)
    
    // Show toast
    setTimeout(() => {
      toast.classList.remove('opacity-0', 'translate-y-2')
      toast.classList.add('opacity-100', 'translate-y-0')
    }, 100)
    
    // Auto hide after 4 seconds
    setTimeout(() => {
      toast.classList.remove('opacity-100', 'translate-y-0')
      toast.classList.add('opacity-0', 'translate-y-2')
      setTimeout(() => toast.remove(), 300)
    }, 4000)
  }

  static createToastContainer() {
    const container = document.createElement('div')
    container.id = 'toast-container'
    container.className = 'fixed top-4 right-4 z-50 space-y-2'
    document.body.appendChild(container)
    return container
  }

  static getToastClasses(type) {
    const baseClasses = 'px-6 py-4 rounded-lg shadow-lg text-white'
    switch(type) {
      case 'success':
        return `bg-green-500 ${baseClasses}`
      case 'error':
        return `bg-red-500 ${baseClasses}`
      case 'warning':
        return `bg-yellow-500 ${baseClasses}`
      case 'info':
        return `bg-blue-500 ${baseClasses}`
      default:
        return `bg-green-500 ${baseClasses}`
    }
  }

  static getToastIcon(type) {
    switch(type) {
      case 'success':
        return 'fas fa-check-circle'
      case 'error':
        return 'fas fa-exclamation-triangle'
      case 'warning':
        return 'fas fa-exclamation-circle'
      case 'info':
        return 'fas fa-info-circle'
      default:
        return 'fas fa-check-circle'
    }
  }
}

// Make it globally available
window.showToast = (message, type = 'success') => {
  import('./toast_helper_controller.js').then(module => {
    module.default.showToast(message, type)
  })
}
