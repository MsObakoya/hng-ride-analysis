-- Question 8: Top 10 drivers qualified for bonuses
-- Criteria: at least 30 rides, avg rating >= 4.5, cancellation rate < 5%

WITH driver_performance AS (
    SELECT 
        driver_id,
        driver_name,
        driver_rating,
        COUNT(*) AS total_rides,
        COUNT(CASE WHEN is_completed = FALSE THEN 1 END) AS cancelled_rides,
        ROUND((COUNT(CASE WHEN is_completed = FALSE THEN 1 END)::numeric / COUNT(*) * 100), 2) AS cancellation_rate_pct,
        SUM(payment_amount) AS total_revenue
    FROM rides_analysis
    GROUP BY driver_id, driver_name, driver_rating
)
SELECT 
    driver_id,
    driver_name,
    driver_rating,
    total_rides,
    cancelled_rides,
    cancellation_rate_pct,
    total_revenue
FROM driver_performance
WHERE total_rides >= 30
  AND driver_rating >= 4.5
  AND cancellation_rate_pct < 5
ORDER BY total_revenue DESC
LIMIT 10;