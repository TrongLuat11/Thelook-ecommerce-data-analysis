-- 3. Phân khúc và nhóm khách hàng theo độ tuổi
WITH age_user AS( 
SELECT 
  id,
  CASE 
    WHEN age < 18 THEN '<18 (Underage)'
    WHEN age BETWEEN 18 AND 24 THEN '18-24 (Gen Z)'
    WHEN age BETWEEN 25 AND 34 THEN '25-34 (Young Adults)'
    WHEN age BETWEEN 35 AND 44 THEN '35-44 (Middle Age)' 
    WHEN age BETWEEN 45 AND 54 THEN '45-54 (Mature)'
    WHEN age >= 55 THEN '55+ (Seniors)'
    ELSE 'Unknown'  
  END AS age_group,
  country
FROM bigquery-public-data.thelook_ecommerce.users
)

SELECT 
  CASE age_group
    WHEN '<18 (Underage)' THEN 1
    WHEN '18-24 (Gen Z)' THEN 2
    WHEN '25-34 (Young Adults)' THEN 3
    WHEN '35-44 (Middle Age)' THEN 4
    WHEN '45-54 (Mature)' THEN 5
    WHEN '55+ (Seniors)' THEN 6
    ELSE 7
  END AS index,
  au.age_group,
  ROUND(SUM(oi.sale_price),2) AS revenue_of_seg_age,
FROM bigquery-public-data.thelook_ecommerce.order_items oi
LEFT JOIN age_user au
ON oi.user_id = au.id 
WHERE 
  oi.status IN ('Complete', 'Shipped', 'Processing')
  AND EXTRACT(YEAR FROM oi.created_at) IN (2024, 2025, 2026)
GROUP BY au.age_group
ORDER BY index  ;

