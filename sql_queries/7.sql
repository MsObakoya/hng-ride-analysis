-- Question 7: Find the top 3 drivers in each city by total revenue earned (June 2021 - Dec 2024)
-- Revenue counts where they picked up passengers in that city

WITH driver_city_revenue AS (
    SELECT 
        pickup_city,
        driver_id,
        driver_name,
        SUM(payment_amount) AS total_revenue,
        COUNT(*) AS total_rides
    FROM rides_analysis
    WHERE is_completed = TRUE
    GROUP BY pickup_city, driver_id, driver_name
),
ranked_drivers AS (
    SELECT 
        pickup_city,
        driver_id,
        driver_name,
        total_revenue,
        total_rides,
        ROW_NUMBER() OVER (PARTITION BY pickup_city ORDER BY total_revenue DESC) AS rank
    FROM driver_city_revenue
)
SELECT 
    pickup_city,
    driver_id,
    driver_name,
    total_revenue,
    total_rides,
    rank
FROM ranked_drivers
WHERE rank <= 3
ORDER BY pickup_city, rank;