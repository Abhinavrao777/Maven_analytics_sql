use mavenmovies;

show tables;

#eg1
/*
“I’m going to send an email letting our customers know there  has been a management change. Could you pull a list of the first  name, last name, and email of 
each of our customers?*/

select first_name,
last_name,
email
 from customer;

#eg2
select * from film;

select distinct rating from film;

#eg2
/*
“My understanding is that we have titles that we rent for durations of 3, 5, or 7 days. Could you pull the records of our films and see if there are 
any other rental durations?” */

select distinct rental_duration
from film;

select  title,rental_duration from film where rental_duration in (5,3,7);

select  title,rental_duration from film where rental_duration not in (3,4,5);

select  title,rental_duration from film where not  rental_duration=7;

#eg3
/*“I’d like to look at payment records for our long-term customers to learn about their purchase patterns. Could you pull all payments from 
our first 100 customers (based on customer ID)?”*/

select * from payment;

select customer_id,rental_id,amount,payment_date
 from payment where
 customer_id between 1 and 100
 and amount >=5 and payment_date >= "2006-01-01";
 
 #eg4
 /*
 The data you shared previously on customers 42, 53, 60, and 75 was good to see.Now, could you please write a query to pull all payments from those
 specific customers, along 
 with payments over $5, from 
any customer? */

select * from payment;

select * from payment where amount>=5 and  customer_id in (42,53,60,75);

select * from payment where amount>=5 or  customer_id in (42,53,60,75);

#eg5
/*
We need to understand the  special features in our films. Could you pull a list of films which include a Behind the Scenes special feature?*/

select * from film where special_features like "%Behind the Scenes%";


#eg6
select rating,count(*) from film group by rating;

#eg7
/*“I need to get a quick overview 
of how long our movies tend to 
be rented out for.
Could you please pull a count of 
titles sliced by rental duration?”
*/
select * from film;

select rental_duration,
count(title)
 from film group by rental_duration;


#eg9
#multiple group by 
select * from film;
select rating,
rental_duration,
count(title) 
from film group by
 rating ,rental_duration;

#eg10
/*
I’m wondering if we charge more 
for a rental when the replacement 
cost is higher.
Can you help me pull a count of 
films, along with the average, 
min, and max rental rate, 
grouped by replacement cost?”

*/
select * from film;

select replacement_cost,
count(title), 
avg(rental_rate),
max(rental_rate),min(rental_rate)
 from film group by replacement_cost;


#eg11
/*
I’d like to talk to customers that 
have not rented much from us to 
understand if there is something 
we could be doing better.
Could you pull a list of 
customer_ids with less than 15 
rentals all-time?
*/


select * from rental;

select customer_id,
count(rental_id)
 from rental
 group by customer_id
 having  count(rental_id)<15;


#eg12
/*
“I’d like to see if our longest films 
also tend to be our most 
expensive rentals. 
Could you pull me a list of all film 
titles along with their lengths
and rental rates, and sort them 
from longest to shortest? */


select * from film;

select title,length,
rental_rate 
from film 
order by length desc;


#eg13
#CASE STATEMENT
select * from film;

select distinct length,
Case
when length <60 then "under by 1 hour"
when length between 60 and 90 then "1-1.5 hours"
when length  > 90 then "too long"
else "Oops…check logic!"
end 
as length_bucket
from film;


#
#eg14
#CASE STATEMENT

select * from rental;

select customer_id,
count(rental_id)
 from rental
 group by customer_id;
 
 
 select customer_id,
 count(rental_id),
case 
when count(rental_id) < 10  then "A"
when count(rental_id) between 10 and 20 then "B"
when count(rental_id) between 21 and 30  then "C"
when count(rental_id) between 31 and 40  then "D"
else "Oops…check logic!"
end 
as category_of_rental
from rental
group by customer_id;


#eg15
select customer_id,
 count(rental_id),
case 
when count(rental_id) < 10  then "A"
when count(rental_id) between 10 and 20 then "B"
when count(rental_id) between 21 and 30  then "C"
when count(rental_id) between 31 and 40  then "D"
end  #not using end 
#so whereever count(rental_id) exceeds 40 then null value assign to customer_id
as category_of_rental
from rental
group by customer_id;



#eg16
#CASE OPERATOR
select * from film;

SELECT DISTINCT
title,
CASE
WHEN rental_duration <= 4 THEN "rentall_too_short"
WHEN rental_rate >= 3.99 THEN "too_expensive"
WHEN rating IN ("NC-17",'R') THEN "THEN too_adult"
WHEN length NOT BETWEEN 60 AND 90 THEN "too_short_or_too_ long"
WHEN description LIKE "%Shark%" THEN "nope_ has _sharks"
ELSE  "great reco_for_my_friend"
END AS fit_for_recommendation
FROM film;


#eg17


#CASE OPERATOR
#reorder
select * from film;

SELECT DISTINCT
title,
CASE
WHEN rental_duration <= 4 THEN "rentall_too_short"
WHEN rental_rate >= 3.99 THEN "too_expensive"
WHEN rating IN ("NC-17",'R') THEN "THEN too_adult"
WHEN length NOT BETWEEN 60 AND 90 THEN "too_short_or_too_ long"
WHEN description LIKE "%Shark%" THEN "nope_ has _sharks"
ELSE  "great reco_for_my_friend"
END AS fit_for_recommendation
,case
WHEN rental_rate >= 3.99 THEN "too_expensive"
WHEN rental_duration <= 4 THEN "rentall_too_short"
WHEN rating IN ("NC-17",'R') THEN "THEN too_adult"
WHEN length NOT BETWEEN 60 AND 90 THEN "too_short_or_too_ long"
WHEN description LIKE "%Shark%" THEN "nope_ has _sharks"
ELSE  "great reco_for_my_friend"
END AS fit_for_recommendation
FROM film;


#eg18
/*
I’d like to know which store each 
customer goes to, and whether or 
not they are active.
Could you pull a list of first and 
last names of all customers, and 
label them as either ‘store 1 
active’, ‘store 1 inactive’, ‘store 2 
active’, or ‘store 2 inactive’?”
*/
select * from customer;

select distinct store_id from customer;
select distinct active from customer;

select first_name,
last_name,
case 
when active=1 and store_id=1 then "store 1 active"
when active=1 and store_id=2 then "store 2 active"
when active=0 and store_id=1 then "store 1 inactive"
when active=0 and store_id=2 then "store 2 inactive"
else "Oops…check logic!"
end as current_state_of_store
 from customer;
 
 
 #eg19
 #IMP--excel's ability to pivot to columns can be replicated in SQL using COUNT and CASE
 #PIVOT TABLE
 /*
 when to use pivot CASE
 ---When CASE Pivoting, we use COUNT() and only count records that match a certain criteria
 
 
NOTE--Use GROUP BY to define your row  labels, and CASE to pivot to columns
 */
 select * from inventory;
 
select  film_id,
count(CASE WHEN store_id=1 then inventory_id else null end) as store_1_copies,
 count(CASE WHEN store_id=2 then inventory_id else null end) as store_2_copies,
 count(inventory_id) as total_copies from inventory group by film_id;
 
 #eg20
 #another example of PIVOT CASE
 /*
 “I’m curious how many inactive 
customers we have at each store.
Could you please create a table to 
count the number of customers 
broken down by store_id (in 
rows), and active status (in 
columns)?”
*/
select * from customer;

select store_id,
count(case when active=1 then customer_id else null end) as active_users,
count(case when active=0 then customer_id else null end) as inactive_users,
count(customer_id) from customer group by store_id;

#middle project


#eg 21
/*We will need a list of all staff members, including their first and last names, email addresses, and the store 
identification number where they work. */

select first_name,last_name,email,store_id from staff;

select * from rental;  

#eg22
/*
We will need separate counts of inventory items held at each of your two stores .
*/
 
 select   store_id,
 count(inventory_id) as inventory_items from inventory
 group by store_id;
 
 
 #eg23
 /*
 We will need a count of active customers for each of your stores. Separately, please.
 */
 
 select store_id,
count(case when active=1 then customer_id else null end) as active_customers
from customer group by store_id;

#eg24
/*
In order to assess the liability of a data breach, we will need you to provide a count of all customer email 
addresses stored in the database.
*/
 
 select count(email) from customer;
 
 #eg25
 /*
 We are interested in how diverse your film offering is as a means of understanding how likely you are to 
keep customers engaged in the future. Please provide a count of unique film titles you have in inventory at 
each store and then provide a count of the unique categories of films you provide
*/
select * from film;
select * from inventory;

select store_id,
  count(distinct film_id)
  from inventory 
  group by store_id;
  
  select * from category;
  
  select count( distinct name)  from category;
  
#eg26
/* We would like to understand the replacement cost of your films. Please provide the replacement cost for the 
film that is least expensive to replace, the most expensive to replace, and the average of all films you carry. */

select film_id,title,min(replacement_cost) as min_replacement_cost from film;

select film_id,title,max(replacement_cost) as max_replacement_cost from film;

select avg(replacement_cost) as avg_replacement_cost from film;

select max(replacement_cost),min(replacement_cost),avg(replacement_cost) from film;

#eg27
/*
We are interested in having you put payment monitoring systems and maximum payment processing 
restrictions in place in order to minimize the future risk of fraud by your staff. Please provide the average 
payment you process, as well as the maximum payment you have processed.
*/


select max(amount) as max_amount,avg(amount) as avg_amount from payment;


#eg28
/*
We would like to better understand what your customer base looks like. Please provide a list of all customer 
identification values, with a count of rentals they have made all-time, with your highest volume customers at 
the top of the list. 
*/
select customer_id,
count(rental_id)
 from rental
 group by customer_id
 order by rental_id desc;

##JOINS



#eg29
#Inner join

select  inventory.inventory_id,
inventory.film_id,
rental.staff_id,
rental.rental_id 
from inventory inner join 
rental using (inventory_id);

select  inventory.inventory_id,
inventory.film_id,
rental.staff_id,
rental.rental_id 
from inventory inner join 
rental using (inventory_id) limit 100;


#eg30 inner join and pivot count
select inventory.film_id,
count(case when staff_id=1 then rental_id else null end) as staff_1_rental,
count(case when staff_id=2 then rental_id else null end) as staff_2_rental,
count(rental_id) as total_rentals
from inventory inner join
rental using (inventory_id)
 group by inventory.film_id;
 
 
#eg31
/*
Can you pull for me a list of each 
film we have in inventory? 
I would like to see the film’s title, 
description, and the store_id value 
associated with each item, and its 
inventory_id. Thanks!
*/

select film.title,
film.description ,
inventory.store_id,
inventory.inventory_id
 from film inner join 
 inventory using (film_id);


##eg32
#inner join and PIVOT COUNT
select film.title,
count(case when store_id=1 then inventory_id else null end) as staff_1_inventory,
count(case when store_id=2 then inventory_id else null end) as staff_2_inventory,
count(inventory_id) as total_inventory
from film inner join
inventory using (film_id)
 group by film.title;
 


 
#eg33
#lets see the difference betweeen left join and right join

select distinct inventory.inventory_id,
rental.inventory_id 
from inventory inner join 
rental on   inventory.inventory_id=rental.inventory_id limit 5000;

#in innner join we are getting 458 and inventory id 5 is not there

select distinct inventory.inventory_id as inventory_inventory_table,
rental.inventory_id as inventory_rental_table
from inventory left join 
rental  on  inventory.inventory_id=rental.inventory_id limit 5000;
#in innner join we are getting 4581 and inventory id 5 never rented


#eg34
/*
One of our investors is interested 
in the films we carry and how 
many actors are listed for each 
film title. 
Can you pull a list of all titles, and 
figure out how many actors are 
associated with each title?”
*/

select
  film.film_id,film.title ,
  count(film_actor.actor_id) 
  from film
  left join  film_actor 
  on film.film_id=film_actor.film_id
  group by
  film.title limit 5000;  #1000 rows
  
  select
  film.film_id,film.title ,
  count(film_actor.actor_id) 
  from film
  inner join  film_actor 
  on film.film_id=film_actor.film_id
  group by
  film.title limit 5000;  #997 rows it will exclude rows which r not in film_actor
  
  select
  film.film_id,film.title ,
  count(film_actor.actor_id) 
  from film
  left join  film_actor 
  on film.film_id=film_actor.film_id
  where film_actor.actor_id is null
  group by
  film.title limit 5000
  ;
  #film ids 257,323 and 803 have count value of actors is zero
  
  
  
  
  
  
  select film.film_id ,
  film_actor.film_id
  from  film
  left join
  film_actor on 
  film.film_id=film_actor.film_id
  where   film_actor.film_id is null
  group by film.film_id limit 5000;
  # 3  ids are nulll
  
#eg35  right join
select count(distinct customer_id) from customer limit 5000;  #599
select count(distinct customer_id) from rental limit 5000;  #599


   select customer.customer_id,
   rental.customer_id
   from customer 
   inner join rental on
   customer.customer_id=rental.customer_id
   group by customer.customer_id;
   
   select customer.customer_id,
   rental.customer_id
   from customer 
   left join rental on
   customer.customer_id=rental.customer_id
   group by customer.customer_id;
   
select customer.customer_id,
   rental.customer_id
   from customer 
   right join rental on
   customer.customer_id=rental.customer_id
   group by customer.customer_id;   #599
   
  
#eg36 INNER VS LEFT VS RIGHT
show tables;

select * from actor_award;

##left join
select 
actor.actor_id,
actor.first_name as actor_first,
actor.last_name as actor_last,
actor_award.first_name as award_first,
actor_award.last_name as award_last,
actor_award.awards
from actor
left join actor_award
on actor.actor_id=actor_award.actor_id
order by actor_id;  #200 rows

#conclusion left join returns all actors values from actor tables and it puts null in awards attributes to those actor who didn't get a award

#inner join
select 
actor.actor_id,
actor.first_name as actor_first,
actor.last_name as actor_last,
actor_award.first_name as award_first,
actor_award.last_name as award_last,
actor_award.awards
from actor
INNER join actor_award
on actor.actor_id=actor_award.actor_id
order by actor_id;  #135 rows
#conclusion inner join returns only those  actors values who receive a award

select * from actor_award;  #157 rows #many actor_ids are nulls

select 
actor.actor_id,
actor.first_name as actor_first,
actor.last_name as actor_last,
actor_award.first_name as award_first,
actor_award.last_name as award_last,
actor_award.awards
from actor
right join actor_award
on actor.actor_id=actor_award.actor_id
order by actor_id;  #157 rows
# right join will returns all actors id from actor_award

/*

*/
#Full join 
#Returns all records from BOTH tables when there is a match in either one of the tables

#eg37
##BRIDGING
/*
   #film---- film_category--- category
   #Using two JOINs, we can produce a result 
   set containing values from 3 tables
   */
select 
film.film_id,
film.title,
film_category.category_id,
category.name
from film 
inner join film_category
on film.film_id=film_category.film_id 
inner join 
category
on film_category.category_id=category.category_id
order by film_id;


#eg37
/*
“Customers often ask which films 
their favorite actors appear in.
It would be great to have a list of 
all actors, with each title that they 
appear in. Could you please pull 
that for me?”
*/
#using two joins

select 
actor.first_name,
actor.last_name,
film.title
from actor 
inner join
 film_actor on 
 actor.actor_id=film_actor.actor_id
inner join 
film on
 film_actor.film_id=film.film_id;
 
 #count of total film
 select 
 actor.actor_id,
actor.first_name,
actor.last_name,
count(film.title)
from actor 
inner join
 film_actor on 
 actor.actor_id=film_actor.actor_id
inner join 
film on
 film_actor.film_id=film.film_id
 group by actor.actor_id;
 
 
 #eg38
 #UNION 
 /*
 Make sure that 
 A) your two SELECT statements have the same number of columns
 B) columns are in the same order
 C) columns in each table have similar data types.
*/

select * from advisor;
select * from investor; 

select 
'advisor' as type, #to show table name
first_name,
last_name
from advisor
union
select 
'investor' as type,
first_name,
last_name
from investor;

#eg39 
/*
“We will be hosting a meeting with 
all of our staff and advisors soon. 
Could you pull one list of all staff 
and advisor names, and include a 
column noting whether they are a 
staff member or advisor? Thanks!”
*/

select 
'advisor' as type, #to show table name
first_name,
last_name
from advisor
union
select 
'staff' as type,
first_name,
last_name
from staff;


#eg40
#multi conditions (where vs and)
#using  where
select 
film.film_id,
film.title,
film_category.category_id,
category.name
from film 
inner join film_category
on film.film_id=film_category.film_id 
inner join 
category
on film_category.category_id=category.category_id
where category.name="horror"
order by film_id;

#using and
select 
film.film_id,
film.title,
film_category.category_id,
category.name
from film 
inner join film_category
on film.film_id=film_category.film_id 
inner join 
category
on film_category.category_id=category.category_id
and category.name="horror"
order by film_id;

/*
#Both methods are valid, and both filter 
the result set to ‘horror’ films, 
producing identical results
*/

#eg41

/*
“The Manager from Store 2 is 
working on expanding our film 
collection there.
Could you pull a list of distinct titles 
and their descriptions, currently 
available in inventory at store 2?”
*/

select 
 distinct film.title,
film.description
from film 
inner join 
inventory on
film.film_id=inventory.film_id
and inventory.store_id =2 limit 5000;


#eg42
/*
I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, the 
inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

use mavenmovies;
select distinct film_id from film limit 5000;

select distinct film_id from inventory limit 5000;

select 
inventory.inventory_id,
inventory.film_id,
inventory.store_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
from inventory
inner join 
film on
film.film_id=inventory.film_id 
limit 5000;

select 
inventory.inventory_id,
inventory.film_id,
inventory.store_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
from inventory
left join 
film on
film.film_id=inventory.film_id 
limit 5000;

#eg43
/*
From the same list of films you just pulled, please roll that data up and provide a summary level overview of 
your inventory. We would like to know how many inventory items you have with each rating at each store
*/

select 
inventory.film_id,
count(case when inventory.store_id=1 then inventory_id else null end) as store_1_inventory,
count(case when inventory.store_id=2 then inventory_id else null end) as store_2_inventory,
film.rating
from inventory
left join 
film on
film.film_id=inventory.film_id 
group by 
inventory.film_id
limit 5000;

#eg44
/*
Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement 
cost, sliced by store and film category
*/
select * from film;
select count(distinct category_id) from film_category;

#1
select 
store_id,
category.name as category,
count(inventory.inventory_id) as total_inventory,
avg(film.replacement_cost) as avg_replacement_cost,
sum(film.replacement_cost) as sum_replacement_cost

from inventory
    left join film
    on inventory.film_id=film.film_id
    left join film_category
    on film.film_id=film_category.film_id
    left join category 
    on film_category.category_id=category.category_id
    
group by store_id
,category.name

order by sum(film.replacement_cost) desc;

#2
#now slicing using pivot count
select 
category.name as category,
count(case when inventory.store_id=1 then inventory.inventory_id else null end) as store_1_inventory,
count(case when inventory.store_id=2 then inventory.inventory_id else null end) as store_2_inventory,
count(inventory.inventory_id) as total_inventory,
avg(film.replacement_cost) as avg_replacement_cost,
sum(film.replacement_cost) as sum_replacement_cost

from inventory
    left join film
    on inventory.film_id=film.film_id
    left join film_category
    on film.film_id=film_category.film_id
    left join category 
    on film_category.category_id=category.category_id
    
group by category.name

order by sum(film.replacement_cost) desc;


#eg45
/*
We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, and their full 
addresses – street address, city, and country
*/
select * from address;

select
concat(customer.first_name,customer.last_name) as full_name,
customer.store_id,
customer.active,
address.district,
address.address,
city.city,
country.country
from customer 
left join address on 
customer.address_id=address.address_id
left join city 
on address.city_id=city.city_id
left join country 
    on country.country_id=city.country_id;


#eg46
/*
We would like to understand how much your customers are spending with you, and also to know who your 
most valuable customers are. Please pull together a list of customer names, their total lifetime rentals, and the 
sum of all payments you have collected from them. It would be great to see this ordered on total lifetime value, 
with the most valuable customers at the top of the list.
*/

select * from payment;

select
customer.customer_id,
concat(customer.first_name,customer.last_name) as full_name,
count(rental.rental_id) as total_count,
sum(payment.amount) as total_payment
from customer
    inner join rental on 
customer.customer_id=rental.customer_id
  inner join payment on
rental.rental_id=payment.rental_id
    group by customer.customer_id
    order by count(rental.rental_id) desc;
    

select
customer.customer_id,
sum(case when rental.staff_id=1 then payment.amount else null end) as total_amount_1_staff,
sum(case when rental.staff_id=2 then payment.amount else null end) as total_amount_2_staff,
sum(payment.amount) as total_payment
from customer
    inner join rental on 
customer.customer_id=rental.customer_id
  inner join payment on
rental.rental_id=payment.rental_id
    group by customer.customer_id
    order by sum(payment.amount) desc; 
    
#47
/*
My partner and I would like to get to know your board of advisors and any current investors. Could you 
please provide a list of advisor and investor names in one table? Could you please note whether they are an 
investor or an advisor, and for the investors, it would be good to include which company they work with. 
*/
select * from investor;
select * from advisor;

#1
select 
"investor" as table_name,
first_name,
last_name,
company_name
from investor
UNION
select
"advisor" as table_name,
first_name,
last_name,
null          #since both table should have total nu of column 
from advisor;

#2 another method
select 
"investor" as table_name,
first_name,
last_name,
company_name
from investor
UNION
select
"advisor" as table_name,
first_name,
last_name,
"no company"          # "N/A" we can put this value as well
from advisor;

#eg48
/*  #IMPORTANT
We're interested in how well you have covered the most-awarded actors. Of all the actors with three types of 
awards, for what % of them do we carry a film? And how about for actors with two types of awards? Same 
questions. Finally, how about actors with just one award?
*/
select * from actor_award;
select 
case
when awards='Emmy, Oscar, Tony ' then "3 awards"
when awards=('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') then "2 awards"
else "1 awards"
end as nu_of_awards,
avg( case when actor_award_id is null then 0 else 1 end) as ptr_actor
from actor_award
group by
case
when awards='Emmy, Oscar, Tony ' then "3 awards"
when awards in ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') then "2 awards"
else "1 awards"
end; 



















#49
/*
My partner and I want to come by each of the stores in person and meet the managers. Please send over 
the managers’ names at each store, with the full address of each property (street address, district, city, and 
country please).
*/
select 
staff.first_name as manager_first_name,
staff.last_name as manager_last_name,
address.address,
address.district,
city.city,
country.country
from store
left join  staff on store.manager_staff_id=staff.staff_id 
left join  address on store.address_id=address.address_id
left join  city on city.city_id=address.city_id
left join  country on country.country_id=city.country_id;


#50
#analysising payment,customer,address,city and country table
#Using pivot count

select 
payment.customer_id,
concat(customer.first_name,customer.last_name) as full_name,
address.district,
city.city,
country.country,
sum(case when staff_id=1 then amount else null end) as  amount_made_store_1,
sum(case when staff_id=2 then amount else null end) as  amount_made_store_2,
sum(amount) as total_amount,

count(case when staff_id=1 then payment_id else null end) as total_payment_store_1,
count(case when staff_id=2 then payment_id else null end) as total_payment_store_2,
count(payment_id) as total_payment_made

from payment

left join customer on
   customer.customer_id=payment.customer_id

left join address on 
   customer.address_id=address.address_id
   
left join city on
   city.city_id=address.city_id
   
left join country on 
   country.country_id=city.city_id
   
group by
customer_id;

#51
#analysising payment,customer,address,city and country table
#Using pivot count
/*
dividing customer by category(total_amount)
*/

select 
payment.customer_id,
concat(customer.first_name,customer.last_name) as full_name,
address.district,
city.city,
country.country,
sum(case when staff_id=1 then amount else null end) as  amount_made_store_1,
sum(case when staff_id=2 then amount else null end) as  amount_made_store_2,
sum(amount) as total_amount,

count(case when staff_id=1 then payment_id else null end) as total_payment_store_1,
count(case when staff_id=2 then payment_id else null end) as total_payment_store_2,
count(payment_id) as total_payment_made,

case when sum(amount) between 50 and 100 then "D"
 when sum(amount) between 101 and 150 then "C"
 when sum(amount) between 151 and 200 then "B"
 when sum(amount) > 200 then "A"
ELSE "OOPS CHECK LOGIC"
END AS GRADE


from payment

left join customer on
   customer.customer_id=payment.customer_id

left join address on 
   customer.address_id=address.address_id
   
left join city on
   city.city_id=address.city_id
   
left join country on 
   country.country_id=city.city_id

group by
customer_id;



use mavenmovies;

#FUNCTIONS
#52
#using over function 

select * from film;

select distinct rental_duration from film;

select rental_duration,
sum(replacement_cost)
 from film
 group by 
 rental_duration;
 
 /*
'group by' clause is that it leads to a reduction in the number of rows. It also leads to the loss of the individual properties of the various rows.
 
#NOTE----#to overcome we gonna use OVER function instead of group by;
*/

#grouping by rental_duration

select
 film_id,
title,
rental_duration,
sum(replacement_cost) over() as total_replacement,
sum(replacement_cost) over w as group_rental_replacement,
sum(length)  over() as total_length,
sum(length) over w as group_rental_length
from film 
window w as (partition by rental_duration);

select distinct rating from film;

#53
#grouping by rating
#using over function

select 
film_id,
title,
rating,
sum(replacement_cost) over() as total_replacement,
sum(replacement_cost) over w as group_rating_replacement,
sum(length)  over() as total_length,
sum(length) over w as group_rating_length
from film 
window w as (partition by rating);

#54
#grouping by special_features
#using over function

select 
film_id,
title,
special_features,
sum(replacement_cost) over() as total_replacement,
sum(replacement_cost) over w as group_feature_replacement,
sum(length)  over() as total_length,
sum(length) over w as group_feature_length
from film 
window w as (partition by special_features);

#55
#using joins and over function
#films--- film_category---category
select * from  category;
select 
film.film_id,
category.category_id,
category.name,
sum(replacement_cost) over() as total_replacement,
sum(replacement_cost) over w as group_feature_replacement,
sum(length)  over() as total_length,
sum(length) over w as group_feature_length
from film
 
inner join  film_category on 
film.film_id=film_category.film_id

inner join  category on 
category.category_id=film_category.category_id

window w as (partition by category.name);


#UDF
use mavenmovies;


#56
#creating user defined function
#joins and PIVOT COUNT 


delimiter $$

create function hello1(amount numeric)
returns char(50) deterministic
begin 
declare grade char default null;

if amount between 0 and 3 then SET  grade ="A";
ELSEIF amount between 3.1 and 6 then  SET grade ="B";
elseif AMOUNT between 6.1 and 9 then SET grade ="C";

ELSE SET GRADE="D";
END IF;
RETURN (GRADE);
end  $$
delimiter ;

select
customer_id,
hello1(amount)
from payment;

#57
#creating user defined function 

delimiter $$
create function hello2(amount numeric)
 returns char(50) deterministic
begin
declare grade_info char default null;
case 
 
when amount  between 50 and 100 then set grade_info ="D";
when amount  between 101 and 150 then set grade_info="C";
when amount between 151 and 200 then set grade_info="B";
else set grade_info="A";

end case;
RETURN GRADE_INFO;
end $$
delimiter ;

#calling function

select 
payment.customer_id,
concat(customer.first_name,customer.last_name) as full_name,
address.district,
city.city,
country.country,
sum(case when staff_id=1 then amount else null end) as  amount_made_store_1,
sum(case when staff_id=2 then amount else null end) as  amount_made_store_2,
sum(amount) as total_amount,

count(case when staff_id=1 then payment_id else null end) as total_payment_store_1,
count(case when staff_id=2 then payment_id else null end) as total_payment_store_2,
count(payment_id) as total_payment_made,
hello2(sum(amount))  #calling function

from payment

left join customer on
   customer.customer_id=payment.customer_id

left join address on 
   customer.address_id=address.address_id
   
left join city on
   city.city_id=address.city_id
   
left join country on 
   country.country_id=city.city_id

group by
customer_id;

#58
select first_name,
last_name,
case 
when active=1 and store_id=1 then "store 1 active"
when active=1 and store_id=2 then "store 2 active"
when active=0 and store_id=1 then "store 1 inactive"
when active=0 and store_id=2 then "store 2 inactive"
else "Oops…check logic!"
end as current_state_of_store
 from customer;

#Another way of doing above query
#by creating user defined function
delimiter $$
create function hello3(active integer ,store_id integer )
 returns char(25) deterministic
begin 
declare current_status char(20) default " ";
case 
when active=1 and store_id=1 then set current_status="store 1 active";
when active=1 and store_id=2 then set current_status="store 2 active";
when active=0 and store_id=1 then set current_status="store 1 inactive";
when active=0 and store_id=2 then set current_status="store 2 inactive";
else set current_status="Oops…check logic!";
end case;
return current_status;
end $$
delimiter ;

#calling function
select first_name,
last_name,
hello3(active,store_id)
 from customer;


#59
#appling aggregate function ,PIVOT count , multi joins , function , where clause , group by , having and order clauses

#creating user defined function
delimiter $$
create function hello4(total_films integer)
 returns char(25) deterministic
begin 
declare rate_category char(10) default " ";
case 
when total_films between 230 and 270 then set rate_category="good";
when total_films between 271 and 310 then set rate_category="excellent";
when total_films between 311 and 340 then set rate_category="wonderful";
else set rate_category="incredible";
end case;
return rate_category;
end $$
delimiter ;

#calling function
#1. 
select 
film_category.category_id,
category.name as category_name,
count(case when inventory.store_id=1 then film.film_id else null end) as store_1_film,
count(case when inventory.store_id=2 then film.film_id else null end) as store_2_film,
count(film.film_id) as total_films,
avg(film.replacement_cost),
sum(film.replacement_cost),
hello4(count(film.film_id)) as rate_of_category_type
from film 
left join 
inventory on
film.film_id=inventory.film_id 
left join
film_category on
film.film_id=film_category.film_id
left join 
category on
film_category.category_id=category.category_id
group by
 film_category.category_id;


#2.  applying  a few  conditions
select 
film_category.category_id,
category.name as category_name,
count(case when inventory.store_id=1 then film.film_id else null end) as store_1_film,
count(case when inventory.store_id=2 then film.film_id else null end) as store_2_film,
count(film.film_id) as total_films,
avg(film.replacement_cost),
sum(film.replacement_cost),
hello4(count(film.film_id)) as rate_of_category_type
from film 
left join 
inventory on
film.film_id=inventory.film_id 
left join
film_category on
film.film_id=film_category.film_id
left join 
category on
film_category.category_id=category.category_id

where film_category.category_id >=5

group by
 film_category.category_id
having count(film.film_id)> 300

order by 
film_category.category_id;





#stored procedure

#60

delimiter $$
create procedure hello1()
begin 
select * from customer;
end $$
delimiter ;

call hello1();

#61
delimiter $$
create procedure hello2()
begin 
select 
film_category.category_id,
category.name as category_name,
count(case when inventory.store_id=1 then film.film_id else null end) as store_1_film,
count(case when inventory.store_id=2 then film.film_id else null end) as store_2_film,
count(film.film_id) as total_films,
avg(film.replacement_cost),
sum(film.replacement_cost),
hello4(count(film.film_id)) as rate_of_category_type

from film 
left join 
inventory on
film.film_id=inventory.film_id 
left join
film_category on
film.film_id=film_category.film_id
left join 
category on
film_category.category_id=category.category_id

group by
 film_category.category_id;


end $$
delimiter ;

call  hello2();

#61
#using in procedure
delimiter $$
create procedure hello3( in a integer)
begin
select 
payment.customer_id,
concat(customer.first_name,customer.last_name) as full_name,
address.district,
city.city,
country.country,
sum(case when staff_id=1 then amount else null end) as  amount_made_store_1,
sum(case when staff_id=2 then amount else null end) as  amount_made_store_2,
sum(amount) as total_amount,

count(case when staff_id=1 then payment_id else null end) as total_payment_store_1,
count(case when staff_id=2 then payment_id else null end) as total_payment_store_2,
count(payment_id) as total_payment_made,

case when sum(amount) between 50 and 100 then "D"
 when sum(amount) between 101 and 150 then "C"
 when sum(amount) between 151 and 200 then "B"
 when sum(amount) > 200 then "A"
ELSE "OOPS CHECK LOGIC"
END AS GRADE


from payment

left join customer on
   customer.customer_id=payment.customer_id

left join address on 
   customer.address_id=address.address_id
   
left join city on
   city.city_id=address.city_id
   
left join country on 
   country.country_id=city.city_id
   where payment.customer_id<=a

group by
payment.customer_id;
end $$
delimiter ;

call hello3(42);  


#62
#in parameter

delimiter $$
create procedure hello4(in a int)
begin 
select * 
from film 
where 
film_id >=a;
end $$
delimiter ;

call hello4(700);

#63 
# in and out parameter
delimiter $$
create procedure hello5(in a int, out b int)
begin 
select 
avg(replacement_cost) 
into b
from film 
where 
film_id >=a;
end $$
delimiter ;

#calling procedure
call hello5(700,@avg_replacement_cost);

select @avg_replacement_cost;




#64 
in and out parameter as declaring inside procedure
delimiter $$
create procedure hello6(in a int)
begin 
declare b int default 0;
select 
avg(length) 
into b
from film 
where 
film_id >=a;
select b; 
end $$
delimiter ;

call hello6(200);


















    




