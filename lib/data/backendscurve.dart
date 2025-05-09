import 'dart:math';
class BackendSCurve {
  // Method to calculate the midpoint - the motivation determins this like the time period is just for the sake of keeping a standardized midpoint
  static double calculateMidpoint(double motivation, double timePeriod) {
    if (motivation < 3.5) {
      return timePeriod / 4;
    } else if (motivation >= 3.5 && motivation < 7) {
      return timePeriod / 2;
    } else {
      return timePeriod * 3 / 4;
    }
  }

  // Method to calculate the growth rate
  static double calculateGrowthRate(sessionLength) {
    if (sessionLength < 3.5) {
      return 0.06;
    } else if (sessionLength >= 3.5 && sessionLength < 7) {
      return 0.12;
    } else {
      return 0.20;
    }
  }
  // Calcuates S-Curve values
  static List<double> sCurveValues(double maxVal, double midpoint, double growthRate, double endPeriod) {
    List<double> values = [];
    for (double t = 0; t <= endPeriod; t++) {
      double sCurveValue = maxVal / (1 + exp(-growthRate*(t-midpoint)));
      values.add(sCurveValue);
    }
    return values;
  }

  // Implements S-Curve calculatoin
  static List<double> implement(double sessionLength, double motivation, double maxVal, double timePeriod) {
    // Calculates growth rate
    double growthRate = calculateGrowthRate(sessionLength);

    // Calculates midpoint
    double midpoint = calculateMidpoint(motivation, timePeriod);

    // Generates S-curve values
    return sCurveValues(maxVal, midpoint, growthRate, timePeriod);
  }
}