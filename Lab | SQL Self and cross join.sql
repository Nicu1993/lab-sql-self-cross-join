use sakila;

-- 1. Get all pairs of actors that worked together.
SELECT DISTINCT a1.actor_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times. (Group by, tempory table)
-- Sort customers who rented same movies for 3times or more

select customer_id, film_id, count(*)  from rental r
left join inventory i
on r.inventory_id = i.inventory_id
group by customer_id, film_id
having count(*) > 2
order by film_id, customer_id;

-- find combination of those customers

select fc1.customer_id cus1, fc2.customer_id cus2, fc1.film_id film_id from 
(select customer_id, film_id, count(*)  from rental r left join inventory i on r.inventory_id = i.inventory_id group by customer_id, film_id 
having count(*) > 2 order by film_id, customer_id) fc1
join 
(select customer_id, film_id, count(*)  from rental r left join inventory i on r.inventory_id = i.inventory_id group by customer_id, film_id
having count(*) > 2
order by film_id, customer_id) fc2
on fc1.customer_id <> fc2.customer_id
order by cus1, cus2, film_id;

-- 3. Get all possible pairs of actors and films. 
SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a
CROSS JOIN film f;
