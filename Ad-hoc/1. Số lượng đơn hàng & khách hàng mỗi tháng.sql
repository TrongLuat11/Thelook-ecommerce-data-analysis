-- 1: Số lượng đơn hàng & khách hàng mỗi tháng của 3 năm 2024 - 2025 - 2026 
SELECT 
  FORMAT_TIMESTAMP('%Y-%m', created_at) AS Month_order,
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(DISTINCT user_id) AS total_customers
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE 
  status IN ('Complete', 'Shipped', 'Processing')
  AND EXTRACT(YEAR FROM created_at) IN (2024, 2025, 2026)
GROUP BY Month_order 
ORDER BY Month_order DESC 
