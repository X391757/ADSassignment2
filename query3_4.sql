-- Q 3.4
SELECT 
    c_city, 
    s_city, 
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
    (c_city = 'UNITED KI1' OR c_city = 'UNITED KI5')
    AND (s_city = 'UNITED KI1' OR s_city = 'UNITED KI5')
    AND d_yearmonth = 'Dec1997'
GROUP BY 
    c_city, s_city, d_year
ORDER BY 
    d_year ASC, lo_revenue DESC;