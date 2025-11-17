// app/assets/javascripts/vaccine_map.js
//
// Handles the vaccination map rendering, circle overlays,
// color maps, radius maps, and modal interactions.
// All vaccine data is read from HTML data-* attributes.
//

// Callback triggered when Google Maps API finishes loading
window.initVaccineMap = async function () {

  // Ensure GMP components exist
  try {
    await customElements.whenDefined("gmp-map");
  } catch (e) {
    console.warn("gmp-map not defined", e);
  }

  const mapEl = document.getElementById("gmpMap");
  if (!mapEl) return;

  // Disable map type selector for cleaner UI
  try {
    if (mapEl.innerMap?.setOptions) {
      mapEl.innerMap.setOptions({ mapTypeControl: false });
    }
  } catch (e) {}

  // ---- Parse vaccine data from dataset ----
  let raw = mapEl.dataset.vaccineData || "{}";
  let vaccineData = {};

  try {
    vaccineData = JSON.parse(raw);
  } catch (e) {
    console.warn("Invalid vaccine JSON", e);
  }

  // Build a normalized list of entries {country, value}
  let entries = [];

  if (Array.isArray(vaccineData)) {
    vaccineData.forEach(it => {
      let country = it.country || it.name;
      let value =
        it.timeline ? Object.values(it.timeline).pop() :
        it.coverage || it.vaccinated || 0;

      if (country) {
        entries.push({ country: String(country), value: Number(value) || 0 });
      }
    });

  } else if (vaccineData && typeof vaccineData === "object") {
    Object.keys(vaccineData).forEach(k => {
      entries.push({ country: k, value: Number(vaccineData[k]) || 0 });
    });
  }

  // Load country centroids
  let CENTROIDS = {};
  try {
    const res = await fetch("/country_centroids.json");
    if (res.ok) CENTROIDS = await res.json();
  } catch (e) {
    console.warn("Failed loading centroids", e);
  }

  // ----- Normalize country names -----
  // This ensures consistent lookups for colorMap, radiusMap, CENTROIDS
  function normalizeName(n) {
    if (!n) return n;
    n = n.replace(/\s*\(.*?\)\s*/g, "") // remove parenthetical info
         .replace(/&/g, "and")          // replace & with "and"
         .trim();

    // Custom normalization for known mismatches
    if (n === "USA") return "United States";
    if (n === "UK") return "United Kingdom";
    if (n === "S. Korea") return "South Korea";

    return n;
  }

  // Get global max for ratio scaling
  const maxValue = Math.max(...entries.map(e => e.value || 0), 1);
  const infowindow = new google.maps.InfoWindow();

  // ----- Predefined custom colors -----
  const colorMap = {
    "Russia": "blue",
    "Canada": "red",
    "Mexico": "green",
    "United States": "navy",
    "Ireland": "green",
    "India": "orange",
    "United Kingdom": "red",
    "Brazil": "purple",
    "Australia": "orange",
    "Japan": "yellow",
    "South Korea": "pink",
    "Germany": "black",
    "Ukraine": "yellow",
    "Sweden": "yellow",
    "France": "blue",
    "Iran": "green",
    "Egypt": "orange",
    "Algeria": "green"
  };

  // ----- Predefined radii -----
  const radiusMap = {
    "Russia": 1000000,
    "Canada": 900000,
    "Mexico": 498000,
    "United States": 950000,
    "Ireland": 80000,
    "United Kingdom": 70000,
    "Brazil": 900000,
    "Australia": 850000,
    "Japan": 720000,
    "South Korea": 72000,
    "Germany": 198000,
    "Ukraine": 194000,
    "Sweden": 194000,
    "France": 294000,
    "Iran": 390000,
    "Egypt": 350000,
    "India": 850000,
    "Algeria": 350000
  };

  // ----- Draw circles -----
  entries.forEach(e => {
    const countryKey = normalizeName(e.country);

    // Get coordinates
    const coord = CENTROIDS[countryKey] || null;
    if (!coord) return; // skip if coordinates missing

    // Compute value ratio
    const ratio = (e.value || 0) / maxValue;

    // Determine circle color
    const circleColor = colorMap[countryKey] ||
      (ratio > 0.66 ? "#1a9850" : ratio > 0.33 ? "#fee08b" : "#d73027");

    // Determine circle radius
    const radius = radiusMap[countryKey] ||
      Math.max(40000, Math.sqrt((e.value || 0) / maxValue) * 800000);

    // Draw circle
    const circle = new google.maps.Circle({
      strokeColor: circleColor,
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: circleColor,
      fillOpacity: 0.35,
      map: mapEl.innerMap,
      center: coord,
      radius
    });

    // Show info window on click
    circle.addListener("click", () => {
      infowindow.setContent(
        `<strong>${e.country}</strong><br>${(e.value || 0).toLocaleString()} total`
      );
      infowindow.setPosition(circle.getCenter());
      infowindow.open(mapEl.innerMap);
    });
  });
};

// Re-init on Turbo navigation
document.addEventListener("turbo:load", () => {
  if (window.google && typeof window.initVaccineMap === "function") {
    window.initVaccineMap();
  }
});
