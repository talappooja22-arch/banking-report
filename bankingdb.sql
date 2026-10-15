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
 
-- Lab 2

create table account (
accountID int,
accounttype varchar(20),
balance decimal(10,2)
);

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
    );

Create TABLE AccountBranches ( 
		AssignmentDate DATE
);

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

-- added dateofbirth col to customers table.
ALTER TABLE Customers add column dateofbirth date;

-- modify the datatype no. for phone.
alter table customers modify phone varchar(20);

-- added constraints account balance check.
alter table accounts add constraint chk_minbalance check (balance >= 1000);

show create table accounts;

-- delte table the drop.
drop table accountbranches;

-- add customerid column in account table
alter table accounts
add customerID int;

-- connect customers and accounts table using fk.
alter table accounts
add constraint fk_accounts_customers
foreign key(customerID)
references customers(customerID);

-- every customer must have a first name.
alter table customers modify firstname varchar(50) not null;

-- all cuastomer email is unique.
ALTER TABLE Customers ADD CONSTRAINT uq_Email UNIQUE (Email);

-- accounts coonect to branches
alter table branches add primary key (branchID);

alter table accounts
add branchID int;

alter table accounts 
add constraint  fk_accounts_branches
foreign key(branchID)
references branches(branchID);

-- transaction connect to accounts
alter table Account add primary key(accountID);

-- add column in transaction table
alter table transactions add accountID int;

-- coonect accounts to transaction table
alter table transactions
add constraint fk_transaction_account
foreign key (accountID)
references account(accountID);

-- add primary key
alter table customers add primary key (customerID);

-- add column in laons table
alter table loans add customerID int;

-- coonect customer to loans table
alter table loans
add constraint fk_loans_customer
foreign key(customerID)
references customers(customerID);


-- lab 3

-- customers table
insert into customers(customerID, firstName, lastName, Email, Phone, DateOfBirth)
values
(106 ,'rahul', 'shul@gmail.com','9876543210','1998-04-15'),
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

-- accounts table
insert into account(accountID, customerID, accounttype, balance)
values
(201,101,'savings',25000),
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

-- transction table
INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

-- branches table
INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');

-- loans table
INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);

select * from customers;

select * from account;

update customers set phone='9999999999' where customerID=101;

select * from customers where customerID=101;

update customers set email='rahul.sharma@gmail.com' where customerID=101;

update account set balance='30000' where accountID=201;

select * from account where accountID=201;

-- lab 3: deleting record and verify data
delete from transactions where transactionID=302;

select * from transactions;

delete from account where accountID=202;

select * from account;

-- lab 4

-- task 1 : review customers banking information
select * from customers;

select firstName, lastName, email, phone from customers;

select accountID,Accounttype,balance from account;

-- task 2: investigate specific customer transactions
select * from account where accounttype = 'savings';

select * from account where balance > 25000;

select * from transactions where amount between 5000 and 20000;

select * from customers where customerID in (101,102,103);

select * from customers where firstName like 'R%';

-- activity

select * from account where accounttype="current";

select * from account where balance < 15000;

select * from transactions where amount between 1000 and 10000;

select * from customers where customerID in (104,105);

select * from customers where lastname like 'S%';

-- Task 3: Generate Banking Reports for Management

select * from customers order by firstname asc;

select * from account order by balance desc;

select distinct accounttype from account;

select * from account order by balance desc limit 3;

select * from transactions limit 5 offset 2;

-- activity

select * from customers order by lastname asc;

select * from transactions order by amount desc;

select distinct transactiontype from transactions;

select * from transactions limit 4 offset 3;

-- Task 4: Identify Missing Banking Information

select * from customers where phone is null;

select * from customers where email is not null;

-- activity

-- Find customers without email addresses
select * from customers where email is null;

-- Display all accounts where balance information is available
select * from account where balance  is not null;

-- k 5: Categorize Customer Accounts Based on Balance

SELECT AccountID,
       Balance,
       CASE
           WHEN Balance >= 50000 THEN 'Premium Account'
           WHEN Balance >= 25000 THEN 'Standard Account'
           ELSE 'Basic Account'
       END AS AccountCategory
FROM Account;

-- activity
select amount,
case
when amount >= 8000 then 'high transction'
when amount >= 5000 then 'low transaction'
else 'low transaction'
end as 'amountcategory' from transactions;

-- Task 6: Analyze Customer Transactions Using Window Functions

select accountID, balance, rank() over(order by balance desc) as balancerank from account;

select transactionID, amount, sum(amount) over(order by transactiondate) as runningtotal from transactions;

select transactionID,amount, avg(amount) over() as averagetransaction from transactions;

-- activity





-- lab 5

SELECT *
FROM Customers
WHERE FirstName LIKE 'A%';