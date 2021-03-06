{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "eb1bdb98-5dc5-4263-9e8d-684bf78bdaa2",
   "metadata": {},
   "outputs": [],
   "source": [
    "import json\n",
    "import requests\n",
    "import pymysql\n",
    "import pandas as pd\n",
    "import sqlalchemy # install if needed\n",
    "from sqlalchemy import create_engine\n",
    "  \n",
    "def lambda_handler(event, context):\n",
    "    \n",
    "    #for connection to AWS instance\n",
    "    \n",
    "    #cnx = pymysql.connect(\n",
    "    #user='*******',\n",
    "    #password='*****',\n",
    "    #host='*******crwyz9bzt8io.eu-central-1.rds.amazonaws.com',\n",
    "    #database='****')\n",
    "\n",
    "    #for cities data\n",
    "    \n",
    "    schema = \"******\"\n",
    "    host = \"*******crwyz9bzt8io.eu-central-1.rds.amazonaws.com\"\n",
    "    user = \"*****\"\n",
    "    password =\"*******\"\n",
    "    port = 3306\n",
    "    con = f\"mysql+pymysql://{user}:{password}@{host}:{port}/{schema}\"\n",
    "    engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}:{port}/{schema}', echo=False)\n",
    "    cities_df = pd.read_sql_table(\"cities\", con=engine)\n",
    "    \n",
    "    cities = cities_df[\"city\"].to_list()\n",
    "\n",
    "    #creating function for weather \n",
    "    \n",
    "    def get_weather_data(cities):\n",
    "        weather_list = []\n",
    "        url = f\"http://api.openweathermap.org/data/2.5/forecast?q=Berlin&appid={'APIKEY'}&units=metric\"\n",
    "        test = requests.get(url)\n",
    "\n",
    "        if test.status_code >= 200  and test.status_code <= 299:\n",
    "            for city in cities:\n",
    "                url = f\"http://api.openweathermap.org/data/2.5/forecast?q={city}&appid={'APIKEY'}&units=metric\"\n",
    "                weather = requests.get(url)\n",
    "                weather_df = pd.json_normalize(weather.json()[\"list\"])\n",
    "                weather_df[\"city\"] = city\n",
    "                weather_list.append(weather_df)\n",
    "                \n",
    "        else:\n",
    "            return -1\n",
    "        weather_combined = pd.concat(weather_list, ignore_index = True)\n",
    "        return weather_combined\n",
    "            \n",
    "\n",
    "    #rename the tables names\n",
    "    \n",
    "    weather_data = get_weather_data(cities)\n",
    "    \n",
    "    weather_data = weather_data[[\"pop\", \"dt_txt\", \"main.temp\", \"main.feels_like\", \"main.humidity\", \"clouds.all\", \n",
    "                             \"wind.speed\", \"wind.gust\", \"city\"]]\n",
    "                             \n",
    "    weather_data.rename(columns = {\"pop\": \"precip_prob\", \n",
    "                               \"dt_txt\": \"forecast_time\", \n",
    "                               \"main.temp\": \"temperature\",\n",
    "                               \"main.feels_like\": \"feels_like\",\n",
    "                               \"main.humidity\": \"humidity\", \n",
    "                               \"clouds.all\": \"cloudiness\", \n",
    "                               \"wind.speed\": \"wind_speed\", \n",
    "                               \"wind.gust\": \"wind_gust\",}, \n",
    "                    inplace = True)                 \n",
    "                    \n",
    "    weather_data = weather_data.merge(cities_df[[\"city_id\", \"city\"]], how = \"left\", on = \"city\")\n",
    "    weather_data[\"forecast_time\"] = pd.to_datetime(weather_data[\"forecast_time\"])\n",
    "\n",
    "    weather_data.to_sql(\"weathers\", if_exists = \"append\", con = engine, index = False)\n",
    "    \n",
    "    # connect to database\n",
    "    # insert data to table\n",
    "    # commit changes & close connection\n",
    "    \n",
    "    #cursor = cnx.cursor()\n",
    "    #cnx.commit()\n",
    "    #cursor.close()\n",
    "    #cnx.close()"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.9.7"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
