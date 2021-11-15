from flask import Flask, jsonify, request
import requests
import random
import json

app = Flask(__name__)

@app.route('/meteo', methods=['GET'])
def get_meteo():
    ville = request.args.get('ville')
    response = requests.get(
        "http://api.weatherapi.com/v1/current.json?key=fea69b4e481a47d5972153151212709&q=" + str(ville) + "&aqi=no")
    if "current" in response.json():
        current = response.json()["current"]["condition"]["text"]
        temp_c = response.json()["current"]["temp_c"]
        ressenti = response.json()["current"]["feelslike_c"]
        return jsonify("ville", ville, "actuellement", current, "temperature", temp_c, "ressenti", ressenti)
    else:
        return("Cette ville n'existe pas")


@app.route('/random', methods=['GET'])
def get_test():
    premier = request.args.get('premier', None)
    last = request.args.get('dernier')
    return "votre premier nombre est :" + premier + ", le second est :" + last + ". Votre nombre est :" + str(
        random.randint(int(premier), int(last)))


app.run()