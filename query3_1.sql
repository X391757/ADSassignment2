-- Q 3.1
SELECT 
    c_nation, 
    s_nation, 
    d_year, 
    SUM(lo_revenue) AS lo_revenue
FROM 
    lineorder
LEFT JOIN 
    date ON lo_orderdate = d_datekey
LEFT JOIN 
    customer ON lo_custkey = c_custkey
LEFT JOIN 
    supplier ON lo_suppkey = s_suppkey
WHERE 
    c_region = 'ASIA' 
    AND s_region = 'ASIA'
    AND d_year BETWEEN 1992 AND 1997
GROUP BY 
    c_nation, s_nation, d_year
ORDER BY 
    d_year ASC, lo_revenue DESC;