use `awesome chocolates`;
Show tables;

DESC sales;

select * from sales;

SELECT 
    SaleDate, Amount, Customers
FROM
    sales;

-- Show the list with saledate, amount and amount per boxes

SELECT 
    Saledate,
    Amount,
    Boxes,
    ROUND(Amount / boxes, 2) AS 'Amount Per Box'
FROM
    Sales;

## use Where and order by clause
-- Show the all data from sales with amount > 12000 in a DESC order.
 
SELECT 
    *
FROM
    sales
WHERE
    amount > 12000
ORDER BY amount DESC;

-- Show the all data from sales with boxes > 3000 and in DESC order.
 
SELECT 
    *
FROM
    sales
WHERE
    Boxes > 3000
ORDER BY Amount DESC;

-- Show the all data from sales with geoID = G1, order by PID column along with amount DESC.

SELECT 
    *
FROM
    sales
WHERE
    geoID = 'G1'
ORDER BY PID , Amount DESC;

-- Show the all data from sales with amount > 10000 and sold on date 01-01-2022.

SELECT 
    *
FROM
    sales
WHERE
    amount > 10000
        AND SaleDate >= '2022-01-01';

-- Show the saledate, amount from sales with amount > 10000 and sold year = 2022 with amount DESC order.

SELECT 
    Saledate, amount
FROM
    sales
WHERE
    Amount > 10000 AND YEAR(Saledate) = 2022
ORDER BY Amount DESC
LIMIT 10;

-- Show the all data from sales of boxes between 0 and 50 with order by boxes.
  
SELECT 
    *
FROM
    sales
WHERE
    Boxes > 0 AND Boxes <= 50
ORDER BY Boxes;

-- The above query can alos be written in folowing form.

SELECT 
    *
FROM
    sales
WHERE
    Boxes BETWEEN 1 AND 50
ORDER BY Boxes DESC;

-- Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?

SELECT 
    *
FROM
    sales
WHERE
    Boxes < 100 and Amount > 2000
order by Amount desc;

 -- Show the list with boxes sold 'days of the week', example 4th day = thursday
 
SELECT 
    SaleDate, Amount, Boxes, WEEKDAY(Saledate) AS 'Day of Week'
FROM
    sales
WHERE
    WEEKDAY(Saledate) = 4;
 
SELECT * FROM people;

-- Show the list of people from team Delish and Juices.

SELECT 
    *
FROM
    people
WHERE
    team = 'Delish' OR team = 'Jucies';
 
 -- The above query can alos be written in folowing form.
 
SELECT 
    *
FROM
    people
WHERE
    team IN ('Delish' , 'Jucies');

## Pattern matching
-- Show the list of people with salesperson names starts with 'b' letter.

SELECT 
    *
FROM
    people
WHERE
    Salesperson LIKE 'b%';

SELECT 
    *
FROM
    people
WHERE
    Salesperson LIKE '%b%';

SELECT 
    *
FROM
    people
WHERE
    Location = 'Hyderabad';

## Case operator

SELECT 
    Saledate,
    Amount,
    CASE
        WHEN amount < 1000 THEN 'Under 1K'
        WHEN amount < 5000 THEN 'Under 5K'
        WHEN amount < 10000 THEN 'Under 10K'
        ELSE '10K or More'
    END AS 'Amount category'
FROM
    sales;

##JOIN

SELECT 
    s.SaleDate, s.Amount, p.Salesperson, s.SPID
FROM
    sales s
        LEFT JOIN
    people p ON p.SPID = s.SPID;
    
SELECT 
    s.SaleDate, s.Amount, pr.Product
FROM
    sales s
        LEFT JOIN
    products pr ON pr.PID = s.PID;

SELECT 
    s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
        JOIN
    products pr ON pr.PID = s.PID
WHERE
    p.Team = '';
    
-- Show the list of Salepersons associted with Delish team and amount < 500 in DESC order.

SELECT 
    s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
        JOIN
    products pr ON pr.PID = s.PID
WHERE
    s.Amount < 500 AND p.Team = 'Delish'
ORDER BY Amount DESC;

-- Show the list of Salesperson associated with no team and amount < 500 in DESC order.

SELECT 
    s.SaleDate,
    s.Amount,
    p.Salesperson,
    pr.Product,
    p.Team,
    g.GeoID
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
        JOIN
    products pr ON pr.PID = s.PID
        JOIN
    geo g ON g.GeoID = s.GeoID
WHERE
    s.Amount < 500 AND p.Team = ''
        AND G.GEO IN ('New Zealand' , 'India')
ORDER BY Amount DESC;

## Groupby

SELECT 
    g.GeoID, g.geo, SUM(Amount), AVG(Amount), SUM(Boxes)
FROM
    sales s
        JOIN
    geo g ON s.GeoID = g.GeoID
GROUP BY g.geo
ORDER BY g.GeoID;

SELECT 
    pr.Category, p.Team, SUM(Boxes), SUM(Amount)
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
        JOIN
    products pr ON pr.PID = s.PID
GROUP BY pr.Category , p.team
ORDER BY pr.Category , p.Team;

SELECT 
    pr.Category, p.Team, SUM(Boxes), SUM(Amount)
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
        JOIN
    products pr ON pr.PID = s.PID
WHERE
    p.Team <> ''
GROUP BY pr.Category , p.team
ORDER BY pr.Category , p.Team;

## Use of Having clause

SELECT 
    pr.Category, p.Team, SUM(Boxes), SUM(Amount)
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
        JOIN
    products pr ON pr.PID = s.PID
GROUP BY pr.Category , p.team
HAVING p.Team <> ''
ORDER BY pr.Category , p.Team;

SELECT 
    pr.Product, SUM(s.Amount) AS Total_amount
FROM
    sales s
        JOIN
    products pr ON pr.pid = s.pid
GROUP BY pr.Product
ORDER BY Total_amount DESC;

select DISTINCT(Product) from products;

## Top 10 Products
SELECT 
    pr.Product, SUM(s.Amount) AS Total_amount
FROM
    sales s
        JOIN
    products pr ON pr.pid = s.pid
GROUP BY pr.Product
ORDER BY Total_amount DESC
LIMIT 10;


select * from sales;
select * from people;

-- How many shipments (sales) each of the sales persons had in the month of January 2022?

SELECT 
    p.Salesperson, s.SaleDate, COUNT(s.Boxes) AS Shipment_Count
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
WHERE
    MONTH(saledate) = 01
GROUP BY p.Salesperson
ORDER BY shipment_count;

SELECT 
    p.Salesperson, COUNT(*) AS shipment_Count
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
WHERE
    SaleDate BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY p.Salesperson
ORDER BY shipment_count;

-- Which product sells more boxes? Milk Bars or Eclairs?

SELECT 
    pr.Product, SUM(Boxes) AS Total_Boxes
FROM
    sales s
        JOIN
    products pr ON pr.PID = s.PID
WHERE
    pr.Product IN ('Milk Bars' OR 'Eclairs')
GROUP BY pr.Product;

-- Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?

SELECT 
    pr.Product, SUM(Boxes) AS Total_Boxes
FROM
    sales s
        JOIN
    products pr ON pr.PID = s.PID
WHERE
    pr.Product IN ('Milk Bars' OR 'Eclairs')
        AND SaleDate BETWEEN '2022-02-01' AND '2022-02-07'
GROUP BY pr.Product;

-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
SELECT 
    *
FROM
    sales
WHERE
    customers < 100 AND boxes < 100;

SELECT 
    p.SPID, s.Customers, s.SaleDate, s.Boxes
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
WHERE
    s.Customers < 100 AND s.Boxes < 100
        AND WEEKDAY(s.saledate) = 3;

-- What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?

SELECT DISTINCT
    p.Salesperson
FROM
    sales s
        JOIN
    people p ON p.SPID = s.SPID
WHERE
    s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07';
-- 25 Salespersons


SELECT 
    p.salesperson
FROM
    people p
WHERE
    p.spid NOT IN (SELECT DISTINCT
            s.SPID
        FROM
            sales s
        WHERE
            s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07');
-- 8 Salesperson

-- How many times we shipped more than 1,000 boxes in each month?

SELECT 
    YEAR(saledate) 'Year',
    MONTH(saledate) 'Month',
    COUNT(*) 'Shipped 1000 Boxes'
FROM
    sales
WHERE
    Boxes > 1000
GROUP BY YEAR(saledate) , MONTH(saledate)
ORDER BY YEAR(saledate) , MONTH(saledate);

-- Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?

SELECT 
    YEAR(saledate) ‘Year’,
    MONTH(saledate) ‘Month’,
    IF(SUM(boxes) > 1, 'Yes', 'No') AS 'Status'
FROM
    sales s
        JOIN
    products pr ON pr.PID = s.PID
        JOIN
    geo g ON g.GeoID = s.GeoID
WHERE
    pr.Product = 'After Nines'
        AND g.Geo = 'New Zealand'
GROUP BY YEAR(saledate) , MONTH(saledate)
ORDER BY YEAR(saledate) , MONTH(saledate);

select * from geo;
select * from products;

-- India or Australia? Who buys more chocolate boxes on a monthly basis?

SELECT 
    YEAR(s.saledate) ‘Year’,
    MONTH(s.saledate) ‘Month’,
    SUM(CASE
        WHEN g.geo = 'India' = 1 THEN boxes
        ELSE 0
    END) AS 'India Boxes',
    SUM(CASE
        WHEN g.geo = 'Australia' = 1 THEN boxes
        ELSE 0
    END) AS 'Australia Boxes'
FROM
    sales s
        JOIN
    geo g ON g.GeoID = s.GeoID
GROUP BY YEAR(saledate) , MONTH(saledate)
ORDER BY YEAR(saledate) , MONTH(saledate);