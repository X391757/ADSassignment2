-- Q 1.3
SELECT 
    SUM(lo_extendedprice * lo_discount) AS revenue
FROM 
    lineorder
LEFT JOIN 
    date ON lo_orderdate = d_datekey
WHERE 
    d_weeknuminyear = 6
    AND d_year = 1994
    AND lo_discount BETWEEN 5 AND 7
    AND lo_quantity BETWEEN 26 AND 35;