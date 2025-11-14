
document.addEventListener("DOMContentLoaded", function() {
  const select = document.getElementById("treatment_status_select");
  const cureFields = document.getElementById("cure_fields");
  const deathFields = document.getElementById("death_fields");

  function toggleFields() {
    const value = select.value;
    cureFields.style.display = (value === "Cured") ? "block" : "none";
    deathFields.style.display = (value === "Dead") ? "block" : "none";
  }



  // Initialize fields on page load
  toggleFields();



  // Listen for changes
  select.addEventListener("change", toggleFields);
});

