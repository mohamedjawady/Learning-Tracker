// app/javascript/controllers/notes_editor_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "toolbar", "content"]

  connect() {
    console.log("Notes editor controller connected!")
    console.log("Editor target:", this.editorTarget)
    console.log("Toolbar target:", this.toolbarTarget)
    console.log("Content target:", this.contentTarget)
    
    // Add a visual indicator that the controller is connected
    this.element.style.border = "2px solid green"
    this.element.style.backgroundColor = "#f0fff0"
    
    this.initializeEditor()
    this.setupToolbar()
  }

  initializeEditor() {
    console.log("Initializing editor...")
    // Simple rich text editor implementation
    this.editorTarget.contentEditable = true
    this.editorTarget.classList.add(
      "min-h-64", "p-4", "border", "border-gray-300", "rounded-md", 
      "focus:ring-2", "focus:ring-indigo-500", "focus:border-indigo-500",
      "prose", "max-w-none", "bg-white"
    )

    // Set placeholder text
    this.editorTarget.setAttribute('data-placeholder', 'Click here to start editing your note...')
    
    // Add placeholder styling
    const style = document.createElement('style')
    style.textContent = `
      [data-notes-editor-target="editor"]:empty::before {
        content: attr(data-placeholder);
        color: #9ca3af;
        pointer-events: none;
        font-style: italic;
      }
      [data-notes-editor-target="editor"]:focus:empty::before {
        content: '';
      }
    `
    document.head.appendChild(style)

    // Set initial content if provided
    if (this.contentTarget && this.contentTarget.value) {
      console.log("Setting initial content:", this.contentTarget.value)
      this.editorTarget.innerHTML = this.contentTarget.value
    } else {
      console.log("No initial content found")
    }

    // Update hidden field on input
    this.editorTarget.addEventListener('input', () => {
      console.log("Editor content changed")
      this.updateContent()
    })

    // Handle paste events for images
    this.editorTarget.addEventListener('paste', (e) => {
      this.handlePaste(e)
    })
    
    // Add click handler to focus
    this.editorTarget.addEventListener('click', () => {
      console.log("Editor clicked")
      this.editorTarget.focus()
    })
    
    console.log("Editor initialized successfully!")
    console.log("Editor is contentEditable:", this.editorTarget.contentEditable)
  }

  setupToolbar() {
    if (!this.hasToolbarTarget) return

    // Add toolbar buttons
    this.toolbarTarget.innerHTML = `
      <div class="flex flex-wrap gap-2 p-2 border-b border-gray-200">
        <button type="button" data-action="click->notes-editor#bold" class="toolbar-btn">
          <i class="fas fa-bold"></i>
        </button>
        <button type="button" data-action="click->notes-editor#italic" class="toolbar-btn">
          <i class="fas fa-italic"></i>
        </button>
        <button type="button" data-action="click->notes-editor#underline" class="toolbar-btn">
          <i class="fas fa-underline"></i>
        </button>
        <div class="border-l border-gray-300 mx-2"></div>
        <button type="button" data-action="click->notes-editor#insertUnorderedList" class="toolbar-btn">
          <i class="fas fa-list-ul"></i>
        </button>
        <button type="button" data-action="click->notes-editor#insertOrderedList" class="toolbar-btn">
          <i class="fas fa-list-ol"></i>
        </button>
        <div class="border-l border-gray-300 mx-2"></div>
        <button type="button" data-action="click->notes-editor#createLink" class="toolbar-btn">
          <i class="fas fa-link"></i>
        </button>
        <button type="button" data-action="click->notes-editor#insertImage" class="toolbar-btn">
          <i class="fas fa-image"></i>
        </button>
        <div class="border-l border-gray-300 mx-2"></div>
        <button type="button" data-action="click->notes-editor#formatCode" class="toolbar-btn">
          <i class="fas fa-code"></i>
        </button>
        <button type="button" data-action="click->notes-editor#insertHorizontalRule" class="toolbar-btn">
          <i class="fas fa-minus"></i>
        </button>
      </div>
    `

    // Add CSS for toolbar buttons
    const style = document.createElement('style')
    style.textContent = `
      .toolbar-btn {
        padding: 8px 12px;
        border: 1px solid #d1d5db;
        background: white;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.2s;
      }
      .toolbar-btn:hover {
        background: #f3f4f6;
        border-color: #9ca3af;
      }
      .toolbar-btn.active {
        background: #3b82f6;
        color: white;
        border-color: #3b82f6;
      }
    `
    document.head.appendChild(style)
  }

  updateContent() {
    if (this.hasContentTarget) {
      this.contentTarget.value = this.editorTarget.innerHTML
    }
  }

  // Formatting commands
  bold() {
    document.execCommand('bold', false, null)
    this.updateContent()
  }

  italic() {
    document.execCommand('italic', false, null)
    this.updateContent()
  }

  underline() {
    document.execCommand('underline', false, null)
    this.updateContent()
  }

  insertUnorderedList() {
    document.execCommand('insertUnorderedList', false, null)
    this.updateContent()
  }

  insertOrderedList() {
    document.execCommand('insertOrderedList', false, null)
    this.updateContent()
  }

  createLink() {
    const url = prompt('Enter URL:')
    if (url) {
      document.execCommand('createLink', false, url)
      this.updateContent()
    }
  }

  insertImage() {
    const url = prompt('Enter image URL:')
    if (url) {
      document.execCommand('insertImage', false, url)
      this.updateContent()
    }
  }

  formatCode() {
    const selection = window.getSelection()
    if (selection.rangeCount > 0) {
      const range = selection.getRangeAt(0)
      const code = document.createElement('code')
      code.style.backgroundColor = '#f3f4f6'
      code.style.padding = '2px 4px'
      code.style.borderRadius = '3px'
      code.style.fontFamily = 'monospace'
      
      try {
        range.surroundContents(code)
        this.updateContent()
      } catch (e) {
        // If surrounding fails, insert code element
        code.textContent = range.toString()
        range.deleteContents()
        range.insertNode(code)
        this.updateContent()
      }
    }
  }

  insertHorizontalRule() {
    document.execCommand('insertHorizontalRule', false, null)
    this.updateContent()
  }

  handlePaste(event) {
    const items = event.clipboardData.items
    
    for (let item of items) {
      if (item.type.indexOf('image') !== -1) {
        event.preventDefault()
        const file = item.getAsFile()
        this.insertImageFromFile(file)
        break
      }
    }
  }

  insertImageFromFile(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      const img = document.createElement('img')
      img.src = e.target.result
      img.style.maxWidth = '100%'
      img.style.height = 'auto'
      
      const selection = window.getSelection()
      if (selection.rangeCount > 0) {
        const range = selection.getRangeAt(0)
        range.insertNode(img)
        this.updateContent()
      }
    }
    reader.readAsDataURL(file)
  }
}
