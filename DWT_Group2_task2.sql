CREATE TABLE Branch (
  Branch_ID INT PRIMARY KEY,
  Branch_Name VARCHAR(20) UNIQUE,
  Region VARCHAR(20)
);

CREATE TABLE Customer (
  Customer_ID INT PRIMARY KEY,
  First_name VARCHAR(20),
  Family_name VARCHAR(20),
  Address VARCHAR(200),
  Gender CHAR(1),
  Date_of_birth DATE,
  Age_Group VARCHAR(20)
);

CREATE TABLE Periods (
  Period_ID INT PRIMARY KEY,
  Day INT,
  Week INT,
  Month INT,
  Quarter INT,
  Year INT
);

CREATE TABLE Product (
  Product_ID INT PRIMARY KEY,
  Category VARCHAR(20)
);

CREATE TABLE Sales(
  Sale_ID INT PRIMARY KEY,
  Period_ID INT,
  Product_ID INT,
  Branch_ID INT,
  Customer_ID INT,
  Quantity DECIMAL,
  FOREIGN KEY (Period_ID) REFERENCES Periods(Period_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
  FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  UNIQUE (Period_ID, Product_ID, Branch_ID, Customer_ID)
);

