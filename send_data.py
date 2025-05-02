import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import random
import time

# Initialise Firebase Admin SDK avec le fichier JSON d'authentification
cred = credentials.Certificate(r'C:\Users\USER\smartpot\android\app\smartpot-3d8a5-firebase-adminsdk-fbsvc-85a878d7c5.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://smartpot-3d8a5-default-rtdb.firebaseio.com/'
})

# Fonction pour générer des valeurs aléatoires
def generate_random_data():
    light = random.uniform(0, 1000)
    humidity = random.uniform(0, 100)
    soil_moisture = random.uniform(0, 100)
    temperature = random.uniform(15, 35)
    return {
        'light': light,
        'humidity': humidity,
        'soil_moisture': soil_moisture,
        'temperature': temperature,
        'timestamp': time.strftime('%Y-%m-%d %H:%M:%S')
    }

# Envoi des données vers Firebase
def send_data_to_firebase():
    try:
        data = generate_random_data()
        ref = db.reference('sensors_data')
        ref.push(data)
        print(f"Données envoyées: {data}")
    except Exception as e:
        print(f"Erreur lors de l'envoi des données : {e}")

# Boucle d'envoi toutes les 10 secondes
while True:
    send_data_to_firebase()
    time.sleep(10)
