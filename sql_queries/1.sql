
-- Question 1: Find the top 10 longest rides (by distance)

SELECT 
    ride_id,
    driver_name,
    rider_name,
    pickup_city,
    dropoff_city,
    distance_km,
    payment_method
FROM rides_analysis
WHERE is_completed = TRUE  -- Only completed rides
ORDER BY distance_km DESC
LIMIT 10;