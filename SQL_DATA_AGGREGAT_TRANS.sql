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
SELECT * FROM rental;


SELECT 
  EXTRACT(DAY FROM (MAX(return_date) - MIN(rental_date))) AS date_diff_in_days
FROM rental;


-- B. Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.'

SELECT 
  *,
  to_char(rental_date, 'Month') AS rental_month,
  to_char(rental_date, 'FM09') AS rental_month_number
FROM rental;


-- C. Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

