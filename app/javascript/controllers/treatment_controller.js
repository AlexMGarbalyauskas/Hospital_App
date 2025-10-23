import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { patientId: Number }

  mark(event) {
    event.preventDefault()
    const status = event.currentTarget.dataset.status
    const card = this.element

    // Remove previous treatment colors
    card.classList.remove("bg-success", "bg-dark", "text-white")

    // Apply new treatment status
    switch(status) {
      case "treated":
        card.classList.add("bg-success", "text-white")
        card.querySelector(".card-header h5").innerText = "Treated"
        break
      case "dead":
        card.classList.add("bg-dark", "text-white")
        card.querySelector(".card-header h5").innerText = "Dead"
        break
      default:
        card.querySelector(".card-header h5").innerText = "Patient Details"
        break
    }

    // Optional: send AJAX to update DB
    fetch(`/patients/${this.patientIdValue}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
      body: JSON.stringify({ patient: { treatment_status: status } })
    })
  }
}
