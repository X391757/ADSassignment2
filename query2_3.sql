-- Q 2.3
EXPLAIN ANALYZE SELECT 
    SUM(lo_revenue) AS lo_revenue,
    d_year,
    p_brand
FROM 
    lineorder
LEFT JOIN 
    date ON lo_orderdate = d_datekey
LEFT JOIN 
    part ON lo_partkey = p_partkey
LEFT JOIN 
    supplier ON lo_suppkey = s_suppkey
WHERE 
    p_brand = 'MFGR#2221' 
    AND s_region = 'EUROPE'
GROUP BY 
    d_year, p_brand
ORDER BY 
    d_year, p_brand;