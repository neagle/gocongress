console.log("Chartist", Chartist);
console.log("Moment", moment);
document.addEventListener("DOMContentLoaded", function() {
  var data = JSON.parse(
    document.getElementById("registrations-chart").dataset.chart
  );
  console.log("data", data);

  var tauData = Object.entries(data)
    .map(([year, dates]) => {
      return Object.entries(dates).map(([date, count]) => {
        return {
          type: year,
          date: new Date(`${date}-2018`),
          // date,
          count
        };
      });
    })
    .reduce((a, b) => [...a, ...b]);

  console.log("tauData", tauData);

  var chart = new tauCharts.Chart({
    data: tauData,
    type: "line",
    x: "date",
    y: "count",
    color: "type",
    guide: {
      interpolate: "smooth-keep-extremum",
      padding: { l: 70, t: 10, b: 70, r: 10 },
      showGridLines: "xy",
      y: {
        padding: 20,
        label: {
          text: "Attendee Registrations",
          padding: 40
        }
      },
      x: {
        padding: 20,
        label: {
          text: "Month",
          padding: 35
        }
        // tickPeriod: "month",
      }
    },
    plugins: [
      tauCharts.api.plugins.get("legend")(),
      tauCharts.api.plugins.get("tooltip")()
    ]
  });

  chart.renderTo("#registrations-chart");

  // CHARTIST
  /*
  var series = [];
  for (var key in data) {
    var yearData = [];
    for (var date in data[key]) {
      yearData.push({ x: new Date(date), y: data[key][date] });
    }

    series.push({
      name: key,
      data: yearData
    });
  }

  console.log("series", series);

  var chart = new Chartist.Line(
    "#registrations-chart",
    {
      series: series
    },
    {
      axisX: {
        type: Chartist.FixedScaleAxis,
        divisor: 12,
        labelInterpolationFnc: function(value) {
          return moment(value).format("MMM D");
        }
      },
      showArea: true,
      showLine: false,
      showPoint: false,
      plugins: [Chartist.plugins.legend()]
    }
  );
  */
});
