import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-filter"
export default class extends Controller {
  static targets = ["type", "value", "valueWrapper"]

  connect() {
    // Hide the second dropdown initially
    if (this.hasValueWrapperTarget) {
      this.valueWrapperTarget.classList.add("d-none")
    }

    // If a type is preselected (e.g., on reload), re-render options
    const selectedType = this.typeTarget.value
    if (selectedType) this.showOptions()
  }

  showOptions() {
    if (!this.hasTypeTarget || !this.hasValueTarget || !this.hasValueWrapperTarget) return

    const selectedType = this.typeTarget.value
    let options = []

    if (selectedType === "Age Group") {
      options = ["Child", "Adult", "Senior"]
    } else if (selectedType === "Critical Status") {
      options = ["Critical", "Non Critical", "Mild"]
    } else if (selectedType === "Treatment Time") {
      options = ["Immediate", "Scheduled", "Routine"]
    }

    this.valueTarget.innerHTML = `
      <option value="">Select ${selectedType}</option>
      ${options.map(opt => `<option value="${opt}">${opt}</option>`).join("")}
    `
    this.valueWrapperTarget.classList.remove("d-none")
  }
}
