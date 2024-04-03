from flask import Flask, request

app = Flask(__name__)

@app.route('/upload_photo/', methods=['POST'])
def upload_photo():
    comment = request.form['comment']
    latitude = request.form['latitude']
    longitude = request.form['longitude']
    photo = request.form['photo']

    return 'Received photo with comment: {}, latitude: {}, longitude: {}'.format(comment, latitude, longitude)

if __name__ == '__main__':
    app.run(debug=True)