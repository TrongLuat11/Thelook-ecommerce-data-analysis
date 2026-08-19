-- 5. Thống kê doanh thu theo danh mục
WITH monthly_product_revenue AS (
  SELECT
    p.category,
    ROUND(SUM(oi.sale_price), 2) AS revenue_of_pro,
    DENSE_RANK() OVER (
      ORDER BY ROUND(SUM(oi.sale_price), 2) DESC
    ) AS ranking
  FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
  WHERE 
    oi.status IN ('Complete', 'Shipped', 'Processing')
    AND EXTRACT(YEAR FROM oi.created_at) IN (2024, 2025, 2026)
  GROUP BY
    p.category
)

SELECT *
FROM monthly_product_revenue
ORDER BY ranking ASC;