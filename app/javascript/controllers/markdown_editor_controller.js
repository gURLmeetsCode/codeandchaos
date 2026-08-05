import { Controller } from "@hotwired/stimulus"
import EasyMDE from "easymde"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.editor = new EasyMDE({
      element: this.inputTarget,
      spellChecker: false,
      autofocus: false,
      status: [ "lines", "words" ],
      toolbar: [
        "bold", "italic", "heading", "|",
        "quote", "unordered-list", "ordered-list", "|",
        "link", "code", "|",
        "preview", "guide"
      ]
    })
  }

  disconnect() {
    if (this.editor) {
      this.editor.toTextArea()
      this.editor = null
    }
  }
}
