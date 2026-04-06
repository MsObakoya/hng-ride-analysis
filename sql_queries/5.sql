-- Question 5: Calculate the cancellation rate per city
-- Identify which city had the highest cancellation rate

SELECT 
    pickup_city,
    COUNT(*) AS total_rides,
    COUNT(CASE WHEN is_completed = FALSE THEN 1 END) AS cancelled_rides,
    COUNT(CASE WHEN is_completed = TRUE THEN 1 END) AS completed_rides,
    ROUND((COUNT(CASE WHEN is_completed = FALSE THEN 1 END)::numeric / COUNT(*) * 100), 2) AS cancellation_rate_pct
FROM rides_analysis
GROUP BY pickup_city
ORDER BY cancellation_rate_pct DESC;