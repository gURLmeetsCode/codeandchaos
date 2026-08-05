import { Controller } from "@hotwired/stimulus"
import EasyMDE from "easymde"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.editor = new EasyMDE({
      element: this.inputTarget,
      spellChecker: false,
      autofocus: false,
      autoDownloadFontAwesome: false,
      status: [ "lines", "words" ],
      toolbar: [
        "bold", "italic", "heading", "|",
        "quote", "unordered-list", "ordered-list", "|",
        "link", "code", "|",
        "preview", "guide"
      ]
    })

    this.syncOnSubmit = (event) => {
      this.editor.codemirror.save()
    }
    this.element.closest("form")?.addEventListener("submit", this.syncOnSubmit)
  }

  disconnect() {
    this.element.closest("form")?.removeEventListener("submit", this.syncOnSubmit)

    if (this.editor) {
      this.editor.toTextArea()
      this.editor = null
    }
  }
}
