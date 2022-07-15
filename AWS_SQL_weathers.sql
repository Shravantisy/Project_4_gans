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


