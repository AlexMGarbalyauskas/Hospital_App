// app/assets/javascripts/global_covid_chart.js

// 
//  Handles rendering of the global COVID-19 statistics Plotly bar chart.
//  Reads numeric values from data-* attributes on the chart container div.
// 

document.addEventListener("DOMContentLoaded", function() {
  const graphDiv = document.getElementById("globalCovidGraph");
  if (!graphDiv) return; // Safety check



  // Extract data from HTML dataset
  const cases     = Number(graphDiv.dataset.cases);
  const deaths    = Number(graphDiv.dataset.deaths);
  const recovered = Number(graphDiv.dataset.recovered);
  const active    = Number(graphDiv.dataset.active);
  const critical  = Number(graphDiv.dataset.critical);
  const tests     = Number(graphDiv.dataset.tests);



  // Define bar chart data
  const data = {
    x: ['Cases', 'Deaths', 'Recovered', 'Active', 'Critical', 'Tests'],
    y: [cases, deaths, recovered, active, critical, tests],
    type: 'bar',
    marker: {
      color: [
        '#007bff', // Cases blue
        '#dc3545', // Deaths red
        '#28a745', // Recovered green
        '#ffc107', // Active yellow
        '#fd7e14', // Critical orange
        '#6c757d'  // Tests gray
      ]
    }
  };


  // Layout configuration
  const layout = {
    title: 'Global COVID-19 Statistics',
    yaxis: { title: 'Count' },
    margin: { t: 50, l: 50, r: 50, b: 50 }
  };


  // Render the Plotly chart
  Plotly.newPlot('globalCovidGraph', [data], layout);
});
