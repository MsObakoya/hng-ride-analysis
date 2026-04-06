-- Question 3: Compare quarterly revenue between 2021, 2022, 2023, and 2024
-- Which quarter had the biggest YoY growth?

WITH quarterly_revenue AS (
    SELECT 
        ride_year,
        ride_quarter,
        SUM(payment_amount) AS revenue
    FROM rides_analysis
    WHERE is_completed = TRUE
    GROUP BY ride_year, ride_quarter
),
yoy_growth AS (
    SELECT 
        curr.ride_year,
        curr.ride_quarter,
        curr.revenue AS current_revenue,
        prev.revenue AS previous_year_revenue,
        curr.revenue - prev.revenue AS revenue_growth,
        ROUND(((curr.revenue - prev.revenue) / NULLIF(prev.revenue, 0) * 100)::numeric, 2) AS yoy_growth_pct
    FROM quarterly_revenue curr
    LEFT JOIN quarterly_revenue prev 
        ON curr.ride_quarter = prev.ride_quarter 
        AND curr.ride_year = prev.ride_year + 1
)
SELECT 
    ride_year,
    ride_quarter,
    current_revenue,
    previous_year_revenue,
    revenue_growth,
    yoy_growth_pct
FROM yoy_growth
ORDER BY ride_year, ride_quarter;