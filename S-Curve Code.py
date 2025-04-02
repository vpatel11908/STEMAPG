import math
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Quiz Input Variables
# motivation describes the period during which the person is most likely to be enthusiastic about the project (adjusted to a scale of 1-10)
motivation = 5
# sessoinLength is the ideal amount of time that the person wishes to spend on the project at a time(adjusted to a scale of 1-10)
sessionLength = 10
# Time period is the total measurement of time the entire project will run across (i.e. 6 months)
timePeriod = 100
# Saturation Value - The value which would essentially be the max
# For the purpose of this project, the max value is set to 100 since it is supposed to simulate percentage
maxVal = 100

# Calculate midpoint based on motivation
if motivation < 3.5:
    midpoint = timePeriod / 4
elif 3.5 <= motivation < 7:
    midpoint = timePeriod / 2
else:
    midpoint = (3 * timePeriod) / 4

# Calculate growthRate based on sessionLength
if sessionLength < 3.5:
    growthRate = 0.06
elif 3.5 <= sessionLength < 7:
    growthRate = 0.12
else:
    growthRate = 0.20

endperiod = timePeriod
# Calculates S-Curve Values
def s_curve(t, maxVal, midpoint, growthRate):
    return maxVal / (1 + math.exp(-growthRate * (t - midpoint)))
# Returns S-Curve Values
def returnVals(maxVal, midpoint, growthRate, endPeriod):
    return [s_curve(t, maxVal, midpoint, growthRate) for t in range(0, endPeriod)]

values = returnVals(maxVal, midpoint, growthRate, endperiod)
xvals = list(range(0, endperiod))
# Graph Related Stuff
plt.plot(xvals, values)
plt.xlabel('Time')
plt.ylabel('Achievement Index')
plt.title('S-Curve')
plt.show()