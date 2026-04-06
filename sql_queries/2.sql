-- Question 2: How many riders who signed up in 2021 still took rides in 2024?

SELECT COUNT(DISTINCT rider_id) AS riders_2021_active_in_2024
FROM rides_analysis
WHERE EXTRACT(YEAR FROM rider_signup_date) = 2021
  AND ride_year = 2024
  AND is_completed = TRUE;