SELECT * FROM airport.Flight_Details;


SELECT * FROM airport.Passenger_Details;


CALL airport.UpdateFlightStatus();


UPDATE airport.Flight
SET flight_status = 'Cancelled'
WHERE id = 1;


SELECT * FROM airport.Flight_History;

SELECT * FROM airport_LeftJoinView;
SELECT * FROM airport_RightJoinView;
SELECT * FROM airport_InnerJoinView;
SELECT * FROM airport.FullOuterJoinView;
SELECT * FROM airport_UnionView;
SELECT * FROM airport.IntersectView;
SELECT * FROM airport.ExceptView;
SELECT * FROM airport.Flight_Details;
SELECT * FROM airport.Passenger_Details;
