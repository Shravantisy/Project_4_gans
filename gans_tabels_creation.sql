#DROP DATABASE gans;
CREATE DATABASE gans;
USE gans;


# Setting up cities table
# Alter table's datatypes of the columns and set primary key
CREATE TABLE IF NOT EXISTS cities(
`city_id` VARCHAR(10),
`city` VARCHAR(100),
`country` VARCHAR(100),
`country_code` VARCHAR(5),
`region` VARCHAR(100),
`elevation` INT,
`city_latitude` FLOAT,
`city_longitude` FLOAT,
`population` INT,
 PRIMARY KEY (`city_id`)
);

#inserting values
ALTER TABLE `gans`.`cities` 
CHANGE COLUMN `city_id` `city_id` VARCHAR(10) NOT NULL,
CHANGE COLUMN `city` `city` VARCHAR(100) NULL,
CHANGE COLUMN `country` `country` VARCHAR(100) NULL,
CHANGE COLUMN `country_code` `country_code` VARCHAR(5) NULL ,
CHANGE COLUMN `region` `region` VARCHAR(100) NULL,
CHANGE COLUMN `elevation` `elevation` INT NULL,
CHANGE COLUMN `city_latitude` `city_latitude` FLOAT NULL,
CHANGE COLUMN `city_longitude` `city_longitude` FLOAT NULL,
CHANGE COLUMN `population` `population` INT NULL;
#DESCRIBE cities;


# Setting up weather table
# Before altering datatypes and setting key, weather has duplicate forecast_time values, therefore 
# a new ID column with unique values is necessary for the primary key
 


# Alter table's datatypes of the columns and set primary key:
CREATE TABLE IF NOT EXISTS weathers(

`precip_prob` FLOAT,
`forecast_time` DATETIME,
`temperature` FLOAT,
`feels_like` FLOAT,
 `humidity` INT,
`cloudiness` INT,
`wind_speed` FLOAT,
`wind_gust` FLOAT,
`city` VARCHAR(100),
`city_id` VARCHAR(10)
);


ALTER TABLE `gans`.`weathers` 
ADD weather_id INT;



ALTER TABLE `gans`.`weathers` 
CHANGE COLUMN `precip_prob` `precip_prob` FLOAT NULL,
CHANGE COLUMN `forecast_time` `forecast_time` DATETIME NULL,
CHANGE COLUMN `temperature` `temperature` FLOAT NULL,
CHANGE COLUMN `feels_like` `feels_like` FLOAT NULL,
CHANGE COLUMN `humidity` `humidity` INT NULL,
CHANGE COLUMN `cloudiness` `cloudiness` INT NULL,
CHANGE COLUMN `wind_speed` `wind_speed` FLOAT NULL,
CHANGE COLUMN `wind_gust` `wind_gust` FLOAT NULL,
CHANGE COLUMN `city` `city` VARCHAR(100) NULL,
CHANGE COLUMN `city_id` `city_id` VARCHAR(10) NULL ,
CHANGE COLUMN `weather_id` `weather_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
#DESCRIBE weathers;
# Setting foreign key:
#CREATE TABLE IF NOT EXISTS weathers;
#ALTER TABLE `gans`.`weathers` 
ADD INDEX `weather_city_id_idx` (`city_id` ASC) VISIBLE,
#ALTER TABLE `gans`.`weathers` 
ADD CONSTRAINT `weather_city_id`
FOREIGN KEY (`city_id`)
REFERENCES `gans`.`cities` (`city_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE weathers;




# Setting up airports table
# Alter table's datatypes of the columns and set primary key
CREATE TABLE IF NOT EXISTS airports(
`icao` CHAR(4) ,
`iata` CHAR(3),
`airport_name` VARCHAR(100),
`municipality_name` VARCHAR(100),
`country_code` VARCHAR(5),
`city_id` VARCHAR(10),
`airport_latitude` FLOAT,
`airport_longitude` FLOAT,
PRIMARY KEY (`icao`)
);





ALTER TABLE `gans`.`airports` 
CHANGE COLUMN `icao` `icao` CHAR(4) NOT NULL,
CHANGE COLUMN `iata` `iata` CHAR(3) NULL,
CHANGE COLUMN `airport_name` `airport_name` VARCHAR(100) NULL,
CHANGE COLUMN `municipality_name` `municipality_name` VARCHAR(100) NULL,
CHANGE COLUMN `country_code` `country_code` VARCHAR(5) NULL,
CHANGE COLUMN `city_id` `city_id` VARCHAR(10) NULL,
CHANGE COLUMN `airport_latitude` `airport_latitude` FLOAT NULL,
CHANGE COLUMN `airport_longitude` `airport_longitude` FLOAT NULL,
# Setting foreign key:
#CREATE TABLE IF NOT EXISTS airports
#ALTER TABLE `gans`.`airports` 
ADD INDEX `airports_city_id_idx` (`city_id` ASC) VISIBLE,
#ALTER TABLE `gans`.`airports` 
ADD CONSTRAINT `airports_city_id`
FOREIGN KEY (`city_id`)
REFERENCES `gans`.`cities` (`city_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
  
DESCRIBE airports;
  
  
  
# Setting up flights table
# Before altering datatypes and setting key, flights has duplicate flight_number values, therefore 
# a new ID column with unique values is necessary for the primary key


# Alter table's datatypes of the columns and set primary key:
CREATE TABLE IF NOT EXISTS flights(
`arrival_icao` CHAR(4),
`flight_number` VARCHAR(10),
`status` VARCHAR(100),
`departure_airport` VARCHAR(100),
`scheduled_time` DATETIME,
`terminal` VARCHAR(10),
`aircraft_model` VARCHAR(100),
`airline` VARCHAR(100),
`departure_icao` CHAR(4),
`departure_iata` CHAR(3)
);

ALTER TABLE flights 
ADD flight_id INT;

ALTER TABLE `gans`.`flights` 
CHANGE COLUMN `arrival_icao` `arrival_icao` CHAR(4) NULL,
CHANGE COLUMN `flight_number` `flight_number` VARCHAR(10) NULL,
CHANGE COLUMN `status` `status` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `departure_airport` `departure_airport` VARCHAR(100) NULL,
CHANGE COLUMN `scheduled_time` `scheduled_time` DATETIME NULL,
CHANGE COLUMN `terminal` `terminal` VARCHAR(10) NULL,
CHANGE COLUMN `aircraft_model` `aircraft_model` VARCHAR(100) NULL,
CHANGE COLUMN `airline` `airline` VARCHAR(100) NULL,
CHANGE COLUMN `departure_icao` `departure_icao` CHAR(4) NULL,
CHANGE COLUMN `departure_iata` `departure_iata` CHAR(3) NULL,
CHANGE COLUMN `flight_id` `flight_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
# Setting foreign key:
#CREATE TABLE IF NOT EXISTS flights
#ALTER TABLE `gans`.`flights` 
ADD INDEX `flights_icao_idx` (`arrival_icao` ASC) VISIBLE,
#ALTER TABLE `gans`.`flights` 
ADD CONSTRAINT `arrivals_icao`
FOREIGN KEY (`arrival_icao`)
REFERENCES `gans`.`airports` (`icao`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
  
DESCRIBE flights;
