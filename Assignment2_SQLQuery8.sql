/*SQL BUSINESS QUESTIONS*/

/*1. List all suppliers in the UK*/
--to see the columns in the dbo.Supplier Table, use select * from dbo.Supplier
--use all supplier information to identify each supplier. This query excluded columns with null values (ContactTitle and Fax)
--filter where country is UK to output the result.
--Query:
select s.Id as Supplier_Id, s.CompanyName, s.ContactName, s.City, s.Country, s.Phone
from dbo.Supplier as s
where lower(s.Country) = 'uk';


/*2.List the first name, last name, and city for all customers. Concatenate the first and last name
separated by a space and a comma as a single column*/
--to see the columns in the dbo.Customer Table, use select * from dbo.Customer
--to concat names, use concat(FirstName, ' ,', LastName) as Customer_Name
--Query:
select concat(c.FirstName, ' ,', c.LastName) as Customer_Name, City
from dbo.Customer as c;

/*3. List all customers in Sweden*/
--to see the columns in the dbo.Customer Table, select * from dbo.Customer
--use all customer information to identify each customer
--filter where country is Sweden
--Query:
select c.Id as Customer_Id, c.FirstName, c.LastName, c.City, c.Phone
from dbo.Customer as c
where c.Country = 'Sweden';

/*4. List all suppliers in alphabetical order*/
--to see the columns in the dbo.Supplier Table, use select * from dbo.Supplier
--use the column names to identify each supplier
--use order by asc to arrange in alphabetical order
--Query:
select s.Id as Supplier_Id, s.CompanyName, s.ContactName, s.City, s.Country, s.Phone, s.Fax
from dbo.Supplier as s
order by s.CompanyName asc;

/*5. List all suppliers with their products*/
--supplier Id and CompanyName can be used to identify each supplier from the supplier table
--to get the ProductName for each supplier, use the sql join
--left join was used because the query should return all the suppliers  first and then extract their ProductName from the Product Table
--Query:
select s.Id as Supplier_Id, s.CompanyName, p.ProductName as Supplier_Product
from dbo.Supplier as s
left join dbo.Product as p on s.Id = p.SupplierId;

/*6. List all orders with customers information*/
--to see the columns of the Order table, use select * from [dbo].[Order]
--from the table, the id can be used to identify an order 
--all customer information can be found in the Customer table and select * from dbo.Customer will show the columns in this table
--to get all orders together with the customer who made these orders, use the sql join
--left join was used because the query should return all the orders first and then extract their respective customer details
--in this query, it is possible for a customer to have more than one order
--order by id was used to arrange the result in ascending order
--Query:
select  o.Id as Order_Id, c.Id as Customer_Id, c.FirstName, c.LastName, c.City, c.Country, c.Phone
from [dbo].[Order] as o
left join dbo.Customer as c on o.CustomerId = c.Id
order by Order_Id asc;

/*7. List all orders with product name, quantity, and price, sorted by order number*/
--order id can be found in two tables, Order and OrderItems but only the OrderItem table is related to the product table
--to see column names, select * from dbo.OrderItem
--from the orderitem table, the orderid can be used to identify an order 
--quantity and price (UnitPrice) are in the orderitem table
--productname is in the Product table, use select * from dbo.Product to see column names
--a left join would be used to join the orderitem and product table
--Query:
select oi.OrderId, p.ProductName, oi.Quantity, oi.UnitPrice
from dbo.OrderItem as oi
left join dbo.Product as p on oi.ProductId = p.Id
order by OrderId;


/*8. Using a case statement, list all the availability of products. When 0 then not available, else available*/
--the product table contains a column called isdiscontinued and this will be used to check the availability of products
--Query:
Select p.Id, p.ProductName,
    CASE
        WHEN isdiscontinued = 0 THEN 'Not Available'
        ELSE 'Available'
    END AS Availability
from dbo.Product as p;

/*9. Using case statement, list all the suppliers and the language they speak. The language they speak should be their country E.g if UK, then English*/
--select distinct Country from dbo.Supplier to see the countries in the Country column;
--there are 16 distinct countries but some of these speak the same language eg english is spoken by the UK, USA and Canada
--hence, these countries were included in one case statement
--Query:
Select s.Id, s.CompanyName AS Supplier_name, s.Country,
    CASE
        WHEN s.Country = 'Australia' or s.Country = 'Canada' or s.Country = 'Singapore' or s.Country = 'USA' or s.Country = 'UK' THEN 'English'
		WHEN s.Country = 'Brazil' THEN 'Portuguese'
		WHEN s.Country = 'Denmark' THEN 'Danish'
		WHEN s.Country = 'Finland' THEN 'Finnish'
		WHEN s.Country = 'France' THEN 'French'
        WHEN s.Country = 'Germany' THEN 'German'
		WHEN s.Country = 'Italy' THEN 'Italian'
		WHEN s.Country = 'Japan' THEN 'Japanese'
		WHEN s.Country = 'Netherland' THEN 'Dutch'
		WHEN s.Country = 'Norway' THEN 'Norwegian'
		WHEN s.Country = 'Spain' THEN 'Spanish'
		WHEN s.Country = 'Sweden' THEN 'Swedish'
        ELSE 'Unknown'
    END AS Supplier_language
from dbo.Supplier as s;


/*10. List all products that are packaged in Jars*/
--Package column from dbo.Product;
--filter the column using %jar% because there maybe other words attached to jars as seen in the Package column
--Query:
select p.Id as Product_Id, p.ProductName, p.Package
from dbo.Product as p
where lower(p.Package) like '%jars%';

/*11. List products name, unitprice and packages for products that starts with Ca*/
--ProductName, UnitPrice and Packages from Product table
--filter the ProductName column using Ca% for names that start with Ca
--Query:
select p.ProductName, p.UnitPrice, p.Package
from dbo.Product as p
where p.ProductName like 'Ca%';

/*12. List the number of products for each supplier, sorted high to low.*/
--suppliers details from Supplier table
--get the number of products for each supplier using count(productid)
--Product and Supplier were joined to output the get the count of products per supplier
--Query:
select  s.Id, s.CompanyName, count(p.Id) as Number_of_Products
from dbo.Product as p
inner join dbo.Supplier as s on p.SupplierId = s.Id
group by s.Id, s.CompanyName
order by Number_of_Products desc;

/*13. List the number of customers in each country*/
--Number of customers means count of customers using the customer id
--country of customers in the Customer table
--Query:
select c.Country, count(c.Id) as Number_of_customers_per_country 
from dbo.Customer as c
group by c.Country;

/*14. List the number of customers in each country, sorted high to low.*/
--Number of customers means count of customers using the customer id
--country of customers in the Customer table
--order by the count of customers per country in descending order
--Query:
select c.Country, count(c.Id) as Number_of_customers_per_country 
from dbo.Customer as c
group by c.Country
order by Number_of_customers_per_country desc;


/*15. List the total order amount for each customer, sorted high to low.*/
--customer details from Customer table
--total order amount per customer is the sum of TotalAmount in Order table for each customer id
--both tables were joined to output the total order per customer
--the results was grouped by all the customer details 
--right join was used to ensure that all the customer were returned before getting the number of orders as its possible that some customers may have zero orders within this period
--order by the sum of total amount per customer desc was used to sort the result from high to low
--Query:
select c.Id, c.FirstName, c.LastName, sum(o.TotalAmount) as Total_order_amount_per_customer
from [dbo].[Order] as o
right join dbo.Customer as c on o.CustomerId = c.Id
group by c.Id, c.FirstName, c.LastName
order by Total_order_amount_per_customer desc;


/*16. List all countries with more than 2 suppliers.*/
--supplier id and country in the Supplier table
--count of supplier id and grouping by country will give the number of suppliers per country
--having was used to filter the output to return only countries with more than 2 suppliers
--Query:
select s.Country, count(s.Id) as number_of_supplier  
from dbo.Supplier as s
group by s.Country
having count(s.Id) > 2;

/*17. List the number of customers in each country. Only include countries with more than 10 customers.*/
--customer id and country in the Customer table
--count of customer id and grouping by country will give the number of customers per country
--having was used to filter the output to return only countries with more than 10 customers
--Query:
select c.Country, count(c.Id) as number_of_customer 
from dbo.Customer as c
group by c.Country
having count(c.Id) > 10;

/*18. List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers.*/
--customer id and country in the Customer table
--count of customer id and grouping by country will give the number of customers per country
--using where country is not USA will exclude USA from the results
--having was used to filter the output to return only countries with 9 or more customers
--Query:
Select c.Country, count(c.Id) AS customer_count
from dbo.Customer as c
WHERE c.Country != 'USA'
GROUP BY c.Country
HAVING count(c.Id) >= 9
ORDER BY customer_count DESC;


/*19. List customer with average orders between $1000 and $1200.*/
--customer details from Customer table
--average order for each customer is the average(TotalAmount) of order per customer from the Order table
--join both tables 
--filter using having to return results where average order amount was between 1000 and 1200
--Query:
Select c.Id as customer_id, c.FirstName, c.LastName, avg(o.TotalAmount) as average_order_amount
from dbo.Customer c
left join [dbo].[Order] o on c.Id = o.CustomerId
group by c.Id, c.FirstName, c.LastName
having avg(o.TotalAmount) BETWEEN 1000 AND 1200;



/*20. Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013.*/
--OrderDate, Orderid and TotalAmount from the Order table
--number of orders is the count(id)
--total amount sold is the sum(TotalAmount)
--filter using where OrderDate is between '2013-01-01' and '2013-01-31'
--Query:
Select concat(month(o.OrderDate),'-',year(o.OrderDate)) as Month_and_Year, count(o.id) as number_of_orders, sum(o.TotalAmount) as total_amount_sold
from [dbo].[Order] as o
where o.OrderDate between '2013-01-01' and '2013-01-31'
group by concat(month(o.OrderDate),'-',year(o.OrderDate));












