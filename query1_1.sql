-- Q 1.1
SELECT 
    SUM(lo_extendedprice * lo_discount) AS revenue
FROM 
    lineorder
LEFT JOIN 
    date ON lo_orderdate = d_datekey
WHERE 
    d_year = 1993
    AND lo_discount BETWEEN 1 AND 3
    AND lo_quantity < 25;