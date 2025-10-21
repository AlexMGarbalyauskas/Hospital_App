import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, targetId: String, wrapperId: String }

  remove(event) {
    event.preventDefault()
    const token = document.querySelector('meta[name="csrf-token"]').content

    fetch(this.urlValue, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": token,
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
    .then(response => {
      if (response.ok) {
        const wrapper = document.getElementById(this.wrapperIdValue)
        if (wrapper) {
          wrapper.innerHTML = `
            <img src="/images/user.png"
                 class="rounded-circle border mb-2"
                 width="100" height="100"
                 alt="Default photo"
                 id="${this.targetIdValue}">
          `
        }
      } else {
        alert("Failed to remove photo.")
      }
    })
    .catch(error => console.error("Error:", error))
  }
}
