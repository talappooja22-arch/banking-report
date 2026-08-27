create database bankingdb;
use bankingdb;

create Table Customers(
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
Phone VARCHAR(15),
AccountCreationDate date
);

DESCRIBE Customers;
