// app/assets/javascripts/covid_chart.js

// 
//  Handles rendering of Plotly chart for COVID-19 historical data.
//  Reads `data-dates` and `data-cases` from the HTML placeholder div.
// 

document.addEventListener("DOMContentLoaded", function () {
  const plotDiv = document.getElementById("covid_plot");
  if (!plotDiv) return; // safety check

  // Convert CSV strings from data attributes into arrays
  const dates = plotDiv.dataset.dates.split(",");
  const cases = plotDiv.dataset.cases.split(",").map(Number);

  // Plotly trace configuration
  const trace = {
    x: dates,
    y: cases,
    type: "scatter",
    mode: "lines+markers",
    name: "New Cases",
    line: { color: "rgba(0, 123, 255, 1)", width: 2 },
    marker: { color: "rgba(0, 123, 255, 0.8)" }
  };

  // Layout settings (title, axes, margins)
  const layout = {
    title: "Global COVID-19 Daily New Cases",
    xaxis: { title: "Date" },
    yaxis: { title: "New Cases" },
    margin: { l: 60, r: 30, t: 60, b: 80 }
  };

  // Render chart
  Plotly.newPlot("covid_plot", [trace], layout);
});
