use sakila;
-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, a.address, c.city, cr.country 
FROM store s 
join address a using(address_id) 
join city c on c.city_id = a.city_id
join country cr on c.country_id = cr.country_id;


-- Write a query to display how much business, in dollars, each store brought in.
select sum(p.amount) as 'Store total amount', s.store_id from payment p
join staff s
on s.staff_id = p.staff_id
GROUP BY store_id;

-- What is the average running time of films by category?
select avg(f.length), c.name as 'Category Name' from film_category fc
join category c
on fc.category_id = c.category_id
join film f
on f.film_id = fc.film_id 
GROUP BY c.name;


-- Which film categories are longest?
select avg(f.length) as 'Average Length', c.name as 'Category Name' from film_category fc
join category c
on fc.category_id = c.category_id
join film f
on f.film_id = fc.film_id 
GROUP BY c.name
ORDER BY avg(f.length) DESC
LIMIT 5;

-- Display the most frequently rented movies in descending order.
select count(i.inventory_id) as 'Number of rentals', f.title as 'Film Name' from rental r
join inventory i
on r.inventory_id = i.inventory_id
join film f
on f.film_id = i.film_id
GROUP BY f.title
ORDER BY count(i.inventory_id) DESC;


-- List the top five genres in gross revenue in descending order.
SELECT sum(p.amount), c.name from payment p
join rental r
on r.rental_id = p.rental_id
join inventory i
on i.inventory_id = r.inventory_id
join film_category f
on f.film_id = i.film_id
join category c
on f.category_id = c.category_id
group by c.name 
ORDER BY sum(p.amount) DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
select i.store_id, f.title from film f
join inventory i
on i.film_id = f.film_id 
join rental r 
on i.inventory_id = r.inventory_id
WHERE 
	r.rental_id IS NOT NULL
    AND f.title = "Academy Dinosaur"
    AND i.store_id = 1;
