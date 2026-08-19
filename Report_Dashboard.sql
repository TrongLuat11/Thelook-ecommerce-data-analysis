
WITH rp_cte AS(
  SELECT 
    FORMAT_TIMESTAMP('%Y-%m', oi.created_at) AS month, -- String 
    p.category,
    ROUND(SUM(oi.sale_price),2) AS TPV, -- Total of revenue 
    COUNT(oi.id) AS TPO, -- Total of orders 
    ROUND(SUM(p.cost),2) as total_cost, -- Total of cost 
    ROUND((SUM(oi.sale_price) - SUM(p.cost)),2) AS total_profit, --Total of profit 
    ROUND( ((SUM(oi.sale_price) - SUM(p.cost)) * 100 / NULLIF(SUM(p.cost), 0)) ,2) 
    AS cost_margin -- Cost margin 
  FROM bigquery-public-data.thelook_ecommerce.order_items oi
  LEFT JOIN bigquery-public-data.thelook_ecommerce.products P 
    ON oi.product_id = p.id
  WHERE oi.status IN ('Complete', 'Shipped', 'Processing')
    AND EXTRACT(YEAR FROM oi.created_at) IN (2024, 2025, 2026)
  GROUP BY FORMAT_TIMESTAMP('%Y-%m', oi.created_at), p.category
  ORDER BY p.category,month DESC 
  )
SELECT 
  month,
  LEFT(month,4) AS year,
  category,
  TPV,
  TPO,
  ROUND((TPV - LAG(TPV) OVER (PARTITION BY category ORDER BY month)) 
    * 100.0 / NULLIF(LAG(TPV) OVER (PARTITION BY category ORDER BY month), 0),2) || "%" AS revenue_growth,
  ROUND(
    (TPO - LAG(TPO) OVER (PARTITION BY category ORDER BY month)) 
    * 100.0 / NULLIF(LAG(TPO) OVER (PARTITION BY category ORDER BY month),0), 2) || "%"  AS order_growth,
  total_cost,
  total_profit,
  cost_margin
FROM rp_cte 

