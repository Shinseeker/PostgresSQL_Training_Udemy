--- Select statment ---
--- Focused on distinct first---

select distinct rental_rate 
From film;

---Challenge Select Distinct---
select distinct rating
from film;

--- Where clause ---
select last_name, first_name
from customer
where first_name = 'jamie' And last_name = 'rice';

select customer_id, amount, payment_date
from payment
where amount <= 1 or amount >= 8;

Select email 
From customer
where first_name = 'jared';

Select *
From payment
where amount = 7.99;

Select * 
From customer
where store_id = 1 And address_id >= 200;

---challenge where clause ---

select email
from customer
where first_name = 'Nancy'
And last_name = 'Thomas';

select phone 
from address
where address ='259 Ipoh Drive';

--- COUNT

Select count(*) 
from payment;

select count(DISTINCT(amount))
From payment;
