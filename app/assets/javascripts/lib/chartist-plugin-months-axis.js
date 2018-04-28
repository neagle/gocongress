(function(root, factory) {
  if (typeof define === "function" && define.amd) {
    // AMD. Register as an anonymous module.
    define([], function() {
      return (root.returnExportsGlobal = factory());
    });
  } else if (typeof exports === "object") {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like enviroments that support module.exports,
    // like Node.
    module.exports = factory();
  } else {
    root["Chartist.MonthsAxis"] = factory();
  }
})(this, function() {
  /**
   * Created by adilbenmoussa on 03/12/2016.
   * Chartist.js plugin to add fixed month scale axis to the chart.
   *
   * It will create a 13 fixed steps representing the 12 months plus one step
   * to guarantee a space in the last month December. (so the min value will be 01-01-yyyy and the max item will
   * be 31-12-yyyy.
   *
   * @module Chartist.MonthsAxis
   */
  /* global Chartist */
  (function(window, document, Chartist) {
    "use strict";

    function MonthsAxis(axisUnit, data, chartRect, options) {
      this.year = options.year;
      this.ticks = getMonthTicks(this.year);
      this.divisor = this.ticks.length;
      this.range = {
        min: this.ticks[0],
        max: this.ticks[this.ticks.length - 1]
      };

      Chartist.MonthsAxis.super.constructor.call(
        this,
        axisUnit,
        chartRect,
        this.ticks,
        options
      );

      this.stepLength = this.axisLength / this.divisor;
    }

    function projectValue(value) {
      return (
        this.axisLength *
        (+Chartist.getMultiValue(value, this.units.pos) - this.range.min) /
        (this.range.max - this.range.min)
      );
    }

    /**
     * Creates an array with 13 timestamps, 12 of them are for the start day of each month
     * and last one is for the end the of December.
     *
     * @param year
     * @returns {Array}
     */
    function getMonthTicks(year) {
      return Array.apply(null, new Array(13)).map(function(x, i) {
        var month = i,
          day = 1;

        // In step 13 (from 1 dec to 31 dec) create the correct values for the date.
        // This step is needed since we need some space to project the values in the last month
        if (i === 12) {
          month = 11;
          day = 31;
        }

        return new Date(year, month, day).getTime();
      });
    }

    Chartist.MonthsAxis = Chartist.Axis.extend({
      constructor: MonthsAxis,
      projectValue: projectValue
    });
  })(window, document, Chartist);

  return Chartist.MonthsAxis;
});
