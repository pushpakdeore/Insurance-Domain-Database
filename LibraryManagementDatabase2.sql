create database insurance;
use insurance;

create table Customers(
customer_id int primary key,
first_name varchar(50),
last_name varchar(50),
date_of_birth date,
gender varchar(50),
contact_number varchar(15),
email varchar(20),
address varchar(200));

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, gender, contact_number, email, address) 
VALUES 
(1, 'John', 'Doe', '1985-01-15', 'Male', '1234567890', 'john.doe@example.com', '123 Main St'),
(2, 'Jane', 'Smith', '1985-01-15', 'Female', '0987654321', 'jane.smi@example.com', '456 Oak Ave'),
(3, 'Mike', 'Johnson', '1978-11-30', 'Male', '9876543210', 'mike.jnn@example.com', '789 Pine Rd'),
(4, 'Alice', 'Brown', '1982-07-18', 'Female', '8765432109', 'alice.bo@example.com', '321 Cedar St'),
(5, 'David', 'Lee', '1995-03-10', 'Male', '7654321098', 'dad.lee@xample.com', '654 Birch Ln');
select * from customers;


create table Policies(
 policy_id INT PRIMARY KEY,
    policy_name VARCHAR(100),
    policy_type VARCHAR(50),
    coverage_details TEXT,
    premium DECIMAL(10, 2),
    start_date DATE,
    end_date DATE
);
INSERT INTO Policies (policy_id, policy_name, policy_type, coverage_details, premium, start_date, end_date)
VALUES 
(1, 'Health Basic', 'Health', 'Covers hospital bills up to $10,000', 500.00, '2024-01-01', '2025-01-01'),
(2, 'Auto Safe', 'Auto', 'Covers car accidents up to $15,000', 300.00, '2024-02-01', '2025-02-01'),
(3, 'Life Secure', 'Life', 'Covers life insurance up to $100,000', 700.00, '2024-03-01', '2025-03-01'),
(4, 'Home Protect', 'Home', 'Covers home damages up to $50,000', 400.00, '2024-04-01', '2025-04-01'),
(5, 'Travel Shield', 'Travel', 'Covers travel incidents up to $5,000', 200.00, '2024-05-01', '2025-05-01');
select * from policies;


create table Claims(
claim_id INT primary key,
    claim_date DATE,
    claim_amount DECIMAL(10, 2),
    approved_amount DECIMAL(10, 2),
    claim_status VARCHAR(20),
    policy_id INT,
    customer_id INT,
    foreign key (policy_id) references Policies(policy_id),
    foreign key (customer_id) references  Customers(customer_id)
);
INSERT INTO Claims (claim_id, claim_date, claim_amount, approved_amount, claim_status, policy_id, customer_id)
VALUES 
(1, '2024-06-15', 2000.00, 1500.00, 'Approved', 1, 1),
(2, '2024-07-20', 12000.00, 10000.00, 'Approved', 2, 2),
(3, '2024-08-10', 8000.00, 8000.00, 'Approved', 3, 3),
(4, '2024-09-05', 5000.00, 4000.00, 'Denied', 4, 4),
(5, '2024-09-25', 300.00, 300.00, 'Approved', 5, 5);
select*from claims;


create table Agents(
agent_id INT primary key,
first_name VARCHAR(50),
last_name VARCHAR(50),
contact_number VARCHAR(15),
email VARCHAR(100),
hire_date DATE
);
INSERT INTO Agents (agent_id, first_name, last_name, contact_number, email, hire_date)
VALUES 
(1, 'Emma', 'Wilson', '1234567899', 'emma.wilson@example.com', '2023-01-10'),
(2, 'Liam', 'Miller', '2345678901', 'liam.miller@example.com', '2023-02-15'),
(3, 'Olivia', 'Davis', '3456789012', 'olivia.davis@example.com', '2023-03-20'),
(4, 'Noah', 'Anderson', '4567890123', 'noah.anderson@example.com', '2023-04-25'),
(5, 'Sophia', 'Taylor', '5678901234', 'sophia.taylor@example.com', '2023-05-30');
select * from Agents;


create table Police_Assignments(
assignment_id int primary key,
customer_id int ,
policy_id int ,
start_date date,
end_date date,
foreign key (customer_id) references Customers(customer_id)
);
INSERT INTO Police_Assignments (assignment_id, customer_id, policy_id, start_date, end_date)
VALUES 
(1, 1, 1, '2024-01-01', '2025-01-01'),
(2, 2, 2, '2024-02-01', '2025-02-01'),
(3, 3, 3, '2024-03-01', '2025-03-01'),
(4, 4, 4, '2024-04-01', '2025-04-01'),
(5, 5, 5, '2024-05-01', '2025-05-01');
select*from Police_Assignments;

create table claim_Processing(
processing_id int primary key,
claim_id int,
processing_date date,
payment_amount decimal(10,2),
payment_date date,
foreign key (claim_id) references Claims(claim_id)) ;
INSERT INTO claim_Processing (processing_id, claim_id, processing_date, payment_amount, payment_date)
VALUES 
(1, 1, '2024-06-20', 1500.00, '2024-06-30'),
(2, 2, '2024-07-25', 10000.00, '2024-08-05'),
(3, 3, '2024-08-15', 8000.00, '2024-08-25'),
(4, 4, '2024-09-10', 0.00, NULL),
(5, 5, '2024-09-30', 300.00, '2024-10-05');
select*from claim_Processing;

-- DDL Queries
-- 1. Add a new column to the agents table
alter table agents add column agent_age int;

-- 2. Rename the policy_name column in the policies table to policy_title:
alter table policies rename column policy_name to policy_title;

-- 3. Drop the address column from the customers table:
alter table customers drop column address;

-- DML Queries
-- 1. Update a policy's premium amount:
update Policies set premium =premium+10;

-- 2. Delete a specific claim:
delete from Claims where claim_id =6;

-- 3. Insert a new policy assignment:
INSERT INTO Police_Assignments (assignment_id, customer_id, policy_id, start_date, end_date)
VALUE
(7, 6, 8, '2024-01-01', '2025-01-01');


-- 1. Retrieve all customers with their assigned policies and agents
SELECT c.customer_id, c.first_name, c.last_name, p.policy_title, a.first_name AS agent_first_name, a.last_name AS agent_last_name
FROM Customers c
JOIN PolicyAssignments pa ON c.customer_id = pa.customer_id
JOIN Policies p ON pa.policy_id = p.policy_id
JOIN Agents a ON pa.policy_id = p.policy_id;


-- 2. Find all claims and the associated policy details
SELECT cl.claim_id, cl.claim_date, cl.claim_amount, p.policy_title, p.policy_type
FROM Claims cl
JOIN Policies p ON cl.policy_id = p.policy_id;

-- 33. List all claims along with the customer details
select  cl.claim_id, cl.claim_date, cl.claim_amount, c.first_name, c.last_name, c.contact_number
from Claims cl
join Customers c
on cl.customer_id = c.customer_id;

-- 4. Get the total claim amount and number of claims per policy type

select p.policy_type, COUNT(cl.claim_id) AS total_claims, SUM(cl.claim_amount) AS total_claim_amount
FROM Claims cl
JOIN Policies p ON cl.policy_id = p.policy_id
GROUP BY p.policy_type;

-- 5. Find the most recent claim for each customer:
SELECT c.customer_id, c.first_name, c.last_name, MAX(cl.claim_date) AS recent_claim_date
FROM Customers c
JOIN Claims cl ON c.customer_id = cl.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


















