-- 2: Giá trị đơn hàng trung bình và lượng khách mỗi tháng của 3 năm 2024 - 2025 - 2026 
SELECT 
  FORMAT_TIMESTAMP('%Y-%m', o.created_at) AS Month_order,
  -- 1. Tổng số đơn hàng và lượng khách hàng duy nhất
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNT(DISTINCT o.user_id) AS total_customers,
  -- 2. Tổng doanh thu (Monetary)
  ROUND(SUM(oi.sale_price), 2) AS total_revenue,
  -- 3. Giá trị đơn hàng trung bình (AOV = Tổng doanh thu / Tổng số đơn hàng)
  ROUND(SUM(oi.sale_price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
  ON o.order_id = oi.order_id
WHERE 
  o.status IN ('Complete', 'Shipped', 'Processing')
  AND oi.status IN ('Complete', 'Shipped', 'Processing')
  AND EXTRACT(YEAR FROM o.created_at) IN (2024, 2025, 2026)
GROUP BY Month_order
ORDER BY Month_order DESC;