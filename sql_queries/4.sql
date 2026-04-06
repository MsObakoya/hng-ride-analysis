-- Question 4: For each driver, calculate their average monthly rides since signup
-- Who are the top 5 drivers with the highest consistency?

WITH driver_monthly_rides AS (
    SELECT 
        driver_id,
        driver_name,
        driver_signup_date,
        DATE_TRUNC('month', pickup_time) AS ride_month,
        COUNT(*) AS rides_in_month
    FROM rides_analysis
    WHERE is_completed = TRUE
    GROUP BY driver_id, driver_name, driver_signup_date, DATE_TRUNC('month', pickup_time)
),
driver_stats AS (
    SELECT 
        driver_id,
        driver_name,
        driver_signup_date,
        COUNT(DISTINCT ride_month) AS active_months,
        SUM(rides_in_month) AS total_rides,
        ROUND((SUM(rides_in_month)::numeric / COUNT(DISTINCT ride_month)), 2) AS avg_rides_per_active_month
    FROM driver_monthly_rides
    GROUP BY driver_id, driver_name, driver_signup_date
)
SELECT 
    driver_id,
    driver_name,
    driver_signup_date,
    active_months,
    total_rides,
    avg_rides_per_active_month
FROM driver_stats
ORDER BY avg_rides_per_active_month DESC
LIMIT 5;