create database if not exists travel_go_database;
use travel_go_database;

create table if not exists PASSENGER(
Passenger_name varchar(30) NULL DEFAULT NULL,
Category varchar(20) NULL DEFAULT NULL,
Gender varchar(10) NULL DEFAULT NULL,
Boarding_City varchar(30) NULL DEFAULT NULL ,
Destination_City varchar(30) NULL DEFAULT NULL,
Distance int NOT NULL,
Bus_Type varchar(50) NULL DEFAULT NULL
);

create table if not exists PRICE(
Bus_Type varchar(20) NULL DEFAULT NULL,
Distance int NOT NULL,
Price int NOT NULL
);

select * from passenger;
select * from price;

insert into passenger values("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper");
insert into passenger values("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
insert into passenger values("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
insert into passenger values("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
insert into passenger values("Udit", "Non-AC", "M", "Trivandrum", "panaji", 1000, "Sleeper");
insert into passenger values("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
insert into passenger values("Hemanth", "Non-AC", "M", "Panaji", "Mumbai", 700, "Sleeper");
insert into passenger values("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
insert into passenger values("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");

insert into price values("Sleeper", 350, 770);
insert into price values("Sleeper", 500, 1100);
insert into price values("Sleeper", 600, 1320);
insert into price values("Sleeper", 700, 1540);
insert into price values("Sleeper", 1000, 2200);
insert into price values("Sleeper", 1200, 2640);
insert into price values("Sleeper", 350, 434);
insert into price values("Sitting", 500, 620);
insert into price values("Sitting", 600, 744);
insert into price values("Sitting", 700, 868);
insert into price values("Sitting", 1000, 1240);
insert into price values("Sitting", 1200, 1488);
insert into price values("Sitting", 1500, 1860);

/*3) How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
SELECT 
    gender, COUNT(gender) AS NoofPassengers
FROM
    passenger
WHERE
    distance >= 600
GROUP BY gender;

/*4) Find the minimum ticket price for Sleeper Bus.*/

SELECT 
    Bus_Type, MIN(price)
FROM
    PRICE
WHERE
    BUS_TYPE = 'SLEEPER';
    
/*5) Select passenger names whose names start with character 'S'*/

SELECT 
    Passenger_name
FROM
    PASSENGER
WHERE
    Passenger_name LIKE 's%';
    
/*6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/

SELECT 
    pa.passenger_name,
    pa.Boarding_City,
    pa.Destination_City,
    pa.Bus_Type,
    p.Price
FROM
    passenger pa
        JOIN
    price p ON pa.distance = p.distance
        AND pa.bus_type = p.bus_type;
        
/*7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s*/

SELECT 
    pa.passenger_name, p.price
FROM
    passenger pa
        JOIN
    price p ON pa.distance = p.distance
        AND pa.bus_type = p.bus_type
WHERE
    pa.bus_type = 'Sitting'
        AND pa.distance = 1000;      
        
/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/

SELECT 
    p.price, p.bus_type
FROM
    price p
WHERE
    p.distance = (SELECT 
            distance
        FROM
            passenger
        WHERE
            passenger_name = 'pallavi');
            
/*9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/

SELECT DISTINCT
    distance as Disatnce_List
FROM
    passenger
ORDER BY distance DESC;

/*10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

SELECT 
    passenger_name,
    distance,
    (distance / (SELECT 
            SUM(distance)
        FROM
            passenger)) * 100 AS percentage
FROM
    passenger;
    
 /*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/


/*CREATE PROCEDURE `price_categorization` ()
BEGIN
  SELECT distance, price,
CASE
  when price > 1000 then 'Expensive'
  when price > 500 then 'Average cost'
  else
  'Cheap'
  END AS VERDICT FROM PRICE;
END */

call price_categorization();
