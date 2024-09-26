USE case_swiggy; -- Assuming your database is named "case_swiggy"


#1)
SELECT COUNT(DISTINCT restaurant_name) AS high_rated_restaurants
FROM `swiggy(1)`
WHERE rating > 4.5
LIMIT 0, 1000;

#2)
select city,count(distinct restaurant_name)
as restaurant_count from `swiggy(1)`
group by city
order by restaurant_count desc
limit 1;

#3)
select count(distinct restaurant_name) as pizza_restaurant
from `swiggy(1)`
where restaurant_name like '%Pizza%';

#To Print the names of 4 restaurant
select distinct restaurant_name as pizza_restaurant
from `swiggy(1)`
where restaurant_name like '%Pizza%';

#4)
select cuisine,count(*) as cuisine_count
from `swiggy(1)`
group by cuisine
order by cuisine_count desc
limit 1;

#5)
select city,avg(rating) as average_rating
from `swiggy(1)` group by city;

#6)
select distinct restaurant_name,
menu_category,max(price) as highestprice
from `swiggy(1)` where menu_category='Recommended'
group by restaurant_name,menu_category;

#7)

select distinct restaurant_name,cost_per_person
from `swiggy(1)` where cuisine<> 'Indian'
order by cost_per_person desc
limit 5;

#8)
select distinct
restaurant_name,cost_per_person
from `swiggy(1)` where cost_per_person>(
select avg(cost_per_person)from `swiggy(1)`);

#9)
select distinct
t1.restaurant_name,t1.city,t2.city
from `swiggy(1)`t1 join `swiggy(1)` t2
on t1.restaurant_name=t2.restaurant_name and
t1.city<>t2.city;

#10)
select distinct restaurant_name ,menu_category,
count(item) as no_of_items from `swiggy(1)`
where menu_category='Main Course'
group by restaurant_name,menu_category
order by no_of_items desc limit 1;

#11)
select distinct restaurant_name,
(count(case when `veg_or_non-veg` ='Veg' then 1 end)*100/
count(*)) as vegetarian_percetage
from `swiggy(1)`
group by restaurant_name
having vegetarian_percetage=100.00
order by restaurant_name;

#12)
select distinct restaurant_name,
avg(price) as average_price
from `swiggy(1)` group by restaurant_name
order by average_price limit 1;

#13)
select distinct restaurant_name,
count(distinct menu_category) as 
no_of_categories
from `swiggy(1)`
group by restaurant_name
order by no_of_categories desc limit 5;

#14)  Correlated Subquery:
select distinct restaurant_name,
(count(case when `veg_or_non-veg`='Non-veg' then
1 end)*100
/count(*)) as nonvegetarian_percentage
from `swiggy(1)`
group by restaurant_name
order by nonvegetarian_percentage desc limit 1;

#14)Find the restaurants that have a rating higher than the average rating of restaurants in the same city.
SELECT restaurant_no, restaurant_name, city, rating
FROM `swiggy(1)`
WHERE rating > (
    SELECT AVG(rating)
    FROM `swiggy(1)`
    WHERE city = `swiggy(1)`.city
    );

#15). Window Functions:
#Question: Calculate the rank of each restaurant based on its average rating within the city.
SELECT restaurant_no, restaurant_name, city, rating,
       RANK() OVER (PARTITION BY city ORDER BY rating DESC) AS restaurant_rank
FROM `swiggy(1)`;

