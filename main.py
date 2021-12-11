# --- importation des différentes librairies nécessaires pour le projet ---
import adafruit_dht as dht  # librairie pour le module dht11
from board import D23  # libraire pour avoir acces aux ports gpio
from flask import Flask, jsonify, request  # librairie framework web
import sys
from Carte import *
from datetime import datetime
import collections
from waitress import serve

sensor = dht.DHT11(D23)  # definir la pin D23 à un sensor

sys.tracebacklimit = 0  # pour éviter  d'afficher les erreurs liées au rafraichissement de la carte

last_temp = collections.deque(maxlen=1)  # creation d'une liste de taille 1 pour avoir la derniere mesure de la temp
last_humi = collections.deque(maxlen=1)  # creation d'une liste de taille 1 pour avoir la derniere mesure de l'humi

last_temp.append(0)  # on append la premiere valeur
last_humi.append(0)  # on append la premiere valeur

carte1 = Carte(2)  # creation d'une instance de la classe Carte avec 2 capteurs à l'intérieur
capteur1 = Capteur("degres", 1)  # création d'un capteur pour la temperature
capteur2 = Capteur("humidite", 2)  # creation d'un capteur pour l'humidite
carte1.ajouterCapteur(capteur1, 0)  # ajout du premier cpateur à la carte
carte1.ajouterCapteur(capteur2, 1)  # ajout du deuxieme cpateur à la carte

app = Flask(__name__)  # on crée une instance de l'application flask


@app.route('/meteo', methods=['GET'])  # on définit une route vers l'url /meteo
def get_meteo():  # si l'url est /meteo, on execute cette fonction
    try:  # essayer de recuperer les données du capteur
        date = datetime.now().strftime("%d/%m/%Y %H:%M")  # on récupere la date et l'heure
        humi = sensor.humidity  # on recupere la valeur de l'humidite du capteur
        temp = sensor.temperature  # on recupere la valeur de la temperature du capteur
        last_temp.append(temp)  # on append la valeur la plus recente
        last_humi.append(humi)  # on append la valeur la plus recente
        capteur1.setMesure(temp)  # on modifie les valeurs des temperatures du capteur1
        capteur2.setMesure(humi)  # on modifie les valeurs des humidites du capteur2
        print("temperature=", capteur1.getMesure())
        print("humidite=", capteur2.getMesure())  # affiche les donnees
        return jsonify(temperature=capteur1.getMesure(), humidity=capteur2.getMesure(), date=date)
        # On retourne un json contenant les données à afficher dans l'application
    except RuntimeError:  # si on a un probleme avec le capteur (exemple : rafraichissement)
        date = datetime.now().strftime("%d/%m/%Y %H:%M")  # on récupere la date et l'heure
        print("Pas trop vite avec le rafraichissement !")  # on affiche un msg dans la console
        return {"temperature": last_temp[0], "humidity": last_humi[0], "date": date}, 601
        # on retourne un code http 601 (crée pour l'occasion) qui sera interpreté par l'app
        # on retourne les dernieres valeurs mesurées par le capteur depuis les listes


if __name__ == "__main__":
        # app.run(host="0.0.0.0") on lance l'application
        serve(app, host="0.0.0.0", port=5000)
