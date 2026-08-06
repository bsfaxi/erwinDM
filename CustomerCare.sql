
CREATE TABLE CareAgents
(
	AgentID int NOT NULL,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	Email VARCHAR(150) NOT NULL,
	Phone VARCHAR(30),
	Department VARCHAR(100),
	IsActive BOOLEAN DEFAULT 1 
);

ALTER TABLE CareAgents
	ADD CONSTRAINT XPKCareAgents PRIMARY KEY (AgentID);

CREATE TABLE CustomerFeedback2
(
	FeedbackID int NOT NULL,
	TicketID int,
	CustomerID int NOT NULL,
	AgentID int,
	Rating int,
	Comments VARCHAR(1000),
	FeedbackDate TIMESTAMP_NTZ DEFAULT  GetDate( ) 
);

ALTER TABLE CustomerFeedback2
	ADD CONSTRAINT XPKCustomerFeedback2 PRIMARY KEY (FeedbackID);

ALTER TABLE CustomerFeedback2 ADD CONSTRAINT Validation_Rule_304_285358781 CHECK (Rating BETWEEN 1 AND 5);

CREATE TABLE Customers
(
	CustomerID int NOT NULL,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	Email VARCHAR(150) NOT NULL,
	Phone VARCHAR(30),
	AddressLine1 VARCHAR(200),
	AddressLine2 VARCHAR(200),
	City VARCHAR(100),
	State VARCHAR(50),
	ZipCode VARCHAR(20),
	Country VARCHAR(50),
	CreatedAt TIMESTAMP_NTZ DEFAULT  GetDate( ) 
);

ALTER TABLE Customers
	ADD CONSTRAINT XPKCustomers PRIMARY KEY (CustomerID);

CREATE TABLE CustomerTier
(
	TierID int NOT NULL,
	TierName VARCHAR(50) NOT NULL,
	Description VARCHAR(255)
);

ALTER TABLE CustomerTier
	ADD CONSTRAINT XPKCustomerTier PRIMARY KEY (TierID);

CREATE TABLE CustomerTierAssignment
(
	AssignmentID int NOT NULL,
	CustomerID int NOT NULL,
	TierID int NOT NULL,
	AssignedDate TIMESTAMP_NTZ DEFAULT  GetDate( ) ,
	IsActive BOOLEAN DEFAULT 1 
);

ALTER TABLE CustomerTierAssignment
	ADD CONSTRAINT XPKCustomerTierAssignment PRIMARY KEY (AssignmentID);

CREATE TABLE SLA
(
	SLAID int NOT NULL,
	TierID int NOT NULL,
	CategoryID int NOT NULL,
	ResponseTimeHours int,
	ResolutionTimeHours int
);

ALTER TABLE SLA
	ADD CONSTRAINT XPKSLA PRIMARY KEY (SLAID);

CREATE TABLE SupportCategories
(
	CategoryID int NOT NULL,
	CategoryName VARCHAR(100) NOT NULL,
	Description VARCHAR(255)
);

ALTER TABLE SupportCategories
	ADD CONSTRAINT XPKSupportCategories PRIMARY KEY (CategoryID);

CREATE TABLE SupportTickets
(
	TicketID int NOT NULL,
	CustomerID int NOT NULL,
	AgentID int,
	CategoryID int,
	Status VARCHAR(50) NOT NULL,
	Priority VARCHAR(20) NOT NULL,
	Subject VARCHAR(200) NOT NULL,
	Description STRING,
	CreatedAt TIMESTAMP_NTZ DEFAULT  GetDate( ) ,
	ClosedAt TIMESTAMP_NTZ
);

ALTER TABLE SupportTickets
	ADD CONSTRAINT XPKSupportTickets PRIMARY KEY (TicketID);

CREATE TABLE TicketUpdates
(
	UpdateID int NOT NULL,
	TicketID int NOT NULL,
	AgentID int,
	UpdateStatus VARCHAR(50),
	UpdateDescription STRING,
	UpdatedAt TIMESTAMP_NTZ DEFAULT  GetDate( ) 
);

ALTER TABLE TicketUpdates
	ADD CONSTRAINT XPKTicketUpdates PRIMARY KEY (UpdateID);

ALTER TABLE CustomerFeedback2
	ADD CONSTRAINT R_8 FOREIGN KEY (TicketID) REFERENCES SupportTickets (TicketID);

ALTER TABLE CustomerFeedback2
	ADD CONSTRAINT R_9 FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);

ALTER TABLE CustomerFeedback2
	ADD CONSTRAINT R_10 FOREIGN KEY (AgentID) REFERENCES CareAgents (AgentID);

ALTER TABLE CustomerTierAssignment
	ADD CONSTRAINT R_1 FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);

ALTER TABLE CustomerTierAssignment
	ADD CONSTRAINT R_2 FOREIGN KEY (TierID) REFERENCES CustomerTier (TierID);

ALTER TABLE SLA
	ADD CONSTRAINT R_11 FOREIGN KEY (TierID) REFERENCES CustomerTier (TierID);

ALTER TABLE SLA
	ADD CONSTRAINT R_12 FOREIGN KEY (CategoryID) REFERENCES SupportCategories (CategoryID);

ALTER TABLE SupportTickets
	ADD CONSTRAINT R_3 FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);

ALTER TABLE SupportTickets
	ADD CONSTRAINT R_4 FOREIGN KEY (AgentID) REFERENCES CareAgents (AgentID);

ALTER TABLE SupportTickets
	ADD CONSTRAINT R_5 FOREIGN KEY (CategoryID) REFERENCES SupportCategories (CategoryID);

ALTER TABLE TicketUpdates
	ADD CONSTRAINT R_6 FOREIGN KEY (TicketID) REFERENCES SupportTickets (TicketID);

ALTER TABLE TicketUpdates
	ADD CONSTRAINT R_7 FOREIGN KEY (AgentID) REFERENCES CareAgents (AgentID);
