use couriermanagementsystem;
-- Task 1 ( Database Design)
-- show tables in courier management system
show tables;
-- view tables with records
select*from courier;
select*from courierservices;
select*from employee;
select*from location;
select*from payment;
select*from user;
-- now the database is ready with the tables and recordss into it.

-- Task 2 (SELECT, WHERE)
-- 1. List all customers: 
SELECT * from user;
-- 2. List all orders for a specific customer: 
Select * from courier where sendername='ram';
-- 3. List all couriers: 
Select * from courier;
-- 4. List all packages for a specific order: 
Select * from courier where TrackingNumber='TRACK456789'; 
-- 5. List all deliveries for a specific courier: 
Select * from courier where CourierID = 3;
-- 6. List all undelivered packages: 
SELECT * FROM Courier WHERE Status != 'Delivered';
-- 7. List all packages that are scheduled for delivery today: 
Select * from courier where DeliveryDate=curdate();
-- 8. List all packages with a specific status: 
select * from courier where status = 'pending';
-- 9. Calculate the total number of packages for each courier. 
select courierid, count(*) as total_packages from courier group by courierid;
-- 10. Find the average delivery time for each courier 
SELECT CourierID, AVG(DATEDIFF(DeliveryDate, CURDATE())) AS AvgDeliveryTime FROM Courier GROUP BY CourierID;
-- 11. List all packages with a specific weight range: 
select * from courier where Weight between 2 and 5;
-- 12. Retrieve employees whose names contain 'John' 
select * from employee where name='john'; -- can use like function too
-- 13. Retrieve all courier records with payments greater than $50
select * from courier where courierid in (select courierid from payment where Amount>50); 

-- TASK 3 (Group By, Order By, Having, Aggregate functions, where)
-- 14.	Find the total number of couriers handled by each employee
SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalCouriers
FROM Employee as e
LEFT JOIN Courier as c ON e.EmployeeID = c.CourierID
GROUP BY e.EmployeeID, e.Name;
-- 15. Calculate the total revenue generated by each location 
select p.paymentid, l.locationname, sum(p.amount) as totslrevenue
from payment as p
join location as l on p.paymentid=l.locationid
group by p.paymentid, l.locationid; 
-- 16. Find the total number of couriers delivered to each location.
 select l.locationid, l.locationname, count(c.courierid) as totalcouriers
 from location as l
 join courier as c on l.locationid=c.courierid
 group by l.locationid;
-- 17. Find the courier with the highest average delivery time: 
select courierid,avg(datediff(deliverydate, curdate())) as averagetime
from courier 
group by courierid
order by averagetime DESC
limit 1;
-- 18. Find Locations with Total Payments Less Than a Certain Amount 
select locationid, count(amount) as totalpayments
from payment
group by locationid
having totalpayments<100;
-- 19. Calculate Total Payments per Location 
select locationid, sum(amount) as totalpayment
from payment
group by locationid;
-- 20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X): 
select courierid, sum(amount) as totalpayments
from payment
where locationid=11
group by courierid
having totalpayments>1000;
-- 21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'): 
SELECT C.*
FROM Courier c
INNER JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.PaymentDate > '2024-03-01'
GROUP BY c.CourierID
HAVING SUM(p.Amount) > 100;
-- 22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD')
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalAmountReceived
FROM Location l
LEFT JOIN Payment p ON l.LocationID = p.LocationID
WHERE p.PaymentDate < '2024-04-11'
GROUP BY l.LocationID, l.LocationName
HAVING TotalAmountReceived > 50;
-- Task 4: (Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join) 
-- 23. Retrieve Payments with Courier Information 
SELECT p.*, c.*
FROM Payment p
JOIN Courier c ON p.CourierID = c.CourierID;
-- 24. Retrieve Payments with Location Information 
SELECT p.*, l.*
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID;
-- 25. Retrieve Payments with Courier and Location Information 
SELECT p.*, c.*, l.*
FROM Payment p
JOIN Courier c ON p.CourierID = c.CourierID
JOIN Location l ON p.LocationID = l.LocationID;
-- 26. List all payments with courier details 
SELECT p.*, c.*
FROM Payment p
JOIN Courier c ON p.CourierID = c.CourierID;
-- 27. Total payments received for each courier 
SELECT p.CourierID, SUM(p.Amount) AS TotalPaymentsReceived
FROM Payment p
GROUP BY p.CourierID;
-- 28. List payments made on a specific date
SELECT *
FROM Payment
WHERE PaymentDate = '2024-04-08';
-- 29. Get Courier Information for Each Payment 
SELECT p.*, c.*
FROM Payment p
LEFT JOIN Courier c ON p.CourierID = c.CourierID;
-- 30. Get Payment Details with Location 
SELECT p.*, l.*
FROM Payment p
LEFT JOIN Location l ON p.LocationID = l.LocationID;
-- 31. Calculating Total Payments for Each Courier 
SELECT p.CourierID, SUM(p.Amount) AS TotalPayments
FROM Payment p
GROUP BY p.CourierID;
-- 32. List Payments Within a Date Range 
SELECT *
FROM Payment
WHERE PaymentDate BETWEEN '2024-04-01' AND '2024-04-11';
--- 33. Retrieve a list of all users and their corresponding courier records, including cases where there are 
-- no matches on either side 
--- 34. Retrieve a list of all couriers and their corresponding services, including cases where there are no 
-- matches on either side 
SELECT c.*, cs.*
FROM Courier c
LEFT JOIN CourierServices cs ON c.ServiceID = cs.ServiceID;
--- 35. Retrieve a list of all employees and their corresponding payments, including cases where there are 
-- no matches on either side 
SELECT e.*, p.*
FROM Employee e
LEFT JOIN Payment p ON e.EmployeeID = p.EmployeeID;
-- 36. List all users and all courier services, showing all possible combinations.
SELECT u.*, cs.*
FROM User u
CROSS JOIN CourierServices cs; 
-- 37. List all employees and all locations, showing all possible combinations: 
SELECT e.*, l.*
FROM Employee e
CROSS JOIN Location l;
-- 38. Retrieve a list of couriers and their corresponding sender information (if available)
SELECT c.*, u.Name AS SenderName, u.Address AS SenderAddress
FROM Courier c
LEFT JOIN User u ON c.SenderName = u.Name AND c.SenderAddress = u.Address; 
-- 39. Retrieve a list of couriers and their corresponding receiver information (if available): 
SELECT c.*, u.Name AS ReceiverName, u.Address AS ReceiverAddress
FROM Courier c
LEFT JOIN User u ON c.ReceiverName = u.Name AND c.ReceiverAddress = u.Address;
--- 40. Retrieve a list of couriers along with the courier service details (if available): 
SELECT c.*, cs.*
FROM Courier c
LEFT JOIN CourierServices cs ON c.ServiceID = cs.ServiceID;
--- 41. Retrieve a list of employees and the number of couriers assigned to each employee: 
SELECT e.*, COUNT(c.CourierID) AS TotalCouriersAssigned
FROM Employee e
LEFT JOIN Courier c ON e.EmployeeID = c.EmployeeID
GROUP BY e.EmployeeID;
-- 42. Retrieve a list of locations and the total payment amount received at each location: 
SELECT l.*, SUM(p.Amount) AS TotalPaymentAmount
FROM Location l
LEFT JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationID;
-- 43. Retrieve all couriers sent by the same sender (based on SenderName). 
SELECT *
FROM Courier
WHERE SenderName IN (SELECT SenderName FROM Courier GROUP BY SenderName HAVING COUNT(*) > 0);
-- 44. List all employees who share the same role. 
SELECT Role, GROUP_CONCAT(Name) AS EmployeesWithSameRole
FROM Employee
GROUP BY Role
HAVING COUNT(*) > 0;
-- 45. Retrieve all payments made for couriers sent from the same location. 
SELECT *
FROM Payment
WHERE CourierID IN (SELECT CourierID FROM Courier GROUP BY CourierID HAVING COUNT(DISTINCT LocationID) > 0);
-- 46. Retrieve all couriers sent from the same location (based on SenderAddress). 
SELECT *
FROM Courier
WHERE SenderAddress IN (SELECT SenderAddress FROM Courier GROUP BY SenderAddress HAVING COUNT(*) > 0);
--- 47. List employees and the number of couriers they have delivered: 
SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalCouriersDelivered
FROM Employee e
LEFT JOIN Courier c ON e.EmployeeID = c.EmployeeID
WHERE c.Status = 'Delivered'
GROUP BY e.EmployeeID;
--- 48. Find couriers that were paid an amount greater than the cost of their respective courier services
SELECT p.*, cs.Cost
FROM Payment p
JOIN CourierServices cs ON p.ServiceID = cs.ServiceID
WHERE p.Amount > cs.Cost;
-- 49. Find couriers that have a weight greater than the average weight of all couriers 
SELECT *
FROM Courier
WHERE Weight > (SELECT AVG(Weight) FROM Courier);
-- 50. Find the names of all employees who have a salary greater than the average salary: 
SELECT Name
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);
-- 51. Find the total cost of all courier services where the cost is less than the maximum cost 
SELECT SUM(Cost) AS TotalCost
FROM CourierServices
WHERE Cost < (SELECT MAX(Cost) FROM CourierServices);
-- 52. Find all couriers that have been paid for 
SELECT DISTINCT c.*
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID;
-- 53. Find the locations where the maximum payment amount was made 
SELECT l.*
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
WHERE Amount = (SELECT MAX(Amount) FROM Payment);
-- 54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender 
--  (e.g., 'SenderName'):
SELECT c.*
FROM Courier c
WHERE Weight > (SELECT MAX(Weight) FROM Courier WHERE SenderName = 'Sheela');
