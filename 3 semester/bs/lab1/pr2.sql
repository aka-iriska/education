SELECT seat_no, fare_conditions,
min(aircraft_code) over(partition by fare_conditions) as data
FROM seats;