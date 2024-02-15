SELECT * FROM products;

SELECT 
	COUNT(*) AS total_records, -- 4 prdcts
    MIN(created_at), 
    MAX(created_at) 
FROM orders; 

-- first try without date col
SELECT 
	o.created_at AS created_date,
	p.product_name AS products,
    SUM(o.primary_product_id) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) > '2013'
GROUP BY 1,2;
    
SELECT * FROM orders WHERE YEAR (created_at) > '2014';

-- second try with date (MONTH)
SELECT 
	MONTH(o.created_at) AS month_created,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) > 2013
GROUP BY 
	MONTH(o.created_at),
	p.product_name;

-- second try with date (YEAR, MONTH, DAY)
SELECT 
	DATE_FORMAT(o.created_at, '%y-%m-%d') AS date_created,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) > 2013
GROUP BY 
	DATE_FORMAT(o.created_at, '%y-%m-%d'),
	p.product_name;
    
-- second try with col place-holder
SELECT 
	DATE_FORMAT(o.created_at, '%y-%m-%d') AS date_created,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) > 2013
GROUP BY 1, 2;

-- 2013(Q1) to 2014(Q4) date range, also introduced avg (WIP)
SELECT 
	DATE_FORMAT(o.created_at, '%y-%m-%d') AS date_created,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) >= 2013 AND YEAR (o.created_at) < 2015
GROUP BY 1, 2;


SELECT 
	DATE_FORMAT(MAX(o.created_at), '%y-%m-%d') AS date_created,
	p.product_id AS product_id,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	LEFT JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) >= '2012-04-01' AND YEAR (o.created_at) < '2015-01-01'
GROUP BY 
	DATE_FORMAT(o.created_at, '%Y-%m'), 
    p.product_id,
    p.product_name;
    
SELECT 
	DATE_FORMAT(MAX(o.created_at), '%y-%m-%d') AS date_created,
	p.product_id AS product_id,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	LEFT JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) >= '2014-06-01' AND YEAR (o.created_at) <= '2015-02-28'
GROUP BY 
	DATE_FORMAT(o.created_at, '%Y-%m'), 
    p.product_id,
    p.product_name;
    
-- Visualized    
SELECT 
	DATE_FORMAT(MAX(o.created_at), '%m/%d/%y') AS date_created,
	p.product_id AS product_id,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2015-01-01' AND o.created_at < '2015-03-01'
GROUP BY 
	DATE_FORMAT(o.created_at, '%y/%m'), 
    p.product_id,
    p.product_name;
    
-- product sales '2014-06-01' AND o.created_at <= '2015-02-28'
SELECT 
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2015-01-01' AND o.created_at <= '2015-02-28'
GROUP BY p.product_name
ORDER BY SUM(o.items_purchased) DESC;

SELECT 
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2015-01-01' AND o.created_at < '2015-03-01'
GROUP BY p.product_name
ORDER BY total_orders DESC;

   
   -- AND o.created_at <= '2015-02-28'
    
-- Orders and wesite session trend
SELECT 
	YEAR(o.created_at) AS yr,
    MONTH(o.created_at) AS mo,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE YEAR (o.created_at) >= '2014-06-01' AND YEAR (o.created_at) <= '2015-02-28'
GROUP BY 1,2;

SELECT 
    DATE_FORMAT(MAX(o.created_at), '%y-%m-%d') AS date_created,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2014-06-01' AND o.created_at < '2015-03-01'
GROUP BY DATE_FORMAT(o.created_at, '%Y-%m');





/*PROJECT*/

-- Products' order trend (line chart)
SELECT 
	DATE_FORMAT(MAX(o.created_at), '%y/%m/%d') AS date_created,
	p.product_id AS product_id,
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2014-06-01' 
	AND o.created_at < '2015-03-01'
GROUP BY 
	DATE_FORMAT(o.created_at, '%y/%m'), 
    p.product_id,
    p.product_name;

-- Orders trend - between '2014-06-01' AND '2015-03-01'
SELECT 
    DATE_FORMAT(MAX(o.created_at), '%d/%m/%y') AS date_created,
    SUM(o.items_purchased) AS total_orders
FROM products p
    JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2014-06-01' 
	AND o.created_at < '2015-03-01'
GROUP BY DATE_FORMAT(o.created_at, '%y/%m');

SELECT 
    DATE_FORMAT(MAX(o.created_at), '%d/%m/%y') AS date_created,
    SUM(o.items_purchased) AS total_orders
FROM products p
    JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2014-06-01' 
	AND o.created_at < '2015-03-01'
    AND p.product_name != 'The Hudson River Mini bear' -- 1st order in '14-12-31' 
GROUP BY DATE_FORMAT(o.created_at, '%y/%m');

-- sessions vs orders corrrelation (%d/%m/%y)
SELECT 
    DATE_FORMAT(MAX(o.created_at), '%d/%m/%y') AS date_created,
    COUNT(ws.website_session_id) AS total_sessions,
    SUM(o.items_purchased) AS total_orders
FROM products p
    JOIN orders o ON p.product_id = o.primary_product_id
    JOIN website_sessions ws ON o.website_session_id = ws.website_session_id
WHERE o.created_at >= '2014-06-01' 
	AND o.created_at < '2015-03-01'
    -- AND p.product_name != 'The Hudson River Mini bear'
GROUP BY DATE_FORMAT(o.created_at, '%y/%m');

-- Order by product - between '2014-06-01' AND '2015-03-01'
SELECT 
    p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
    JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2014-06-01' 
	AND o.created_at < '2015-03-01'
    -- AND p.product_name != 'The Hudson River Mini bear'
GROUP BY p.product_name;



-- Order by product drilldown - (FEB - CURRENT COMPLETE MONTH)
SELECT 
	p.product_name AS products,
    SUM(o.items_purchased) AS total_orders
FROM products p
	JOIN orders o ON p.product_id = o.primary_product_id
WHERE o.created_at >= '2015-02-01' AND o.created_at < '2015-03-01'
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- Conversion rate by channel (BinB)
SELECT
    ws.utm_source AS traffic_source,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS conversion_rate
FROM
    website_sessions ws
LEFT JOIN orders o ON ws.website_session_id = o.website_session_id
WHERE ws.created_at >= '2014-06-01' AND ws.created_at < '2015-03-01'
GROUP BY ws.utm_source;








