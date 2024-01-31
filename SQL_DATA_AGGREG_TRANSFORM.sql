--CHALLENGE 1
--question 1: You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- A. Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT
MAX(length) AS max_length,
min(length) AS min_length
FROM 
film;

-- B. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT
FLOOR(AVG(length)/60) AS avg_hour,
ROUND(AVG(length)%60) AS avg_minute
FROM film;

--QUESTION 2:You need to gain insights related to rental dates:

-- A.Calculate the number of days that the company has been operating.
--Note: "DATEDIFF" function is not available in PostgreSQL

SELECT 
  EXTRACT(DAY FROM (MAX(return_date) - MIN(rental_date))) AS date_diff_in_days
FROM rental;


-- B. Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.'

SELECT 
  *,
  to_char(rental_date, 'Month') AS rental_month,
  to_char(rental_date, 'FM5') AS rental_month_number,
  to_char(rental_date, 'Day') AS rental_day_name,
  to_char(rental_date, 'FM1') AS rental_weekday,
  to_char(rental_date, 'Month') AS date_format,
  to_char(rental_date, 'FM24') AS date_format,
FROM rental;  


-- C. Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT
    DISTINCT TO_CHAR(rental_date, 'Day') AS rental_day_name,
    CASE 
        WHEN EXTRACT (DOW FROM rental_date) <5 THEN 'Workday'
		WHEN EXTRACT(DOW FROM rental_date) >=5 THEN 'Weekend'
		ELSE 'Not a weekday at all'
    END AS workday_category
FROM rental;

--Question 3: You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT 
	title,
	COALESCE(rental_duration::text, 'Not available')AS rental_duration
FROM film;

-- Question 4: Bonus retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address

SELECT
CONCAT(first_name,'',last_name),
LEFT(email,3),
SUBSTRING(email,1,3)
FROM customer;

-- CHALLENGE 2
--question 1:Using the film table, determine:
--A. The total number of films that have been released.

SELECT COUNT(*) FROM film;
SELECT DISTINCT rating FROM film;

-- B. The number of films for each rating.

SELECT COUNT(*) FROM film;
SELECT DISTINCT rating FROM film;
SELECT rating,COUNT(*) FROM film GROUP BY rating;

-- C.The number of films for each rating, sorting the results in descending order of the number of films.

SELECT COUNT(*) FROM film;
SELECT DISTINCT rating FROM film;
SELECT rating,COUNT(*) FROM film GROUP BY rating ORDER BY Count(*)DESC;

--Question 2: Using the film table, determine:
-- A.The mean film duration for each rating

SELECT ROUND(AVG(length)) FROM film;
SELECT rating, ROUND(AVG(length)) FROM film GROUP BY rating ORDER BY ROUND(AVG(length)) DESC;

-- B.Identify which ratings have a mean duration of over two hours 

SELECT 
	rating, 
	ROUND(AVG(length))
	FROM film 
	GROUP BY rating 
	HAVING FLOOR(AVG(length)/60)>=2
	ORDER BY ROUND(AVG(length)) DESC;

--Bonus: determine which last names are not repeated in the table actor.

SELECT 
last_name 
FROM actor 
GROUP BY last_name
HAVING COUNT(*) = 1;






