-- 4. Xác định Top 5 sản phẩm mỗi tháng của 3 năm 2024 2025 2026
WITH monthly_product_revenue AS (
  SELECT
    FORMAT_TIMESTAMP('%Y-%m', oi.created_at) AS month_order,
    p.id AS product_id,
    p.category,
    ROUND(SUM(oi.sale_price), 2) AS revenue_of_pro
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
  WHERE 
    oi.status IN ('Complete', 'Shipped', 'Processing')
    AND EXTRACT(YEAR FROM oi.created_at) IN (2024, 2025, 2026)
  GROUP BY 
    month_order,
    p.id,
    p.category
),
ranked_products AS (
  SELECT
    month_order,
    product_id,
    category,
    revenue_of_pro,
    DENSE_RANK() OVER (
      PARTITION BY month_order 
      ORDER BY revenue_of_pro DESC
    ) AS ranking
  FROM monthly_product_revenue
)
SELECT *
FROM ranked_products
WHERE ranking <= 5
ORDER BY 
  month_order DESC, 
  ranking ASC;