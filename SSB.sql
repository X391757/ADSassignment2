-- Customer Table
CREATE TABLE customer (
    c_custkey INTEGER,
    c_name TEXT,
    c_address TEXT,
    c_city TEXT,
    c_nation TEXT,
    c_region TEXT,
    c_phone TEXT,
    c_mktsegment TEXT
);

-- Part Table
CREATE TABLE part (
    p_partkey INTEGER,
    p_name TEXT,
    p_mfgr TEXT,
    p_category TEXT,
    p_brand TEXT,
    p_color TEXT,
    p_type TEXT,
    p_size INTEGER,
    p_container TEXT
);

CREATE TABLE date (
    d_datekey DATE,
    d_date TEXT,                        -- 替代 FixedString(18)
    d_dayofweek TEXT,                   -- 替代 LowCardinality(String)
    d_month TEXT,                       -- 替代 LowCardinality(String)
    d_year INTEGER,                     -- 替代 UInt16
    d_yearmonthnum INTEGER,             -- 替代 UInt32
    d_yearmonth TEXT,                   -- 替代 LowCardinality(FixedString(7))
    d_daynuminweek INTEGER,             -- 替代 UInt8
    d_daynuminmonth INTEGER,            -- 替代 UInt8
    d_daynuminyear INTEGER,             -- 替代 UInt16
    d_monthnuminyear INTEGER,           -- 替代 UInt8
    d_weeknuminyear INTEGER,            -- 替代 UInt8
    d_sellingseason TEXT,
    d_lastdayinweekfl BOOLEAN,          -- 替代 UInt8
    d_lastdayinmonthfl BOOLEAN,         -- 替代 UInt8
    d_holidayfl BOOLEAN,                -- 替代 UInt8
    d_weekdayfl BOOLEAN                 -- 替代 UInt8
);


-- Supplier Table
CREATE TABLE supplier (
    s_suppkey INTEGER,
    s_name TEXT,
    s_address TEXT,
    s_city TEXT,
    s_nation TEXT,
    s_region TEXT,
    s_phone TEXT
);

CREATE TABLE lineorder (
    lo_orderkey INTEGER,
    lo_linenumber INTEGER,
    lo_custkey INTEGER,
    lo_partkey INTEGER,
    lo_suppkey INTEGER,
    lo_orderdate DATE,
    lo_orderpriority TEXT,
    lo_shippriority INTEGER,
    lo_quantity INTEGER,
    lo_extendedprice INTEGER,
    lo_ordtotalprice INTEGER,
    lo_discount INTEGER,
    lo_revenue INTEGER,
    lo_supplycost INTEGER,
    lo_tax INTEGER,
    lo_commitdate DATE,
    lo_shipmode TEXT
);

COPY part FROM '/mnt/d/SSB/part.tbl';
COPY supplier FROM '/mnt/d/SSB/supplier.tbl';
COPY customer FROM '/mnt/d/SSB/customer.tbl';
COPY date FROM '/mnt/d/SSB/date.tbl';
COPY lineorder FROM '/mnt/d/SSB/lineorder.tbl';



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

-- Q 1.2 
SELECT 
    SUM(lo_extendedprice * lo_discount) AS revenue
FROM 
    lineorder
LEFT JOIN 
    date ON lo_orderdate = d_datekey
WHERE 
    d_yearmonthnum = 199401
    AND lo_discount BETWEEN 4 AND 6
    AND lo_quantity BETWEEN 26 AND 35;

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

-- Q 2.1
SELECT 
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
    p_category = 'MFGR#12' 
    AND s_region = 'AMERICA'
GROUP BY 
    d_year, p_brand
ORDER BY 
    d_year, p_brand;

-- Q 2.2
SELECT 
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
    p_brand BETWEEN 'MFGR#2221' AND 'MFGR#2228' 
    AND s_region = 'ASIA'
GROUP BY 
    d_year, p_brand
ORDER BY 
    d_year, p_brand;

-- Q 2.3
SELECT 
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

-- Q 3.2
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
    c_nation = 'UNITED STATES' 
    AND s_nation = 'UNITED STATES'
    AND d_year BETWEEN 1992 AND 1997
GROUP BY 
    c_city, s_city, d_year
ORDER BY 
    d_year ASC, lo_revenue DESC;

-- Q 3.3
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
    AND d_year BETWEEN 1992 AND 1997
GROUP BY 
    c_city, s_city, d_year
ORDER BY 
    d_year ASC, lo_revenue DESC;

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

-- Q 4.1
SELECT 
    d_year, 
    c_nation, 
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
    AND (p_mfgr = 'MFGR#1' OR p_mfgr = 'MFGR#2')
GROUP BY 
    d_year, c_nation
ORDER BY 
    d_year, c_nation;

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

-- Q 4.3
SELECT 
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

