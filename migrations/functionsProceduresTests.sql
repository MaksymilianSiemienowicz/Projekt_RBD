SELECT * FROM airport.Flight_Details;


SELECT * FROM airport.Passenger_Details;


CALL airport.UpdateFlightStatus();


UPDATE airport.Flight
SET flight_status = 'Cancelled'
WHERE id = 1;


SELECT * FROM airport.Flight_History;
