-- This is the extension part of the SQl | R project.
/* Here I will load all the dataset and make them connected by 
   applying the constraint.*/
-- first create a working database where all work will be done.
-- the data base name is :: codeone
CREATE DATABASE codeone;
-- now show in the RDBMS SQL server how many database are there.
SHOW DATABASES;
-- My working database is "codeone", let that use in.
USE codeone;
-- now all table I uploaded by GUI Navigator.
/* now i will do some wrangling process */
-- moto: to set primary key and connect each table 
-- count number of obs. each table
SELECT count(row_id)FROM superstore  -- 9996 obs.
SELECT count(row_id)FROM customers   -- 9996 obs.
SELECT count(row_id)FROM products    -- 9996 obs.
SELECT count(row_id)FROM sales       -- 9996 obs.
-- all number of obs. are same then itis ok to began mapping.
-- To make order_id as primary key in the superstore table
ALTER TABLE superstore  ADD PRIMARY KEY (row_id) -- Error duplicate value
-- let fix it out 
SELECT row_id, count( row_id) 
FROM superstore 
GROUP BY row_id HAVING count(row_id)> 1 
-- |row_id|count( row_id)|
-- |------|--------------|
-- |3     |2             |
-- |9,821 |2             |

SELECT row_id, count( row_id) 
FROM sales  
GROUP BY row_id HAVING count(row_id)> 1 
-- |row_id|count( row_id)|
-- |------|--------------|
-- |3     |2             |
-- |9,821 |2             |
SELECT row_id, count( row_id) 
FROM customers  
GROUP BY row_id HAVING count(row_id)> 1
-- |row_id|count( row_id)|
-- |------|--------------|
-- |3     |2             |
-- |9,821 |2             |
SELECT row_id, count( row_id) 
FROM products  
GROUP BY row_id HAVING count(row_id)> 1
-- |row_id|count( row_id)|
-- |------|--------------|
-- |3     |2             |
-- |9,821 |2             |
-- As I see all the duplicate are in the same obs. index
-- let see all those duplicate obs.
SELECT * FROM superstore s LEFT JOIN customers c 
       ON s.row_id=c.row_id
LEFT JOIN products p 
      ON s.row_id=p.row_id
LEFT JOIN sales 
      ON s.row_id=sales.row_id
  WHERE s.row_id = 3 OR s.row_id= 9821;
-- let remove all those duplicates.
-- >> removing duplicate rows from superstore table
-- let see the duplicate obs.and frequency of superstore table 
WITH superstoreCTE AS 
     (SELECT *, ROW_NUMBER ()
     OVER (PARTITION BY row_id ORDER BY row_id) AS index1
     FROM superstore)
  SELECT * FROM superstoreCTE WHERE index1 > 1
 -- delect all duplicate rows from superstore table.
SELECT * FROM superstore WHERE row_id = 3
|row_id|order_id      |order_date|ship_date|ship_mode   |
|------|--------------|----------|---------|------------|
|3     |CA-2016-138688|6/12/2016 |6/16/2016|Second Class|
|3     |CA-2016-138688|6/12/2016 |6/16/2016|Second Class|
-- locate the duplicate value 
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
|row_id|order_id      |order_date|ship_date|ship_mode     |
|------|--------------|----------|---------|--------------|
|3     |CA-2016-138688|6/12/2016 |6/16/2016|Second Class  |
|3     |CA-2016-138688|6/12/2016 |6/16/2016|Second Class  |
|9,821 |CA-2015-162201|6/8/2015  |6/12/2015|Standard Class|
|9,821 |CA-2015-162201|6/8/2015  |6/12/2015|Standard Class|
-- let delet the duplicate rows
/*-- DELETE  FROM superstore 
WHERE row_id IN (SELECT row_id FROM (SELECT row_id ,count(row_id) AS frequency FROM superstore GROUP BY row_id
HAVING frequency > 1) AS temp);
 SELECT row_id ,count(row_id) AS frequency FROM superstore GROUP BY row_id
 HAVING row_id= 2*/
 CREATE TABLE superstore_temp AS 
 SELECT DISTINCT * FROM superstore
 DROP TABLE superstore 
 ALTER TABLE superstore_temp 
 RENAME TO superstore
 -- Delete all duplicate row from customers table
 CREATE TABLE customers_temp AS 
 SELECT DISTINCT * FROM customers 
 DROP TABLE customers
 ALTER TABLE customers_temp 
 RENAME TO customers
 
 WITH customersCTE AS 
     (SELECT *, ROW_NUMBER ()
     OVER (PARTITION BY row_id ORDER BY row_id) AS index1
     FROM customers)
  SELECT * FROM customersCTE WHERE index1 > 1

-- delect all duplicate rows from products table 
WITH productsCTE AS 
     (SELECT *, ROW_NUMBER ()
     OVER (PARTITION BY row_id ORDER BY row_id) AS index1
     FROM products)
  SELECT * FROM productsCTE WHERE index1 > 1
CREATE TABLE products_temp AS 
 SELECT DISTINCT * FROM products
 DROP TABLE products
 ALTER TABLE products_temp 
 RENAME TO products
 -- Delete all the duplicate rows from sales table 
 WITH salesCTE AS 
     (SELECT *, ROW_NUMBER ()
     OVER (PARTITION BY row_id ORDER BY row_id) AS index1
     FROM sales)
  SELECT * FROM salesCTE WHERE index1 > 1
  CREATE TABLE sales_temp AS 
 SELECT DISTINCT * FROM sales
 DROP TABLE sales
 ALTER TABLE sales_temp 
 RENAME TO sales
--  now all the duplicate rows are removed .
-- let connect all the table with constraint 
 -- let add primary key at the column of row_in on superstore table
ALTER TABLE superstore ADD PRIMARY KEY(row_id)
DESC superstore 
-- connect all table with superstore table with foreign mey 
ALTER TABLE customers ADD FOREIGN KEY(row_id)REFERENCES superstore(row_id)
DESC customers 
ALTER TABLE sales ADD FOREIGN KEY(row_id)REFERENCES superstore(row_id)
DESC sales 
ALTER TABLE products ADD FOREIGN KEY(row_id)REFERENCES superstore(row_id)
-- now all the table are connected   

-- As i need to see all the table frequently thats why I use stored Proecedure
delimiter &&
 CREATE PROCEDURE superstore_tbl()
 BEGIN 
 SELECT * FROM codeone.superstore;
 END&&
delimiter ;
  
CALL superstore_tbl()

delimiter &&
 CREATE PROCEDURE products_tbl()
 BEGIN 
 SELECT * FROM codeone.products;
 END&&
delimiter ;
 
CALL products_tbl()
  
delimiter &&
 CREATE PROCEDURE customers_tbl()
 BEGIN 
 SELECT * FROM codeone.customers;
 END&&
delimiter ;
CALL customers_tbl()
  
delimiter &&
 CREATE PROCEDURE sales_tbl()
 BEGIN 
 SELECT * FROM codeone.sales;
 END&&
delimiter ;
CALL sales_tbl() 
 -- to 10 customers name by sales 
-- top 10 
CALL sales_tbl()

-- top ten customer with maximum sales value 
delimiter //
CREATE PROCEDURE top_ten_customer_sales(IN lim int )
BEGIN 
SELECT DISTINCT  customer_id, customer_name FROM customers 
WHERE row_id IN (SELECT row_id FROM sales WHERE sales > 
(SELECT avg(sales)FROM sales) 
ORDER BY sales DESC )
END // 
delimiter ; -- > back TO defult delimiter
 
CALL top_ten_customer_sales(10)
-- let see top three customers with maximum sales 
CALL top_ten_customer_sales(3)

-- let view some important variable in a virtual table ( by View)
CREATE VIEW customer_sales_details AS 
SELECT c.customer_name,p.product_name,s.sales 
FROM customers AS c INNER JOIN products AS p 
ON c.row_id = p.row_id
INNER JOIN sales AS s
ON c.row_id=s.row_id
ORDER BY s.sales DESC 
-- let display the virtual table 
SELECT * FROM customer_sales_details 
 -- long name make it shorter 
RENAME TABLE customer_sales_details TO sales_details
-- to list all the views name 
SHOW FULL TABLES
WHERE table_type='VIEW' 


 
 
 
 -- row number
WITH superstoreCTE AS 
     (SELECT *, ROW_NUMBER ()
     OVER (PARTITION BY row_id ORDER BY row_id) AS index1
     FROM superstore)
  SELECT * FROM superstoreCTE WHERE index1 > 1

 
 DELETE FROM demo 
 WHERE id IN (SELECT id from( SELECT id,ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS index1 
 FROM demo ) AS temp WHERE index1 > 1)
 
SELECT * FROM demo 

ALTER TABLE demo 
ADD COLUMN index2 int PRIMARY KEY FIRST 

DROP COLUMN demo.index1
ALTER TABLE demo 
DROP COLUMN index1
MODIFY COLUMN  index1 int PRIMARY KEY AUTO_INCREMENT=1000 
	
ALTER TABLE demo ADD COLUMN index1 int NOT NULL AUTO_INCREMENT  PRIMARY KEY FIRST;

