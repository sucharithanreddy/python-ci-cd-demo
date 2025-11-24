from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/api/health")
def health():
    return jsonify(status="ok")


@app.route("/api/hello")
def hello():
    return jsonify(message="Hello from Python CI/CD demo!")


if __name__ == "__main__":
    # For local development
    app.run(host="0.0.0.0", port=8000)