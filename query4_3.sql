-- Q 4.3
EXPLAIN ANALYZE SELECT 
    d_year, 
    s_city, 
    p_brand, 
    SUM(lo_revenue) - SUM(lo_supplycost) AS profit
FROM 
    lineorder
LEFT JOIN 
    date ON lo_orderdate = d_datekey
LEFT JOIN 
    customer ON lo_custkey = c_custkey
LEFT JOIN 
    supplier ON lo_suppkey = s_suppkey
LEFT JOIN 
    part ON lo_partkey = p_partkey
WHERE 
    c_region = 'AMERICA' 
    AND s_nation = 'UNITED STATES'
    AND (d_year = 1997 OR d_year = 1998)
    AND p_category = 'MFGR#14'
GROUP BY 
    d_year, s_city, p_brand
ORDER BY 
    d_year, s_city, p_brand;

