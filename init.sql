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