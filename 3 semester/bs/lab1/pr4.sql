select *
from ticket_flights 
where amount between '15000' and '20000' 
and fare_conditions='Comfort' order by amount desc;