-- Question 6: Identify riders who have taken more than 10 rides but never paid with cash

WITH rider_payment_stats AS (
    SELECT 
        rider_id,
        rider_name,
        COUNT(*) AS total_rides,
        COUNT(CASE WHEN LOWER(payment_method) = 'cash' THEN 1 END) AS cash_payments
    FROM rides_analysis
    WHERE is_completed = TRUE
    GROUP BY rider_id, rider_name
)
SELECT 
    rider_id,
    rider_name,
    total_rides
FROM rider_payment_stats
WHERE total_rides > 10 
  AND cash_payments = 0
ORDER BY total_rides DESC;