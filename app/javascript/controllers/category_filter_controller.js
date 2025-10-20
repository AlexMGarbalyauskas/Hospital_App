import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["type", "value", "form"]

  connect() {
    console.log("✅ category_filter_controller connected")
  }

  updateOptions() {
    const selectedType = this.typeTarget.value
    const optionsMap = {
      "Age Group": ["Child", "Adult", "Senior"],
      "Critical Status": ["Critical", "Non Critical", "Mild"],
      "Treatment Time": ["Immediate", "Scheduled", "Routine"]
    }

    const options = optionsMap[selectedType] || []

    if (options.length > 0) {
      this.valueTarget.innerHTML = `<option value="">Select ${selectedType}</option>` +
        options.map(opt => `<option value="${opt}">${opt}</option>`).join("")
      this.valueTarget.classList.remove("d-none")
    } else {
      this.valueTarget.innerHTML = ""
      this.valueTarget.classList.add("d-none")
    }
  }

  submitForm() {
    if (this.valueTarget.value !== "") {
      this.formTarget.submit()
    }
  }
}
