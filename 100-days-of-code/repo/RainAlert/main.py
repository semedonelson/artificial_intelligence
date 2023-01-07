#Note! For the code to work you need to replace all the placeholders with
#Your own details. e.g. account_sid, lat/lon, from/to phone numbers.

import requests
from twilio.rest import Client

OWM_Endpoint = "https://api.openweathermap.org/data/2.5/weather"
# api_key = os.environ.get("ddf6fec1baef20440f40536169a71550")
api_key = "ddf6fec1baef20440f40536169a71550"
account_sid = "ACfcaf5ceea8dc0ea3bcbda224026e6982"
# auth_token = os.environ.get("17e76a852e4f590d4ff1728d771717b7")
auth_token = "17e76a852e4f590d4ff1728d771717b7"

weather_params = {
    "lat": "41.150150",
    "lon": "-8.610320",
    "appid": api_key
}

response = requests.get(OWM_Endpoint, params=weather_params)
response.raise_for_status()
weather_data = response.json()
weather = weather_data["weather"][0]

will_rain = False

if int(weather["id"]) < 700:
    will_rain = True

if will_rain:
    client = Client(account_sid, auth_token)
    message = client.messages \
        .create(
        body="It's going to rain today. Remember to bring an ☔️",
        from_="+13393310480",
        to="+351937395536"
    )
    print(message.status)
