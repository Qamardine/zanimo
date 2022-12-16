from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/", methods= ['GET'])
def index():
    with open('../../data.txt', 'r') as f:
        coord = f.readlines()
    return jsonify({'longitude' : str(coord[0]),
    'latitude': str(coord[1])})


if __name__ == "__main__":
    app.run(debug=True)