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
contact_id INT REFERENCES airport.contact(id)
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
destination VARCHAR(100) NOT NULL
);

-- Table "airport.Person"
CREATE TABLE airport.Person (
id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
contact_id INT NOT NULL REFERENCES airport.contact(id),
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

-- Constraints
ALTER TABLE airport.Airline
ADD CONSTRAINT fk_airline_contact
FOREIGN KEY (contact_id) REFERENCES airport.Contact(id);

ALTER TABLE airport.Flight
ADD CONSTRAINT fk_flight_airline
FOREIGN KEY (airline_id) REFERENCES airport.Airline(id);

ALTER TABLE airport.Flight
ADD CONSTRAINT fk_flight_terminal
FOREIGN KEY (terminal_id) REFERENCES airport.Terminal(id);

ALTER TABLE airport.Person
ADD CONSTRAINT fk_person_contact
FOREIGN KEY (contact_id) REFERENCES airport.Contact(id);

ALTER TABLE airport.Passenger
ADD CONSTRAINT fk_passenger_person
FOREIGN KEY (person_id) REFERENCES airport.Person(id);

ALTER TABLE airport.Airport_Staff
ADD CONSTRAINT fk_airport_staff_person
FOREIGN KEY (person_id) REFERENCES airport.Person(id);

ALTER TABLE airport.Baggage_Carrier
ADD CONSTRAINT fk_baggage_carrier_contact
FOREIGN KEY (contact_id) REFERENCES airport.Contact(id);

ALTER TABLE airport.Gate
ADD CONSTRAINT fk_gate_terminal
FOREIGN KEY (terminal_id) REFERENCES airport.Terminal(id);

ALTER TABLE airport.Flight_Runway
ADD CONSTRAINT fk_flight_runway_flight
FOREIGN KEY (flight_id) REFERENCES airport.Flight(id);

ALTER TABLE airport.Flight_Runway
ADD CONSTRAINT fk_flight_runway_runway
FOREIGN KEY (runway_id) REFERENCES airport.Runway(id);

ALTER TABLE airport.Baggage
ADD CONSTRAINT fk_baggage_flight
FOREIGN KEY (flight_id) REFERENCES airport.Flight(id);

ALTER TABLE airport.Baggage
ADD CONSTRAINT fk_baggage_carrier
FOREIGN KEY (baggage_carrier_id) REFERENCES airport.Baggage_Carrier(id);

ALTER TABLE airport.Flight_History
ADD CONSTRAINT fk_flight_history_flight
FOREIGN KEY (flight_id) REFERENCES airport.Flight(id);

ALTER TABLE airport.Incident_Report
ADD CONSTRAINT fk_incident_report_flight
FOREIGN KEY (flight_id) REFERENCES airport.Flight(id);

ALTER TABLE airport.Incident_Report
ADD CONSTRAINT fk_incident_report_passenger
FOREIGN KEY (passenger_id) REFERENCES airport.Passenger(id);

ALTER TABLE airport.Flight_Service
ADD CONSTRAINT fk_flight_service_flight
FOREIGN KEY (flight_id) REFERENCES airport.Flight(id);

ALTER TABLE airport.Flight_Service
ADD CONSTRAINT fk_flight_service_airport_staff
FOREIGN KEY (airport_staff_id) REFERENCES airport.Airport_Staff(id);


INSERT INTO airport.Runway (runway_number, length, width, surface_type, maximum_load)
VALUES
(1, 3500.00, 45.00, 'Concrete', 100000.00),
(2, 4000.00, 50.00, 'Asphalt', 120000.00),
(3, 3000.00, 40.00, 'Concrete', 90000.00),
(4, 3800.00, 50.00, 'Asphalt', 110000.00),
(5, 3200.00, 45.00, 'Concrete', 100000.00),
(6, 4000.00, 55.00, 'Asphalt', 120000.00),
(7, 3800.00, 50.00, 'Concrete', 110000.00),
(8, 3000.00, 40.00, 'Grass', 90000.00),
(9, 4200.00, 52.00, 'Asphalt', 125000.00),
(10, 3600.00, 48.00, 'Concrete', 105000.00),
(11, 3400.00, 45.00, 'Asphalt', 100000.00),
(12, 3800.00, 50.00, 'Concrete', 110000.00),
(13, 3100.00, 42.00, 'Grass', 95000.00),
(14, 4100.00, 55.00, 'Asphalt', 120000.00),
(15, 3900.00, 50.00, 'Concrete', 115000.00),
(16, 3300.00, 43.00, 'Asphalt', 98000.00),
(17, 3700.00, 48.00, 'Concrete', 110000.00),
(18, 3000.00, 40.00, 'Grass', 90000.00),
(19, 4200.00, 52.00, 'Asphalt', 125000.00),
(20, 3800.00, 50.00, 'Concrete', 110000.00),
(21, 3200.00, 45.00, 'Asphalt', 100000.00),
(22, 4000.00, 55.00, 'Concrete', 120000.00),
(23, 3800.00, 50.00, 'Asphalt', 110000.00),
(24, 3000.00, 40.00, 'Grass', 90000.00),
(25, 4200.00, 52.00, 'Asphalt', 125000.00),
(26, 3600.00, 48.00, 'Concrete', 105000.00),
(27, 3400.00, 45.00, 'Asphalt', 100000.00),
(28, 3800.00, 50.00, 'Concrete', 110000.00),
(29, 3100.00, 42.00, 'Grass', 95000.00),
(30, 4100.00, 55.00, 'Asphalt', 120000.00);
INSERT INTO airport.Terminal (name, location, gate_count)
VALUES
('Terminal 1', 'Main Building', 20),
('Terminal 2', 'East Wing', 15),
('Terminal 3', 'West Wing', 18),
('Terminal 4', 'North Wing', 12),
('Terminal 5', 'South Wing', 10),
('Terminal A', 'Concourse A', 8),
('Terminal B', 'Concourse B', 6),
('Terminal C', 'Concourse C', 10),
('Terminal D', 'Concourse D', 14),
('Terminal E', 'Concourse E', 16),
('Terminal F', 'Concourse F', 9),
('Terminal G', 'Concourse G', 11),
('Terminal H', 'Concourse H', 7),
('Terminal I', 'Concourse I', 13),
('Terminal J', 'Concourse J', 10),
('Terminal K', 'Concourse K', 12),
('Terminal L', 'Concourse L', 8),
('Terminal M', 'Concourse M', 15),
('Terminal N', 'Concourse N', 9),
('Terminal O', 'Concourse O', 11),
('Terminal P', 'Concourse P', 13),
('Terminal Q', 'Concourse Q', 7),
('Terminal R', 'Concourse R', 10),
('Terminal S', 'Concourse S', 12),
('Terminal T', 'Concourse T', 9),
('Terminal U', 'Concourse U', 11),
('Terminal V', 'Concourse V', 8),
('Terminal W', 'Concourse W', 10),
('Terminal X', 'Concourse X', 13),
('Terminal Y', 'Concourse Y', 7);
INSERT INTO airport.contact (email, phone_number)
VALUES
('john.doe@example.com', '+1 123-456-7890'),
('jane.smith@example.com', '+1 987-654-3210'),
('michael.brown@example.com', '+1 555-123-4567'),
('sarah.johnson@example.com', '+1 777-888-9999'),
('robert.wilson@example.com', '+1 444-555-6666'),
('emily.thomas@example.com', '+1 111-222-3333'),
('william.miller@example.com', '+1 666-777-8888'),
('olivia.davis@example.com', '+1 999-888-7777'),
('james.jones@example.com', '+1 333-444-5555'),
('ava.anderson@example.com', '+1 222-333-4444'),
('benjamin.white@example.com', '+1 555-444-3333'),
('mia.taylor@example.com', '+1 777-666-5555'),
('logan.anderson@example.com', '+1 999-222-1111'),
('lucy.martin@example.com', '+1 888-999-0000'),
('ethan.moore@example.com', '+1 444-555-6666'),
('amelia.jackson@example.com', '+1 111-222-3333'),
('henry.harris@example.com', '+1 666-777-8888'),
('chloe.wilson@example.com', '+1 222-333-4444'),
('alexander.clark@example.com', '+1 555-444-3333'),
('lily.hall@example.com', '+1 777-666-5555'),
('daniel.green@example.com', '+1 999-222-1111'),
('sophia.lewis@example.com', '+1 888-999-0000'),
('matthew.thompson@example.com', '+1 444-555-6666'),
('ava.walker@example.com', '+1 111-222-3333'),
('samuel.hill@example.com', '+1 666-777-8888'),
('mia.young@example.com', '+1 222-333-4444'),
('jacob.king@example.com', '+1 555-444-3333'),
('emily.lee@example.com', '+1 777-666-5555'),
('noah.turner@example.com', '+1 999-222-1111'),
('grace.carter@example.com', '+1 888-999-0000');
INSERT INTO airport.Airline (name, country_of_origin, fleet_size, headquarters_address, contact_id)
VALUES
('United Airlines', 'United States', 800, 'Chicago, IL', 1),
('Delta Air Lines', 'United States', 900, 'Atlanta, GA', 2),
('American Airlines', 'United States', 700, 'Fort Worth, TX', 3),
('Lufthansa', 'Germany', 350, 'Cologne, Germany', 4),
('British Airways', 'United Kingdom', 400, 'London, UK', 5),
('Air France', 'France', 450, 'Paris, France', 6),
('Emirates', 'United Arab Emirates', 300, 'Dubai, UAE', 7),
('Cathay Pacific', 'Hong Kong', 250, 'Hong Kong', 8),
('Qatar Airways', 'Qatar', 200, 'Doha, Qatar', 9),
('Singapore Airlines', 'Singapore', 350, 'Singapore', 10),
('ANA All Nippon Airways', 'Japan', 300, 'Tokyo, Japan', 11),
('KLM Royal Dutch Airlines', 'Netherlands', 250, 'Amsterdam, Netherlands', 12),
('Qantas', 'Australia', 200, 'Sydney, Australia', 13),
('Turkish Airlines', 'Turkey', 400, 'Istanbul, Turkey', 14),
('Air Canada', 'Canada', 300, 'Montreal, Canada', 15),
('Swiss International Air Lines', 'Switzerland', 200, 'Zurich, Switzerland', 16),
('Etihad Airways', 'United Arab Emirates', 250, 'Abu Dhabi, UAE', 17),
('South African Airways', 'South Africa', 150, 'Johannesburg, South Africa', 18),
('Scandinavian Airlines', 'Sweden', 200, 'Stockholm, Sweden', 19),
('Air New Zealand', 'New Zealand', 150, 'Auckland, New Zealand', 20),
('Virgin Atlantic', 'United Kingdom', 250, 'Crawley, UK', 21),
('Aeroflot', 'Russia', 350, 'Moscow, Russia', 22),
('Finnair', 'Finland', 200, 'Helsinki, Finland', 23),
('AirAsia', 'Malaysia', 400, 'Kuala Lumpur, Malaysia', 24),
('Alitalia', 'Italy', 250, 'Rome, Italy', 25),
('Jet Airways', 'India', 300, 'Mumbai, India', 26),
('EgyptAir', 'Egypt', 200, 'Cairo, Egypt', 27),
('Norwegian Air Shuttle', 'Norway', 150, 'Fornebu, Norway', 28),
('Ryanair', 'Ireland', 350, 'Dublin, Ireland', 29),
('SAS Scandinavian Airlines', 'Denmark', 250, 'Copenhagen, Denmark', 30);

INSERT INTO airport.Flight (flight_number, airline_id, terminal_id, departure_date, departure_time, arrival_date, arrival_time, flight_status, aircraft_type, seats_amount, destination)
VALUES
('UA123', 1, 1, '2023-06-07', '08:00:00', '2023-06-07', '10:00:00', 'On Time', 'Boeing 737', 150, 'New York'),
('DL456', 2, 1, '2023-06-07', '10:30:00', '2023-06-07', '13:00:00', 'Delayed', 'Airbus A320', 180, 'Los Angeles'),
('AA789', 3, 2, '2023-06-07', '12:00:00', '2023-06-07', '14:30:00', 'On Time', 'Boeing 787', 200, 'London'),
('LH234', 4, 2, '2023-06-07', '14:30:00', '2023-06-07', '17:00:00', 'On Time', 'Airbus A380', 300, 'Frankfurt'),
('BA567', 5, 3, '2023-06-07', '16:00:00', '2023-06-07', '19:00:00', 'Delayed', 'Boeing 777', 250, 'Paris'),
('AF901', 6, 3, '2023-06-07', '18:30:00', '2023-06-07', '21:00:00', 'On Time', 'Airbus A350', 220, 'Amsterdam'),
('EK345', 7, 4, '2023-06-07', '20:00:00', '2023-06-07', '23:00:00', 'On Time', 'Boeing 767', 180, 'Dubai'),
('CX678', 8, 4, '2023-06-07', '22:30:00', '2023-06-08', '01:30:00', 'Delayed', 'Airbus A330', 200, 'Hong Kong'),
('QR123', 9, 5, '2023-06-08', '08:00:00', '2023-06-08', '11:00:00', 'On Time', 'Boeing 737', 150, 'Doha'),
('SQ456', 10, 5, '2023-06-08', '10:30:00', '2023-06-08', '13:00:00', 'On Time', 'Airbus A320', 180, 'Singapore'),
('NH789', 11, 6, '2023-06-08', '12:00:00', '2023-06-08', '14:30:00', 'Delayed', 'Boeing 787', 200, 'Tokyo'),
('KL234', 12, 6, '2023-06-08', '14:30:00', '2023-06-08', '17:00:00', 'On Time', 'Airbus A380', 300, 'Amsterdam'),
('QF567', 13, 7, '2023-06-08', '16:00:00', '2023-06-08', '19:00:00', 'On Time', 'Boeing 777', 250, 'Sydney'),
('TK901', 14, 7, '2023-06-08', '18:30:00', '2023-06-08', '21:00:00', 'Delayed', 'Airbus A350', 220, 'Istanbul'),
('AC345', 15, 8, '2023-06-08', '20:00:00', '2023-06-08', '23:00:00', 'On Time', 'Boeing 767', 180, 'Toronto'),
('LX678', 16, 8, '2023-06-08', '22:30:00', '2023-06-09', '01:30:00', 'Delayed', 'Airbus A330', 200, 'Zurich'),
('EY123', 17, 9, '2023-06-09', '08:00:00', '2023-06-09', '11:00:00', 'On Time', 'Boeing 737', 150, 'Abu Dhabi'),
('SA456', 18, 9, '2023-06-09', '10:30:00', '2023-06-09', '13:00:00', 'On Time', 'Airbus A320', 180, 'Johannesburg'),
('SK789', 19, 10, '2023-06-09', '12:00:00', '2023-06-09', '14:30:00', 'Delayed', 'Boeing 787', 200, 'Stockholm'),
('NZ234', 20, 10, '2023-06-09', '14:30:00', '2023-06-09', '17:00:00', 'On Time', 'Airbus A380', 300, 'Auckland'),
('VS567', 21, 11, '2023-06-09', '16:00:00', '2023-06-09', '19:00:00', 'On Time', 'Boeing 777', 250, 'London'),
('SU901', 22, 11, '2023-06-09', '18:30:00', '2023-06-09', '21:00:00', 'Delayed', 'Airbus A350', 220, 'Moscow'),
('AY123', 23, 12, '2023-06-09', '20:00:00', '2023-06-09', '23:00:00', 'On Time', 'Boeing 767', 180, 'Helsinki'),
('AK345', 24, 12, '2023-06-09', '22:30:00', '2023-06-10', '01:30:00', 'Delayed', 'Airbus A330', 200, 'Kuala Lumpur'),
('AZ789', 25, 13, '2023-06-10', '08:00:00', '2023-06-10', '11:00:00', 'On Time', 'Boeing 737', 150, 'Rome'),
('9W456', 26, 13, '2023-06-10', '10:30:00', '2023-06-10', '13:00:00', 'On Time', 'Airbus A320', 180, 'Mumbai'),
('AI789', 27, 14, '2023-06-10', '12:00:00', '2023-06-10', '14:30:00', 'Delayed', 'Boeing 787', 200, 'Delhi'),
('CX234', 28, 14, '2023-06-10', '14:30:00', '2023-06-10', '17:00:00', 'On Time', 'Airbus A380', 300, 'Hong Kong'),
('TG567', 29, 15, '2023-06-10', '16:00:00', '2023-06-10', '19:00:00', 'On Time', 'Boeing 777', 250, 'Bangkok'),
('MH901', 30, 15, '2023-06-10', '18:30:00', '2023-06-10', '21:00:00', 'Delayed', 'Airbus A350', 220, 'Kuala Lumpur');



INSERT INTO airport.Person (first_name, last_name, contact_id, date_of_birth)
VALUES
('John', 'Doe', 1, '1985-07-15'),
('Jane', 'Smith', 2, '1990-03-22'),
('Michael', 'Johnson', 3, '1988-09-10'),
('Emily', 'Brown', 4, '1995-12-05'),
('David', 'Miller', 5, '1992-06-18'),
('Emma', 'Jones', 6, '1987-04-25'),
('Daniel', 'Wilson', 7, '1993-11-12'),
('Olivia', 'Taylor', 8, '1991-08-30'),
('Andrew', 'Anderson', 9, '1986-02-14'),
('Sophia', 'Thomas', 10, '1989-10-27'),
('James', 'Martinez', 11, '1994-05-08'),
('Ava', 'Robinson', 12, '1984-01-01'),
('William', 'Clark', 13, '1997-07-20'),
('Isabella', 'Wright', 14, '1996-09-17'),
('Joseph', 'Walker', 15, '1998-04-03'),
('Mia', 'Harris', 16, '1983-11-29'),
('Benjamin', 'Lewis', 17, '1999-03-11'),
('Charlotte', 'Green', 18, '1991-12-19'),
('Henry', 'Baker', 19, '1987-06-06'),
('Amelia', 'Gonzalez', 20, '1992-08-09'),
('Samuel', 'Nelson', 21, '1985-05-26'),
('Elizabeth', 'Carter', 22, '1993-02-02'),
('Alexander', 'Hill', 23, '1996-10-14'),
('Ella', 'Mitchell', 24, '1989-03-28'),
('Gabriel', 'Turner', 25, '1997-09-23'),
('Sofia', 'Parker', 26, '1995-01-07'),
('Matthew', 'Collins', 27, '1994-12-12'),
('Lily', 'Adams', 28, '1990-07-31'),
('Christopher', 'Campbell', 29, '1986-04-16'),
('Konrad', 'Butkiewicz' , 30, '2002-03-09');
INSERT INTO airport.Passenger (person_id, nationality, passport_number)
VALUES
(1, 'USA', 'A12345678'),
(2, 'UK', 'B98765432'),
(3, 'USA', 'C87654321'),
(4, 'Canada', 'D56789123'),
(5, 'Australia', 'E45678912'),
(6, 'USA', 'F34567891'),
(7, 'UK', 'G23456789'),
(8, 'Canada', 'H12345678'),
(9, 'USA', 'I98765432'),
(10, 'Australia', 'J87654321'),
(11, 'USA', 'K76543210'),
(12, 'UK', 'L65432109'),
(13, 'Canada', 'M54321098'),
(14, 'USA', 'N43210987'),
(15, 'Australia', 'O32109876'),
(16, 'USA', 'P21098765'),
(17, 'UK', 'Q10987654'),
(18, 'Canada', 'R09876543'),
(19, 'USA', 'S98765432'),
(20, 'Australia', 'T87654321'),
(21, 'USA', 'U76543210'),
(22, 'UK', 'V65432109'),
(23, 'Canada', 'W54321098'),
(24, 'USA', 'X43210987'),
(25, 'Australia', 'Y32109876'),
(26, 'USA', 'Z21098765'),
(27, 'UK', 'AA10987654'),
(28, 'Canada', 'BB09876543'),
(29, 'USA', 'CC98765432'),
(30, 'Australia', 'DD87654321');
INSERT INTO airport.Airport_Staff (person_id, position, identification_number)
VALUES
(1, 'Security Officer', 'S12345678'),
(2, 'Customer Service Representative', 'C98765432'),
(3, 'Baggage Handler', 'B87654321'),
(4, 'Air Traffic Controller', 'A56789123'),
(5, 'Ground Crew', 'G45678912'),
(6, 'Maintenance Technician', 'M34567891'),
(7, 'Flight Attendant', 'F23456789'),
(8, 'Ramp Agent', 'R12345678'),
(9, 'Gate Agent', 'G98765432'),
(10, 'Operations Manager', 'O87654321'),
(11, 'Security Officer', 'S76543210'),
(12, 'Customer Service Representative', 'C65432109'),
(13, 'Baggage Handler', 'B54321098'),
(14, 'Air Traffic Controller', 'A43210987'),
(15, 'Ground Crew', 'G32109876'),
(16, 'Maintenance Technician', 'M21098765'),
(17, 'Flight Attendant', 'F10987654'),
(18, 'Ramp Agent', 'R09876543'),
(19, 'Gate Agent', 'G98765432'),
(20, 'Operations Manager', 'O87654321'),
(21, 'Security Officer', 'S76543210'),
(22, 'Customer Service Representative', 'C65432109'),
(23, 'Baggage Handler', 'B54321098'),
(24, 'Air Traffic Controller', 'A43210987'),
(25, 'Ground Crew', 'G32109876'),
(26, 'Maintenance Technician', 'M21098765'),
(27, 'Flight Attendant', 'F10987654'),
(28, 'Ramp Agent', 'R09876543'),
(29, 'Gate Agent', 'G98765432'),
(30, 'Operations Manager', 'O87654321');

INSERT INTO airport.Baggage_Carrier (company_name, contact_id)
VALUES
('ABC Baggage Services', 1),
('XYZ Baggage Solutions', 2),
('JetSet Baggage Handlers', 3),
('Air Cargo Logistics', 4),
('Global Baggage Express', 5),
('Speedy Baggage Delivery', 6),
('Swift Airways Cargo', 7),
('CargoMaster Baggage Services', 8),
('Air Express Baggage', 9),
('QuickShip Baggage Handlers', 10),
('FastTrack Baggage Solutions', 11),
('RapidCargo Baggage Delivery', 12),
('Aviation Baggage Services', 13),
('FlyHigh Baggage Handlers', 14),
('SkyLink Baggage Solutions', 15),
('AirSpeed Baggage Delivery', 16),
('CargoJet Baggage Handlers', 17),
('JetCargo Baggage Solutions', 18),
('ExpressAir Baggage Delivery', 19),
('SwiftWings Baggage Services', 20),
('CargoXpress Baggage Handlers', 21),
('AirMovers Baggage Solutions', 22),
('FastTrack Express Delivery', 23),
('RapidCargo Handlers', 24),
('Aviation Logistics', 25),
('FlyEasy Baggage Solutions', 26),
('SkyCargo Baggage Delivery', 27),
('CargoStar Baggage Handlers', 28),
('JetLogistics Baggage Solutions', 29),
('ExpressFly Baggage Delivery', 30);
INSERT INTO airport.Warehouse (location, capacity, stored_goods_type, availability)
VALUES
('Terminal 1, Storage Area A', 10000.00, 'Electronics', true),
('Terminal 2, Storage Area B', 8000.00, 'Clothing', true),
('Cargo Terminal, Storage Area C', 15000.00, 'Perishables', true),
('Terminal 3, Storage Area D', 12000.00, 'Automotive Parts', true),
('Cargo Terminal, Storage Area E', 20000.00, 'Medical Supplies', true),
('Terminal 1, Storage Area F', 9000.00, 'Books', true),
('Terminal 2, Storage Area G', 11000.00, 'Furniture', true),
('Cargo Terminal, Storage Area H', 18000.00, 'Toys', true),
('Terminal 3, Storage Area I', 13000.00, 'Sports Equipment', true),
('Cargo Terminal, Storage Area J', 22000.00, 'Cosmetics', true),
('Terminal 1, Storage Area K', 9500.00, 'Food Products', true),
('Terminal 2, Storage Area L', 10500.00, 'Artwork', true),
('Cargo Terminal, Storage Area M', 18500.00, 'Home Appliances', true),
('Terminal 3, Storage Area N', 12500.00, 'Musical Instruments', true),
('Cargo Terminal, Storage Area O', 24000.00, 'Fashion Accessories', true),
('Terminal 1, Storage Area P', 9800.00, 'Chemicals', true),
('Terminal 2, Storage Area Q', 10000.00, 'Baby Products', true),
('Cargo Terminal, Storage Area R', 19500.00, 'Industrial Equipment', true),
('Terminal 3, Storage Area S', 14000.00, 'Pet Supplies', true),
('Cargo Terminal, Storage Area T', 26000.00, 'Electrical Appliances', true),
('Terminal 1, Storage Area U', 9200.00, 'Office Supplies', true),
('Terminal 2, Storage Area V', 11500.00, 'Jewelry', true),
('Cargo Terminal, Storage Area W', 17500.00, 'Garden Tools', true),
('Terminal 3, Storage Area X', 13500.00, 'Luggage', true),
('Cargo Terminal, Storage Area Y', 23000.00, 'Toiletries', true),
('Terminal 1, Storage Area Z', 9700.00, 'Household Goods', true),
('Terminal 2, Storage Area AA', 10200.00, 'Toys', true),
('Cargo Terminal, Storage Area BB', 19000.00, 'Sports Gear', true),
('Terminal 3, Storage Area CC', 15000.00, 'Fashion Clothing', true);
INSERT INTO airport.Gate (gate_number, terminal_id, status)
VALUES
(1, 1, 'Available'),
(2, 1, 'Available'),
(3, 1, 'Available'),
(4, 2, 'Available'),
(5, 2, 'Available'),
(6, 2, 'Available'),
(7, 3, 'Available'),
(8, 3, 'Available'),
(9, 3, 'Available'),
(10, 4, 'Available'),
(11, 4, 'Available'),
(12, 4, 'Available'),
(13, 5, 'Available'),
(14, 5, 'Available'),
(15, 5, 'Available'),
(16, 6, 'Available'),
(17, 6, 'Available'),
(18, 6, 'Available'),
(19, 7, 'Available'),
(20, 7, 'Available'),
(21, 7, 'Available'),
(22, 8, 'Available'),
(23, 8, 'Available'),
(24, 8, 'Available'),
(25, 9, 'Available'),
(26, 9, 'Available'),
(27, 9, 'Available'),
(28, 10, 'Available'),
(29, 10, 'Available'),
(30, 10, 'Available');

INSERT INTO airport.Flight_Runway (flight_id, runway_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30);
INSERT INTO airport.Baggage (baggage_number, flight_id, baggage_carrier_id, weight, status)
VALUES
('B001', 1, 1, 23.5, 'Checked'),
('B002', 1, 2, 18.2, 'Checked'),
('B003', 2, 3, 15.7, 'Checked'),
('B004', 2, 4, 20.1, 'Checked'),
('B005', 3, 5, 10.8, 'Checked'),
('B006', 3, 6, 17.6, 'Checked'),
('B007', 4, 7, 14.3, 'Checked'),
('B008', 4, 8, 22.9, 'Checked'),
('B009', 5, 9, 19.6, 'Checked'),
('B010', 5, 10, 13.2, 'Checked'),
('B011', 6, 11, 16.4, 'Checked'),
('B012', 6, 12, 21.8, 'Checked'),
('B013', 7, 13, 12.6, 'Checked'),
('B014', 7, 14, 24.3, 'Checked'),
('B015', 8, 15, 18.9, 'Checked'),
('B016', 8, 16, 11.5, 'Checked'),
('B017', 9, 17, 14.8, 'Checked'),
('B018', 9, 18, 23.7, 'Checked'),
('B019', 10, 19, 17.2, 'Checked'),
('B020', 10, 20, 10.4, 'Checked'),
('B021', 11, 21, 20.9, 'Checked'),
('B022', 11, 22, 16.1, 'Checked'),
('B023', 12, 23, 13.7, 'Checked'),
('B024', 12, 24, 22.5, 'Checked'),
('B025', 13, 25, 19.8, 'Checked'),
('B026', 13, 26, 12.3, 'Checked'),
('B027', 14, 27, 15.5, 'Checked'),
('B028', 14, 28, 24.1, 'Checked'),
('B029', 15, 29, 18.6, 'Checked'),
('B030', 15, 30, 11.2, 'Checked');
INSERT INTO airport.Flight_History (flight_id, date_time, description)
VALUES
  (1, '2023-06-01 08:30:00', 'Flight departed on time'),
  (1, '2023-06-01 10:45:00', 'Flight encountered turbulence'),
  (2, '2023-06-02 12:15:00', 'Flight delayed due to weather conditions'),
  (2, '2023-06-02 14:30:00', 'Flight arrived at the destination'),
  (3, '2023-06-03 09:20:00', 'Flight departed on time'),
  (3, '2023-06-03 12:35:00', 'Flight diverted to an alternate airport'),
  (4, '2023-06-04 11:10:00', 'Flight departed with a slight delay'),
  (4, '2023-06-04 13:45:00', 'Flight arrived at the destination'),
  (5, '2023-06-05 15:40:00', 'Flight departed on time'),
  (5, '2023-06-05 18:15:00', 'Flight encountered a mechanical issue'),
  (6, '2023-06-06 14:55:00', 'Flight departed on time'),
  (6, '2023-06-06 17:30:00', 'Flight arrived at the destination'),
  (7, '2023-06-07 13:25:00', 'Flight departed with a slight delay'),
  (7, '2023-06-07 16:10:00', 'Flight arrived at the destination'),
  (8, '2023-06-08 10:50:00', 'Flight departed on time'),
  (8, '2023-06-08 13:15:00', 'Flight arrived at the destination'),
  (9, '2023-06-09 16:30:00', 'Flight delayed due to air traffic'),
  (9, '2023-06-09 19:05:00', 'Flight arrived at the destination'),
  (10, '2023-06-10 11:20:00', 'Flight departed on time'),
  (10, '2023-06-10 14:05:00', 'Flight arrived at the destination'),
  (11, '2023-06-11 09:45:00', 'Flight departed with a slight delay'),
  (11, '2023-06-11 12:30:00', 'Flight arrived at the destination'),
  (12, '2023-06-12 14:30:00', 'Flight departed on time'),
  (12, '2023-06-12 17:15:00', 'Flight encountered a medical emergency'),
  (13, '2023-06-13 12:50:00', 'Flight departed on time'),
  (13, '2023-06-13 15:25:00', 'Flight arrived at the destination'),
  (14, '2023-06-14 08:15:00', 'Flight departed with a slight delay'),
  (14, '2023-06-14 10:40:00', 'Flight arrived at the destination'),
  (15, '2023-06-15 11:30:00', 'Flight departed on time'),
  (15, '2023-06-15 14:05:00', 'Flight encountered a technical issue');
  INSERT INTO airport.Incident_Report (flight_id, passenger_id, description, date_time)
  VALUES
  (1, 1, 'Passenger reported a lost baggage', '2023-06-01 10:30:00'),
  (1, 2, 'Passenger experienced a medical emergency', '2023-06-01 12:45:00'),
  (2, 3, 'Passenger complained about in-flight meal quality', '2023-06-02 13:20:00'),
  (2, 4, 'Passenger reported a damaged suitcase', '2023-06-02 15:55:00'),
  (3, 5, 'Passenger reported a missing connecting flight', '2023-06-03 11:10:00'),
  (3, 6, 'Passenger experienced severe turbulence during the flight', '2023-06-03 13:35:00'),
  (4, 7, 'Passenger reported a noisy seat neighbor', '2023-06-04 14:50:00'),
  (4, 8, 'Passenger found a lost item onboard', '2023-06-04 17:15:00'),
  (5, 9, 'Passenger reported an unruly behavior of another passenger', '2023-06-05 16:30:00'),
  (5, 10, 'Passenger complained about the temperature inside the cabin', '2023-06-05 18:55:00'),
  (6, 11, 'Passenger reported a malfunctioning entertainment system', '2023-06-06 15:10:00'),
  (6, 12, 'Passenger experienced a delay in receiving checked baggage', '2023-06-06 17:35:00'),
  (7, 13, 'Passenger reported a damaged seat recliner', '2023-06-07 14:50:00'),
  (7, 14, 'Passenger lost personal belongings during the flight', '2023-06-07 17:15:00'),
  (8, 15, 'Passenger reported a disturbance in the lavatory', '2023-06-08 11:30:00'),
  (8, 16, 'Passenger complained about a rude flight attendant', '2023-06-08 13:55:00'),
  (9, 17, 'Passenger reported a delay in receiving wheelchair assistance', '2023-06-09 16:10:00'),
  (9, 18, 'Passenger lost their boarding pass', '2023-06-09 18:35:00'),
  (10, 19, 'Passenger reported a malfunctioning seatbelt', '2023-06-10 12:50:00'),
  (10, 20, 'Passenger experienced motion sickness during the flight', '2023-06-10 15:15:00'),
  (11, 21, 'Passenger reported a broken overhead bin', '2023-06-11 10:30:00'),
  (11, 22, 'Passenger complained about a noisy baby on the flight', '2023-06-11 12:55:00'),
  (12, 23, 'Passenger reported a delay in receiving assistance for a disabled passenger', '2023-06-12 16:10:00'),
  (12, 24, 'Passenger lost their mobile phone during the flight', '2023-06-12 18:35:00'),
  (13, 25, 'Passenger reported a malfunctioning reading light', '2023-06-13 11:50:00'),
  (13, 26, 'Passenger complained about a bumpy landing', '2023-06-13 14:15:00'),
  (14, 27, 'Passenger reported a delay in receiving a stroller for an infant', '2023-06-14 15:30:00'),
  (14, 28, 'Passenger lost their wallet during the flight', '2023-06-14 17:55:00'),
  (15, 29, 'Passenger reported a broken tray table', '2023-06-15 12:10:00'),
  (15, 30, 'Passenger complained about a long wait at the baggage claim', '2023-06-15 14:35:00');


  INSERT INTO airport.Flight_Service (flight_id, airport_staff_id, date_time, description)
  VALUES
  (1, 1, '2023-06-01 10:30:00', 'Provided assistance with boarding process'),
  (1, 2, '2023-06-01 12:45:00', 'Conducted pre-flight safety checks'),
  (2, 3, '2023-06-02 13:20:00', 'Assisted passengers with baggage handling'),
  (2, 4, '2023-06-02 15:55:00', 'Performed aircraft cleaning and sanitation'),
  (3, 5, '2023-06-03 11:10:00', 'Handled flight documentation and paperwork'),
  (3, 6, '2023-06-03 13:35:00', 'Coordinated ground services for the flight'),
  (4, 7, '2023-06-04 14:50:00', 'Assisted passengers with special needs'),
  (4, 8, '2023-06-04 17:15:00', 'Provided customer service and addressed passenger inquiries'),
  (5, 9, '2023-06-05 16:30:00', 'Managed the boarding and disembarkation process'),
  (5, 10, '2023-06-05 18:55:00', 'Handled baggage loading and unloading operations'),
  (6, 11, '2023-06-06 15:10:00', 'Coordinated ground transportation services for passengers'),
  (6, 12, '2023-06-06 17:35:00', 'Assisted in aircraft refueling process'),
  (7, 13, '2023-06-07 14:50:00', 'Performed security checks on passengers and luggage'),
  (7, 14, '2023-06-07 17:15:00', 'Managed flight gate operations and announcements'),
  (8, 15, '2023-06-08 11:30:00', 'Provided in-flight food and beverage services'),
  (8, 16, '2023-06-08 13:55:00', 'Conducted safety demonstration for passengers'),
  (9, 17, '2023-06-09 16:10:00', 'Handled lost and found items from the flight'),
  (9, 18, '2023-06-09 18:35:00', 'Coordinated with ground crew for aircraft towing'),
  (10, 19, '2023-06-10 12:50:00', 'Assisted in the boarding of priority passengers'),
  (10, 20, '2023-06-10 15:15:00', 'Performed cabin cleaning and restocking'),
  (11, 21, '2023-06-11 10:30:00', 'Managed aircraft parking and marshalling'),
  (11, 22, '2023-06-11 12:55:00', 'Provided gate information and assistance to passengers'),
  (12, 23, '2023-06-12 16:10:00', 'Assisted in baggage claim and delivery process'),
  (12, 24, '2023-06-12 18:35:00', 'Coordinated aircraft de-icing operations'),
  (13, 25, '2023-06-13 11:50:00', 'Handled boarding pass scanning and verification'),
  (13, 26, '2023-06-13 14:15:00', 'Provided wheelchair assistance to passengers'),
  (14, 27, '2023-06-14 15:30:00', 'Managed flight manifest and passenger seating arrangements'),
  (14, 28, '2023-06-14 17:55:00', 'Assisted in handling oversized and special baggage'),
  (15, 29, '2023-06-15 12:10:00', 'Performed security screening for passengers and luggage'),
  (15, 30, '2023-06-15 14:35:00', 'Coordinated with air traffic control for flight departure');