// app/assets/javascripts/show_patient_form.js
// links to app/views/patients/show.html.erb 

// JavaScript to handle iframe loading of map/api_page.html.erb

document.addEventListener("DOMContentLoaded", function() {
  const btnMap = document.getElementById("btnShowMap");
  const btnCovid = document.getElementById("btnShowCovid");
  const btnGlobalCovid = document.getElementById("btnShowGlobalCovid");
  const apiContent = document.getElementById("apiContent");

  // ✅ Read Rails paths passed from the view via data attributes
  const mapApi = apiContent.dataset.mapApi;
  const covidApi = apiContent.dataset.covidApi;
  const globalCovidApi = apiContent.dataset.globalCovidApi;

  function loadIframe(url) {
    apiContent.innerHTML = "";
    const iframe = document.createElement("iframe");
    iframe.src = url;
    iframe.style.width = "100%";
    iframe.style.height = "600px";
    iframe.style.border = "none";
    iframe.allowFullscreen = true;
    apiContent.appendChild(iframe);
  }

  // Load Map API
  btnMap.addEventListener("click", function() {
    loadIframe(mapApi);
  });

  // Load COVID Historical API
  btnCovid.addEventListener("click", function() {
    loadIframe(covidApi);
  });

  // Load Global COVID API
  btnGlobalCovid.addEventListener("click", function() {
    loadIframe(globalCovidApi);
  });
});
