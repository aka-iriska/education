select amount, 
round((amount*30)/100, 2) sale,
round((amount*70)/100, 2) as overall
from ticket_flights limit 100;