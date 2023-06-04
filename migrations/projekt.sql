-- Schema "airport"
CREATE DATABASE airport;

CREATE SCHEMA airport;

CREATE TABLE airport.Runway (
id SERIAL PRIMARY KEY,
runway_number INT NOT NULL,
length NUMERIC(8,2) NOT NULL,
width NUMERIC(8,2) NOT NULL,
surface_type VARCHAR(50) NOT NULL,
maximum_load NUMERIC(10,2) NOT NULL
);

-- Table "airport.Terminal"
CREATE TABLE airport.Terminal (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
location VARCHAR(100) NOT NULL,
gate_count INT NOT NULL
);


--  Table "airport.Contact"
CREATE TABLE airport.contact(
    id SERIAL PRIMARY KEY,
    email text,
    phone_number text
);

-- Table "airport.Airlines"
CREATE TABLE airport.Airline (
id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
country_of_origin VARCHAR(50) NOT NULL,
fleet_size INT NOT NULL,
headquarters_address VARCHAR(100) NOT NULL,
contact INT REFERENCES airport.contact(id)
);

-- Table "airport.Flights"
CREATE TABLE airport.Flight (
id SERIAL PRIMARY KEY,
flight_number VARCHAR(10) NOT NULL,
airline_id INT REFERENCES airport.Airline(id),
terminal_id INT REFERENCES airport.Terminal(id),
departure_date DATE NOT NULL,
departure_time TIME NOT NULL,
arrival_date DATE NOT NULL,
arrival_time TIME NOT NULL,
flight_status VARCHAR(50) NOT NULL,
aircraft_type VARCHAR(50) NOT NULL,
seats_amount INT NOT NULL,
desrination VARCHAR(100) NOT NULL
);

-- Table "airport.Person"
CREATE TABLE airport.Person (
id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
contact VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL
);

-- Table "airport.Passengers"
CREATE TABLE airport.Passenger (
id SERIAL PRIMARY KEY,
person_id INT REFERENCES airport.Person(id),
nationality VARCHAR(50) NOT NULL,
passport_number VARCHAR(20) NOT NULL
);

-- Table "airport.Airport_Staff"
CREATE TABLE airport.Airport_Staff (
id SERIAL PRIMARY KEY,
person_id INT REFERENCES airport.Person(id),
position VARCHAR(50) NOT NULL,
identification_number VARCHAR(20) NOT NULL
);

-- Table "airport.Baggage_Carriers"
CREATE TABLE airport.Baggage_Carrier (
id SERIAL PRIMARY KEY,
company_name VARCHAR(100) NOT NULL,
contact_id INT REFERENCES airport.Contact(id)
);

-- Table "airport.Warehouse"
CREATE TABLE airport.Warehouse (
id SERIAL PRIMARY KEY,
location VARCHAR(100) NOT NULL,
capacity NUMERIC(8,2) NOT NULL,
stored_goods_type VARCHAR(100) NOT NULL,
availability BOOLEAN NOT NULL
);


-- Table "airport.Gate"
CREATE TABLE airport.Gate (
id SERIAL PRIMARY KEY,
gate_number INT NOT NULL,
terminal_id INT REFERENCES airport.Terminal(id),
status VARCHAR(50) NOT NULL
);

-- Table "airport.Flight_Runway"
CREATE TABLE airport.Flight_Runway (
id SERIAL PRIMARY KEY,
flight_id INT REFERENCES airport.Flight(id),
runway_id INT REFERENCES airport.Runway(id)
);

-- Table "airport.Baggage"
CREATE TABLE airport.Baggage (
id SERIAL PRIMARY KEY,
baggage_number VARCHAR(20) NOT NULL,
flight_id INT REFERENCES airport.Flight(id),
baggage_carrier_id INT REFERENCES airport.Baggage_Carrier(id),
weight NUMERIC(8,2) NOT NULL,
status VARCHAR(50) NOT NULL
);

-- Table "airport.Flight_History"
CREATE TABLE airport.Flight_History (
id SERIAL PRIMARY KEY,
flight_id INT REFERENCES airport.Flight(id),
date_time TIMESTAMP NOT NULL,
description TEXT NOT NULL
);

-- Table "airport.Incident_Report"
CREATE TABLE airport.Incident_Report (
id SERIAL PRIMARY KEY,
flight_id INT REFERENCES airport.Flight(id),
passenger_id INT REFERENCES airport.Passenger(id),
description TEXT NOT NULL,
date_time TIMESTAMP NOT NULL
);

-- Table "airport.Flight_Service"
CREATE TABLE airport.Flight_Service (
id SERIAL PRIMARY KEY,
flight_id INT REFERENCES airport.Flight(id),
airport_staff_id INT REFERENCES airport.Airport_Staff(id),
date_time TIMESTAMP NOT NULL,
description TEXT NOT NULL
);