USE sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration,
		MIN(length) AS max_duration
FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS hours,  
    ROUND(AVG(length)) % 60 AS minutes         
FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT 
MIN(rental_date) AS start_date,
MAX(rental_date) AS latest_date,
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *,
	MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM sakila.rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.

SELECT title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title;

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers.
-- To achieve this, you need to retrieve the concatenated first and last names of customers,
-- along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT CONCAT(first_name, ' ', last_name) AS name,
	LEFT(email, 3) AS email 
FROM sakila.customer
ORDER BY last_name ASC;

-- 1. Next, you need to analyze the films in the collection to gain some more insights. 
-- Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT count(*) As Total_rel_films 
FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating,
    COUNT(*) AS rating_count
FROM sakila.film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating,
    COUNT(rating) AS rating_count
FROM sakila.film   
GROUP BY rating
ORDER BY rating_count DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. 

SELECT rating,  
    COUNT(rating) AS rating_count,  
    ROUND(AVG(length), 2) AS avg_length
FROM sakila.film  
GROUP BY rating  
ORDER BY avg_length DESC;  

-- 2.2 Identify which ratings have a mean duration of over two hours.
SELECT rating,  
    COUNT(rating) AS rating_count,  
    ROUND(AVG(length), 2) AS avg_length
FROM sakila.film  
GROUP BY rating  
HAVING avg_length > 120
ORDER BY avg_length DESC;  

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, 
	COUNT(last_name) AS count_last_name
FROM sakila.actor
GROUP BY last_name
HAVING count_last_name = 1;