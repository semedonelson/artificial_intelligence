import requests
from twilio.rest import Client

STOCK = "TSLA"
COMPANY_NAME = "Tesla Inc"
NEWS_TO_SEARCH = "tesla"
STOCK_PRICE_URL = "https://www.alphavantage.co/query"
NEWS_URL = "https://newsapi.org/v2/everything"
STOCK_API_KEY = "VQ0HF7LJ3KOCRWIN"
NEWS_API_KEY = "d89d8cf32ab94646abbaff5b7012a7a2"
FUNCTION_TYPE = "TIME_SERIES_INTRADAY"
INTERVAL = "60min"
account_sid = "ACfcaf5ceea8dc0ea3bcbda224026e6982"
auth_token = "17e76a852e4f590d4ff1728d771717b7"

## STEP 1: Use https://www.alphavantage.co
# When STOCK price increase/decreases by 5% between yesterday and the day before yesterday then print("Get News").
stock_parameters = {
    "function": FUNCTION_TYPE,
    "symbol": STOCK,
    "interval": INTERVAL,
    "apikey": STOCK_API_KEY
}
news_parameters = {
    "qInTitle": NEWS_TO_SEARCH,
    "apiKey": NEWS_API_KEY
}
stock_data_request = requests.get(STOCK_PRICE_URL, params=stock_parameters)
stock_data_request.raise_for_status()
data = stock_data_request.json()[f"Time Series ({INTERVAL})"]
# convert dict to a list
data_list = [value for (key, value) in data.items()]
yesterday_close = float(data_list[0]["4. close"])
day_before_yesterday_close = float(data_list[1]["4. close"])

difference = yesterday_close - day_before_yesterday_close
up_down = None
if difference > 0:
    up_down = "⬆️"
else:
    up_down = "⬇️"
dif_percentage = round((difference / yesterday_close) * 100, 2)

if abs(dif_percentage) >= 0.4:
    ## STEP 2: Use https://newsapi.org
    # Instead of printing ("Get News"), actually get the first 3 news pieces for the COMPANY_NAME.
    # Init
    news_data_request = requests.get(NEWS_URL, news_parameters)
    news_data_request.raise_for_status()
    articles = news_data_request.json()["articles"]
    articles_to_send = articles[:3]
    ## STEP 3: Use https://www.twilio.com
    # Send a seperate message with the percentage change and each article's title and description to your phone number.
    formatted_articles = [f"{STOCK}: {up_down} {dif_percentage}%\nHeadline: {article['title']}. \nBrief: {article['description']}" for article in articles_to_send]

    client = Client(account_sid, auth_token)
    for article in formatted_articles:
        message = client.messages \
            .create(
            body=article,
            from_="+13393310480",
            to="+351937395536"
        )
        print(message.status)


#Optional: Format the SMS message like this: 
"""
TSLA: 🔺2%
Headline: Were Hedge Funds Right About Piling Into Tesla Inc. (TSLA)?. 
Brief: We at Insider Monkey have gone over 821 13F filings that hedge funds and prominent investors are required to file by the SEC The 13F filings show the funds' and investors' portfolio positions as of March 31st, near the height of the coronavirus market crash.
or
"TSLA: 🔻5%
Headline: Were Hedge Funds Right About Piling Into Tesla Inc. (TSLA)?. 
Brief: We at Insider Monkey have gone over 821 13F filings that hedge funds and prominent investors are required to file by the SEC The 13F filings show the funds' and investors' portfolio positions as of March 31st, near the height of the coronavirus market crash.
"""

