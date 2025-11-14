//app/assets/javascripts/index_patient_form.js 


// JS for mass delete after selection appear as 
//a red btn in right corner and the cards can be 
//selected in many to delete at once
 
 document.addEventListener("DOMContentLoaded", function() {
    const buttonForm = document.querySelector("#mass_delete_button_form");
    const checkboxes = document.querySelectorAll(".patient-checkbox");

    buttonForm.addEventListener("submit", function(e) {
      const selectedIds = Array.from(checkboxes)
                               .filter(cb => cb.checked)
                               .map(cb => cb.value);

      if (selectedIds.length === 0) {
        e.preventDefault();
        alert("Please select at least one patient to delete.");
        return;
      }

      // Clear previous hidden inputs
      buttonForm.querySelectorAll('input[name="patient_ids[]"]').forEach(el => el.remove());

      // Add hidden inputs for selected IDs
      selectedIds.forEach(id => {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "patient_ids[]";
        input.value = id;
        buttonForm.appendChild(input);
      });
    });
  });