CREATE DATABASE LAPTOP_ORDERING_AND_SELLING_DATABASE_SYSTEM;

USE LAPTOP_ORDERING_AND_SELLING_DATABASE_SYSTEM;

--------------------------------------------------------------------------
CREATE TABLE Laptop (
    Laptop_ID int NOT NULL,  
    Brand varchar(15) NOT NULL,
    Model varchar(25) NOT NULL,
    Price decimal(15,2) NOT NULL,
    Ram char(6) NOT NULL,
    Processor varchar(25) NOT NULL,
    Storage varchar(8) NOT NULL,
    PRIMARY KEY (Laptop_ID)
);

--------------------------------------------------------------------------

CREATE TABLE Warranty (
    Warranty_ID INT AUTO_INCREMENT PRIMARY KEY,
    Laptop_ID INT NOT NULL,
    Starting_date DATE,
    End_date DATE,
    Duration INT NOT NULL
    
);

ALTER TABLE Warranty
ADD CONSTRAINT FK_Laptop_ID2
FOREIGN KEY(Laptop_ID) REFERENCES Laptop(Laptop_ID) ON DELETE cascade on update cascade;

-------------------------------------------------------------------------------------------------------

Create table Customer (
	Customer_ID int not null,
    First_name varchar(20) not null,
    Last_name varchar(20),
    Address_Line1 varchar(20) not null,
	Address_Line2 varchar(20),
    City varchar(20),
	Email varchar(30) not null, 
    Phone_no varchar(14) not null,
    primary key (Customer_ID)
);

-------------------------------------------------------------------------------------------------------

Create table Payment (
	Payment_ID int not null,
    Payment_date date,
    Amount decimal(8,2) not null,
    Payment_method varchar(10) not null,
	Customer_id int not null,
    primary key (Payment_ID)
);

ALTER TABLE Payment
ADD CONSTRAINT FK_customer_ID
FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) on delete cascade on update cascade;

-------------------------------------------------------------------------------------------------------

Create table Reviews (
	Review_ID int not null,
	Comments varchar(256),
    Rating int,
    Review_date date,
    Laptop_ID int not null,
    Customer_ID int not null,
    
    primary key (Review_ID)
);

ALTER TABLE reviews
ADD CONSTRAINT fk_laptopid
FOREIGN KEY (Laptop_id) REFERENCES Laptop (Laptop_id) ON DELETE cascade on update cascade,
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)REFERENCES customer(customer_id) ON delete cascade on update cascade;

-------------------------------------------------------------------------------------------------------

Create table Seller (
	laptop_ID int not null,
    seller_ID int not null,
	primary key (laptop_ID)
);

ALTER TABLE Seller
ADD CONSTRAINT fk_seller
FOREIGN KEY (Laptop_id) REFERENCES Laptop (Laptop_id) ON DELETE cascade on update cascade;   
alter table Seller add constraint uniq unique(Seller_ID);
-------------------------------------------------------------------------------------------------------

Create table Seller_details (
	Seller_ID int not null,
    First_Name varchar(30),
    Last_Name varchar(30),
    Company varchar(30) not null,
    Email varchar(30) not null,
    Contact_no varchar(14) not null,
	primary key (Seller_ID)
 );

alter table Seller_details
add constraint fk_sellerdetails
FOREIGN KEY (Seller_ID) REFERENCES Seller(seller_ID) on delete cascade on update cascade;

-------------------------------------------------------------------------------------------------------

CREATE TABLE Orders (
	Order_ID varchar(10),
	Quantity int,
    Customer_ID int not null,
    Laptop_ID int,
    primary key (Order_ID)
);


ALTER TABLE Orders
ADD CONSTRAINT FK_customerID_ord
FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE cascade on update cascade,
ADD CONSTRAINT FK_order_idinvo
FOREIGN KEY(Laptop_ID) REFERENCES Laptop(Laptop_ID) ON DELETE cascade on update cascade;

-------------------------------------------------------------------------------------------------------

CREATE TABLE Invoice (
	Invoice_ID bigint not null,
    Total_Amount decimal(8,2) not null,
    Invoice_Date date,
    Customer_ID int not null,
    Order_ID varchar(10),
    primary key (invoice_ID)
);

ALTER TABLE Invoice
ADD CONSTRAINT FK_customerIDinvo
FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE no action on update cascade,

ADD CONSTRAINT FK_order_idinvoice
FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) ON DELETE cascade on update cascade;

-------------------------------------------------------------------------------------------------------

CREATE TABLE Shipping (
	Shipping_ID int,
    Order_ID varchar(10),
    Shipping_Company varchar(20),
    Shipping_date date,
    primary key (shipping_ID)
);
ALTER TABLE shipping
ADD CONSTRAINT FK_shipping
FOREIGN KEY(Order_ID) REFERENCES Orders(order_ID) ON DELETE cascade on update cascade;


-------------------------------------------------------------------------------------------------------

CREATE TABLE Shipping_details (
	Shipping_ID int,
    tracking_no varchar(15) not null,
    Shipping_type varchar(20) not null,
    Country varchar(20) not null,
    House_no varchar(20),
    street_name varchar(30),
    city varchar(20),
    state varchar (20)
	
);
alter table Shipping_details  add constraint newname  unique(Shipping_ID);


ALTER TABLE Shipping_details
ADD CONSTRAINT FK_shippingdet
FOREIGN KEY(Shipping_ID) REFERENCES Shipping(Shipping_ID) ON DELETE cascade on update cascade;

-----------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------/*insertion*/-----------------------------------------------------

INSERT INTO Laptop (Laptop_ID, Brand, Model, Price,Ram,Processor,Storage) 
VALUES (21001, 'Asus', 'ROG Zephyrus', 455000.00,'8GB','Intel i9 9000','1TB');

INSERT INTO Laptop (Laptop_ID, Brand, Model, Price,Ram,Processor,Storage)
VALUES (21002, 'Dell', 'Inspiron 3532', 255000.00,'8GB','Intel i9 9000','1TB'),
       (21003, 'Dell', 'Inspiron 5532', 305000.00,'8GB','Intel i9 9000','1TB'),
       (21004, 'Huawei', 'Matebook X', 405000.00,'8GB','Intel i9 9000','1TB'),
       (21005, 'Acer', 'Nitro 15', 335000.00,'8GB','Intel i9 9000','1TB'),
       (21006, 'MSI', 'Stealth 15', 505000.00,'8GB','Intel i9 9000','1TB');


----------------------------------------------------------------------------------------------------------------------------
INSERT INTO Warranty ( Warranty_ID,Laptop_ID, Starting_date, End_date, Duration)
VALUES
    ( 1,21001, '2023-01-01', '2023-12-31', 12),
    (2, 21002, '2023-02-15', '2025-02-14', 24),
    (3, 21003, '2023-03-10', '2026-03-09', 36),
    (4, 21004, '2023-04-20', '2024-04-19', 12),
    (5,21005, '2023-05-05', '2025-05-04', 24),
    ( 6,21006, '2023-06-30', '2026-06-29', 36);

------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Customer (Customer_ID, First_name, Last_name, Address_Line1, Address_Line2, City, Email, Phone_no)
VALUES
    (1, 'John', 'Doe', '123 Main Street', 'Apt 4B', 'New York', 'john@example.com', '555-123-4567'),
    (2, 'Jane', 'Smith', '456 Elm St', NULL, 'Los Angeles', 'jane@example.com', '555-987-6543'),
    (3, 'Bob', 'Johnson', '789 Oak St', NULL, 'Chicago', 'bob@example.com', '555-567-8901'),
    (4, 'Alice', 'Brown', '321 Elm St', 'Apt 2C', 'San Francisco', 'alice@example.com', '555-789-0123'),
    (5, 'Eva', 'Williams', '555 Pine St', NULL, 'Houston', 'eva@example.com', '555-234-5678'),
    (6, 'David', 'Lee', '888 Oak St', 'Apt 3D', 'Miami', 'david@example.com', '555-876-5432');

---------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Orders (Order_ID, Quantity, Customer_ID, Laptop_ID)
VALUES
    ('ORDER001', 2, 1, 21001),
    ('ORDER002', 1, 2, 21002),
    ('ORDER003', 3, 3, 21003),
    ('ORDER004', 1,4, 21004),
    ('ORDER005', 2,5, 21005),
    ('ORDER006', 1, 6, 21006);
-------------------------------------------------------------------------------------------------------
INSERT INTO Payment (Payment_ID, Payment_date, Amount, Payment_method, Customer_id)
VALUES
    (8001, '2023-09-04', 456600.00, 'Credit', 1),
	(8002, '2023-09-05', 355575.00, 'Cash', 2),
    (8003, '2023-09-06', 255120.00, 'Debit', 3),
    (8004, '2023-09-07', 175550.00, 'Credit', 4),
    (8005, '2023-09-08', 195000.00, 'Cash', 5),
    (8006, '2023-09-09', 600000.00, 'Debit', 6);
    
--------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Reviews (Review_ID, Comments, Rating, Review_date, Laptop_ID, Customer_ID)
VALUES 
	(101, 'Great laptop', 5, '2023-09-01', 21001, 1),
    (103, 'Excellent build quality', 4, '2023-09-03', 21003, 2),
    (104, 'Fast and powerful', 5, '2023-09-04', 21004, 4),
    (105, 'Poor battery life', 2, '2023-09-05', 21005, 3),
    (106, 'Good value for the price', 4, '2023-09-06', 21006, 5);

-------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Seller (Laptop_ID,Seller_ID)
VALUES 
	(21001,21),
    (21003,22),
    (21004,23),
    (21005,24),
    (21006,25);
-------------------------------------------------------------------------------------------------------------------------------   
Insert into seller_details (Seller_ID, First_Name,Last_Name,Company,Email,Contact_no)
values
    (21, 'Adam', 'Hunt', 'ASB Inc.', 'Adm@yahoo.com', 95876545421),
    (22, 'Chalri', 'Puth', 'CIB Corporation', 'Charlie@gmail.com', 94786754344),
    (23, 'Sumudu', 'Nimal', 'SML Ltd.', 'Sumudu@hotmail.com', 94765654666),
    (24, 'Sarah', 'Jade', 'HTML Industries', 'sarah@zapmail.com', 94775446544);
-------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Invoice (Invoice_ID, Total_Amount, Invoice_Date, Customer_ID, Order_ID)
VALUES
    (9001, 913200.00, '2023-09-04', 1, 'ORDER001'),
    (9002, 255000.00, '2023-09-05', 6, 'ORDER002'),
    (9003, 915000.00, '2023-09-06', 3, 'ORDER003'),
    (9004, 175550.00, '2023-09-07', 4, 'ORDER004'),
    (9005, 335000.00, '2023-09-08', 5, 'ORDER005'),
    (9006, 505000.00, '2023-09-09', 2, 'ORDER006');

--------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Shipping (Shipping_ID, Order_ID, Shipping_Company, Shipping_date)
VALUES
    (1, 'ORDER001', 'Daraz', '2023-09-05'),
    (2, 'ORDER002', 'Ali Express', '2023-09-06'),
    (3, 'ORDER003', 'Ali Express', '2023-09-07'),
    (4, 'ORDER004', 'Amazon', '2023-09-08'),
    (5, 'ORDER005', 'Ali baba', '2023-09-09'),
    (6, 'ORDER006', 'Ebay', '2023-09-10');

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Shipping_details (Shipping_ID, tracking_no, Shipping_type, Country, House_no, street_name, city, state)
VALUES
    (1, 'TRK001', 'Standard', 'UK', 'G14', 'Direct Street', 'London', 'LO'),
    (2, 'TRK002', 'Express', 'Germany', '126', 'Elm St', 'Berlin', 'BL'),
    (3, 'TRK003', 'Standard', 'USA', '789', 'Oakshid Street', 'Boston', 'BS'),
    (4, 'TRK004', 'Express', 'USA', '151', 'Pin street', 'San Francisco', 'SF'),
    (5, 'TRK005', 'Standard', 'Sri Lanka', '242', 'Pettah', 'Colombo', 'CO'),
    (6, 'TRK006', 'Express', 'Italy', '555', 'Round st', 'Seattle', 'SE');

------------------------------/*update*/---------------------------------------------------------------------------------------
UPDATE Orders
SET Quantity = 4
WHERE Order_ID = 'ORDER001';

-------------------------------------------------------------------------------------
UPDATE Laptop
SET Price = 465000.00
WHERE Laptop_ID = 21002;


UPDATE Laptop
SET Ram = '16GB'
WHERE Laptop_ID = 21001;

-------------------------------------------------------------------------------------

UPDATE Customer
SET Email = 'pawan@gmail.com'
WHERE Customer_ID = 1002;

UPDATE Customer
SET First_name = 'kamal'
WHERE Customer_ID = 1003;
-------------------------------------------------------------------------------------
UPDATE Payment
SET Amount = 500000.00
WHERE Payment_ID = 8002;


UPDATE Payment
SET Payment_method = 'Cash'
WHERE Payment_ID = 8001;

-------------------------------------------------------------------------------------

UPDATE Reviews
SET Rating = 3
WHERE Review_ID = 101;

UPDATE Reviews
SET Comments = 'Really dissapointed'
WHERE Review_ID = 106;
-------------------------------------------------------------------------------------

UPDATE Seller
SET Seller_ID = 26
WHERE Laptop_ID = 21004;


UPDATE Seller
SET Seller_ID = 27
WHERE Laptop_ID = 21005;

-------------------------------------------------------------------------------------

UPDATE Seller_details
SET Email = 'henry123@gmail.com'
WHERE Seller_ID = 21;


UPDATE Seller_details
SET Contact_no = 94725654854
WHERE Seller_ID = 22;
-------------------------------------------------------------------------------------

UPDATE Invoice
SET Total_Amount = 1500.00
WHERE Invoice_ID = 9001;

UPDATE Invoice
SET Invoice_Date = '2023-09-06'
WHERE Invoice_ID = 9003;

-------------------------------------------------------------------------------------
UPDATE Shipping
SET Shipping_Company = 'Fast X'
WHERE Shipping_ID = 3001;

UPDATE Shipping
SET Shipping_date = '2023-09-25'
WHERE Shipping_ID = 3003;
------------------------------------------------------------------------------------

UPDATE Shipping_details
SET tracking_no = 'TRK109'
WHERE Shipping_ID = 3001;

UPDATE Shipping_details
SET Shipping_type = 'Express'
WHERE Shipping_ID = 3004;

---------------------------------/*Deletion*/------------------------------------------------

DELETE FROM Laptop
WHERE Laptop_ID = 21001;


DELETE FROM Customer
WHERE Customer_ID = 1001;


DELETE FROM Payment
WHERE Payment_ID = 8001;


DELETE FROM Reviews
WHERE Review_ID = 104;


DELETE FROM Seller
WHERE Laptop_ID = 21006;


DELETE FROM Seller_details
WHERE Seller_ID = 23;


DELETE FROM Orders
WHERE Order_ID = 'ORDER002';


DELETE FROM Invoice
WHERE Invoice_ID = 9002;


DELETE FROM Shipping
WHERE Shipping_ID = 3002;


DELETE FROM Shipping_details
WHERE Shipping_ID = 3002;



#------------------------------------------------------------------------------------------/*Transaction*/--------------------------------------------------------------------------------------------------------------------------------


select * from laptop;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select Payment_ID,amount,Payment_method from Payment;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from Customer CROSS JOIN Orders;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create view Delllaptops as select Laptop_ID,Model,price from Laptop where Brand = 'Dell';
explain (select*from Delllaptops);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select Review_ID , Comments as Review, Rating from Reviews;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select Brand,AVG(Price) as Average_Price from Laptop group by Brand;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select First_Name,Last_Name,Email from Customer where Email like '%gmail.com';
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select First_Name,Email from Customer where Last_Name = 'Doe'and Phone_No='555-123-4567';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT brand,model,price from Laptop order by price asc;
 
CREATE VIEW ROJ AS SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no 
FROM Shipping_details AS SD RIGHT JOIN Customer AS C ON SD.Shipping_ID = C.Customer_ID;
select * from ROJ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   
CREATE VIEW LOJ AS SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city AS Shipping_City, SD.state,C.Customer_ID,C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no
FROM Shipping_details AS SD LEFT JOIN Customer AS C ON SD.Shipping_ID = C.Customer_ID;
select * from LOJ;     

   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      
CREATE VIEW NJ AS SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no 
FROM Shipping_details AS SD NATURAL JOIN Customer AS C;
select * from NJ;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW OU AS SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no 
FROM Shipping_details AS SD LEFT JOIN Customer AS C ON SD.Shipping_ID = C.Customer_ID UNION SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city
AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no FROM Shipping_details AS SD RIGHT JOIN Customer AS C ON SD.Shipping_ID = C.Customer_ID;
sELECT * FROM OU;

           
select o.city from customer as o where o.Address_Line2='NULL' UNION select l.City from Shipping_details as l;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


 SELECT L.Laptop_ID,L.Brand, L.Model,L.Price, W.Starting_date,W.End_date,W.Duration FROM Laptop AS L INNER JOIN  Warranty AS W ON L.Laptop_ID = W.Laptop_ID where L.Price>350000;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Select Model,Ram from Laptop where Brand='Dell' AND Storage = '1TB';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT W.Laptop_ID, W.Starting_date, W.End_date, W.Duration FROM Warranty AS W LEFT JOIN Laptop AS L ON W.Laptop_ID = L.Laptop_ID AND  W.Duration = '12' ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT W1.Laptop_ID,W1.Duration,W1.End_Date FROM Warranty AS W1 
WHERE W1.Warranty_ID IN (SELECT W2.Warranty_ID FROM Warranty AS W2  WHERE W2.Laptop_ID 
IN (SELECT L.Laptop_ID FROM Laptop AS L  WHERE L.Laptop_ID 
NOT IN (SELECT DISTINCT L2.Laptop_ID FROM Laptop AS L2 LEFT JOIN Warranty AS W3 ON L2.Laptop_ID = W3.Laptop_ID WHERE W3.Warranty_ID <> W1.Warranty_ID OR W3.Warranty_ID IS NULL)));
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE VIEW CustomerOrders AS SELECT Customer.Customer_ID, Orders.Customer_ID AS Order_Customer_ID FROM Customer
INNER JOIN Orders ON Customer.Customer_ID = Orders.Customer_ID;

SELECT First_name, Last_name
FROM Customer
WHERE Customer_ID IN (SELECT Order_Customer_ID FROM CustomerOrders);        
        
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
          
   
           
#----------------------------------------------------------------------------------------------------------------------/*TUNINIG*/--------------------------------------------------------------------------------------------------------
   
----------------------------#tuning difference operation----------------------------------\

CREATE INDEX idxx_warranty_duration ON Warranty (Duration);
explain SELECT W.Laptop_ID, W.Starting_date, W.End_date, W.Duration FROM Warranty AS W LEFT JOIN Laptop AS L ON W.Laptop_ID = L.Laptop_ID AND  W.Duration = '12' ;


-------------------------------#tuning union operation-------------------------------------

CREATE INDEX idx_customer_address_line2 ON customer (Address_Line2);
CREATE INDEX idx_shipping_details_city ON Shipping_details (City);
explain select o.city from customer as o where o.Address_Line2='NULL' UNION select l.City from Shipping_details as l;

----------------------------------#tuning intersection---------------------------------------

CREATE INDEX idx_laptop_Storage ON Laptop (storage);
explain(Select Model,Ram from Laptop where Brand='Dell' AND Storage = '1TB');


---------------------------------------------#tuning inner join------------------------------------------

CREATE INDEX idx_laptop_price ON Laptop (Price);
explain SELECT L.Laptop_ID,L.Brand, L.Model,L.Price, W.Starting_date,W.End_date,W.Duration FROM Laptop AS L INNER JOIN  Warranty AS W ON L.Laptop_ID = W.Laptop_ID where L.Price>350000;


---------------------------------------------------------------------------------------------------------#tuning NJ---------------------------------------------------------------------------------------------------------

CREATE INDEX inx_shipping_id ON Shipping_details (Tracking_No);

CREATE VIEW NJ_Tuned AS
SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no
FROM Shipping_details AS SD NATURAL JOIN Customer AS C;

explain(SELECT * FROM NJ_Tuned);


---------------------------------------------------#tuning nested queries03-----------------------------------------------------------------------------------------------------------


explain SELECT DISTINCT W1.Laptop_ID,W1.Duration,W1.End_Date FROM Warranty AS W1 
WHERE W1.Warranty_ID IN (SELECT W2.Warranty_ID FROM Warranty AS W2  WHERE W2.Laptop_ID 
IN (SELECT L.Laptop_ID FROM Laptop AS L  WHERE L.Laptop_ID 
NOT IN (SELECT DISTINCT L2.Laptop_ID FROM Laptop AS L2 LEFT JOIN Warranty AS W3 ON L2.Laptop_ID = W3.Laptop_ID WHERE W3.Warranty_ID <> W1.Warranty_ID OR W3.Warranty_ID IS NULL)));

    

-------------------------------------------------------------------#tuning nested queries01--------------------------------------------------------------------------------------------------------------------------------------------------------------------


explain SELECT DISTINCT C.First_name, C.Last_name
FROM Customer AS C
WHERE EXISTS (
    SELECT 1
    FROM Orders AS O
    WHERE C.Customer_ID = O.Customer_ID
);


-------------------------------------------------------------------#tuning nested queries02--------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE INDEX idx1_shipping_id ON Shipping_details (Shipping_ID);

CREATE VIEW LOJ_Tuned AS
SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name,
       SD.city AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name,
       C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no
FROM Shipping_details AS SD
LEFT JOIN Customer AS C ON SD.Shipping_ID = C.Customer_ID;

explain SELECT * FROM LOJ_Tuned;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE INDEX ix_brand ON Laptop (Brand);

CREATE VIEW Delllaptop_Tuned AS SELECT Laptop_ID, Model, Price FROM Laptop WHERE Brand = 'Dell';

SELECT * FROM Delllaptop_Tuned;



---------------------------------------------------------------------------------------------------------#tuning ROJ---------------------------------------------------------------------------------------------------------

CREATE INDEX idx_customer_id ON Customer (Customer_ID);

CREATE VIEW ROJ_Tuned AS
SELECT SD.Shipping_ID, SD.tracking_no, SD.Shipping_type, SD.Country, SD.House_no, SD.street_name, SD.city AS Shipping_City, SD.state, C.Customer_ID, C.First_name, C.Last_name, C.Address_Line1, C.Address_Line2, C.Email, C.Phone_no
FROM Shipping_details AS SD
RIGHT JOIN Customer AS C ON SD.Shipping_ID = C.Customer_ID;

explain SELECT * FROM ROJ_Tuned;




