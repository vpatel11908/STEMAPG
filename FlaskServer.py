from flask import Flask, jsonify, request, send_file
import math
import matplotlib.pyplot as plt
import io

app = Flask(__name__)

# S-Curve calculation functions
def s_curve(t, maxVal, midpoint, growthRate):
    return maxVal / (1 + math.exp(-growthRate * (t - midpoint)))

def returnVals(maxVal, midpoint, growthRate, endPeriod):
    return [s_curve(t, maxVal, midpoint, growthRate) for t in range(0, endPeriod)]

@app.route('/calculate', methods=['POST'])
def calculate_s_curve():
    try:
        data = request.get_json()
        motivation = data.get('motivation', 5)
        sessionLength = data.get('sessionLength', 10)
        timePeriod = data.get('timePeriod', 100)
        maxVal = 100

        # Calculate midpoint
        if motivation < 3.5:
            midpoint = timePeriod / 4
        elif 3.5 <= motivation < 7:
            midpoint = timePeriod / 2
        else:
            midpoint = (3 * timePeriod) / 4

        # Calculate growthRate
        if sessionLength < 3.5:
            growthRate = 0.06
        elif 3.5 <= sessionLength < 7:
            growthRate = 0.12
        else:
            growthRate = 0.20

        # Calculate S-Curve values
        endperiod = timePeriod
        values = returnVals(maxVal, midpoint, growthRate, endperiod)
        return jsonify({'values': values})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/plot', methods=['GET'])
def plot_graph():
    values = returnVals(100, 50, 0.12, 100)
    xvals = list(range(0, 100))
    plt.plot(xvals, values)
    plt.xlabel('Time')
    plt.ylabel('Achievement Index')
    plt.title('S-Curve')

    # Save the plot to a BytesIO object
    img = io.BytesIO()
    plt.savefig(img, format='png')
    plt.close()
    img.seek(0)
    return send_file(img, mimetype='image/png')

if __name__ == '__main__':
    import os
    port = int(os.environ.get('PORT', 5001))
    print("Starting Flask server...")
    try:
        app.run(debug=True, host='127.0.0.1', port=port)
    except Exception as e:
        print(f"Error starting server: {e}")