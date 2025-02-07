-- Q 4.2
SELECT 
    d_year, 
    s_nation, 
    p_category, 
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
    AND s_region = 'AMERICA'
    AND (d_year = 1997 OR d_year = 1998)
    AND (p_mfgr = 'MFGR#1' OR p_mfgr = 'MFGR#2')
GROUP BY 
    d_year, s_nation, p_category
ORDER BY 
    d_year, s_nation, p_category;
