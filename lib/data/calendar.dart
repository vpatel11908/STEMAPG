import 'backendscurve.dart';
import 'dart:math';
class Calendar {
  double getSessionLength(double sessionLength) {
    return sessionLength;
  }
  double getMotivation(double motivation) {
    return motivation;
  }
  double getMaxVal(double maxVal) {
    return maxVal;
  }
  double getTimePeriod(double timePeriod) {
    return timePeriod;
  }
  double getTotalLength(double totalLength) {
    return totalLength;
  }
  // Generates the calendar based on the S-Curve values and the time period
  List<double> generateCalendar(double sessionLength, double timePeriod, maxVal, double motivation, totalLength){
    List<double> slopes = [];
    // calculates the slope of the S-Curve at each time point by using the derivative (so like it takes the derivative of the s-curve function and then just plugs the numbers into the resulting equatoin)
    for (int t = 1; t < timePeriod; t++) {
      double exponent = exp(-BackendSCurve.calculateGrowthRate(sessionLength)*(t-BackendSCurve.calculateMidpoint(motivation, timePeriod)));
      double slope = (maxVal * BackendSCurve.calculateGrowthRate(sessionLength) * exponent) / pow(1 + exponent, 2);
      slopes.add(slope);
    }
    // adds all the slopes to a new list
    double sum = 0;
    for (int i = 0; i<slopes.length; i++){
      sum += slopes[i];
    }
    // Normalizes the slopes to all represent the amount of minutes of work needed to be done at that point on the time interval (this will represent a day)
    double sessionsAVGSlope = sum/totalLength;
    for(int i = 0; i<slopes.length; i++){
      slopes[i] = slopes[i]/sessionsAVGSlope;
      slopes[i] *= 60;
      slopes[i] = (slopes[i]).roundToDouble();
    }
    return slopes;
  }
  List<double> fixCalendar(double sessionLength, double timePeriod, maxVal, double motivation, totalLength, List<double> hoursAvailable){
    List<double> slopes = generateCalendar(sessionLength, timePeriod, maxVal, motivation, totalLength);
    //goes thru every i value and checks if the amount of work hours scheduled for that day are greater than the hours the person is available
    for (int i = 0; i<slopes.length; i++){
      // if the amount of hours scheduled cannot be fit they will be split up evenely among the remaining days and subtracted from the current day (where the overflow exists)
      if (slopes[i] > hoursAvailable[i]){
        for(int j = i+1; j<slopes.length; j++){
          slopes[j] = slopes[j] + (slopes[i]/(slopes.length-i+1));
        }
        slopes[i] = hoursAvailable[i];
      }
    }
    return slopes;
  }
}