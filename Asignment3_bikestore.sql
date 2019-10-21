
----AUTHOR:ABHISHEK SHINDE
----EMP ID:58095
----DATE  :18 OCT 2019

----Question1
----1. Create a view [sales_info] based on the orders, order_items,
----and products tables:
CREATE VIEW SALES_INFO 
AS
SELECT PP.product_id,PP.product_name,PP.model_year,SOI.quantity,SOI.list_price,SOI.discount,SO.order_status,
SO.required_date,SO.shipped_date,SO.store_id 
FROM PRODUCTION.products PP INNER JOIN SALES.order_items SOI  ON PP.product_id=SOI.product_id INNER JOIN  SALES.orders SO
ON SOI.order_id=SO.order_id;

SELECT * FROM DBO.SALES_INFO

----Question2
----2. Create a view [staff_sales] based on order_items,orders,staffs to display sales
----info along with (order value) for all staff group by first_name,last_name
CREATE VIEW STAFF_SALES 
AS 
SELECT SS.first_name,SS.last_name,SUM(SOI.quantity*SOI.list_price) AS 'TOTAL SALES' 
FROM SALES.order_items SOI INNER JOIN SALES.orders SO ON SOI.order_id=SO.order_id 
 INNER JOIN sales.staffs SS ON SO.staff_id=SS.staff_id GROUP BY SS.first_name,SS.last_name

 SELECT * FROM STAFF_SALES 

----Question3
----3.Create a stored procedure [usp_add_store] to insert data into stores table and
----return count of store using output parameter.
ALTER PROCEDURE USP_ADD_STORE 
@STORE_NAME VARCHAR(25),
@STORE_COUNT INT OUTPUT
AS
BEGIN
INSERT INTO SALES.stores(store_name) VALUES(@STORE_NAME)
SELECT @STORE_COUNT= COUNT(store_name) FROM SALES.stores
END;

DECLARE @COUNT INT;
EXEC USP_ADD_STORE @STORE_NAME='NEW STORE 1',@STORE_COUNT=@COUNT OUTPUT

SELECT @COUNT AS 'STORE COUNT'

----Question4
----4.Create a stored procedure [usp_store_wise_sales] to display store wise sales
----(store_id,store_name,city,order count) information based on stores,orders group
----by store id.

--ALTER PROCEDURE USE_STORE_WISE_SALES

--AS
--BEGIN
--SELECT SS.store_name,SUM(SOI.quantity*SOI.list_price) AS 'TOTAL STORE SALES' FROM SALES.order_items SOI INNER JOIN SALES.orders SO ON SOI.order_id=SO.order_id 
--INNER JOIN SALES.stores SS ON SS.store_id=SO.store_id GROUP BY SS.store_name
--END;

--EXEC USE_STORE_WISE_SALES
ALTER PROCEDURE USE_STORE_WISE_SALES

AS
BEGIN
SELECT SS.store_name,SS.city,COUNT(SO.order_id) FROM SALES.orders SO 
INNER JOIN SALES.stores SS ON SS.store_id=SO.store_id GROUP BY SS.store_name,SS.city
END;

EXEC USE_STORE_WISE_SALES

----Question5


CREATE FUNCTION SALES.UDF_AVG (
@CUSTOMER_ID INT,
@YEAR  INT 
)
RETURNS INT
AS 
BEGIN
DECLARE @SUM INT 
  SELECT @SUM =SUM(quantity*list_price) FROM SALES.order_items WHERE order_id IN
  (SELECT order_id FROM SALES.orders WHERE customer_id=@CUSTOMER_ID AND YEAR(order_date)=@YEAR)
  RETURN @SUM 
END

(SELECT SALES.UDF_AVG(20,2018) AS 'ORDER_SUM')

