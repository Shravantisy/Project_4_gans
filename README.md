# Project_4_gans
All about Data Engineering(API's, AWS)

Gans is a startup developing an e-scooter-sharing system. It aspires to operate in the most populous cities all around the world. In each city, it will have hundreds of e-scooters parked in the streets and allows users to rent them by the minute.

Gans has seen that its operational success depends on something more mundane: having their scooters parked where users need them.
Ideally, scooters get rearranged organically by having certain users moving from point A to point B, and then an even number of users moving from point B to point A. There are some elements that create asymmetries. Here are some of them:

In hilly cities, users tend to use scooters to go uphill and then walk downhill.
In the morning, there is a general movement from residential neighbourhoods towards the city centre.
Whenever it starts raining, e-scooter usage decreases drastically.
Whenever airplanes with back-pack young tourists lands, a lot of scooters are needed close to the airport.
for this things we need Data(cities, weather, airports, flights).


### Summary of work done so far:

#### Data Collection
1.Scrape data from the wikipedia.(webscraping library: beautifulsoup)

2.Collect data with APIs.

#### Data Storage
1.Create a database model.

2.Store data on a local MySQL instance.

#### Cloud pipeline
1.Set up a cloud database(Amazon Web Services (AWS), to set up MySQL database)

2.Move scripts to Lambda.

#### Automate the pipeline
-used CloudWatch Events / EventBridge 


##### API's
APIs 1: Collect weather data (https://openweathermap.org/api)

APIs 2: Collect airports data (https://rapidapi.com/hub)

APIs 3: Collect flights data (https://rapidapi.com/hub)

