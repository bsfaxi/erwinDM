
CREATE TABLE Auth
(
	Auth_Id              CHAR(9)  NOT NULL ,
	Auth_Lst_Nam         VARCHAR2(25)  NOT NULL ,
	Auth_Frst_Nam        VARCHAR2(15)  NULL ,
	Auth_Phn_Nbr         INTEGER  NULL ,
	Auth_Addr            VARCHAR2(25)  NULL ,
	Auth_Cty             VARCHAR2(20)  NULL ,
	Auth_St              VARCHAR(4)  NOT NULL ,
	Auth_Zip_Cd          VARCHAR(9)  NULL ,
	Cntrct               SMALLINT  NULL 
);

CREATE UNIQUE INDEX UPKCL_auidind ON Auth
(Author_Identification   ASC);

ALTER TABLE Auth
	ADD CONSTRAINT  UPKCL_auidind PRIMARY KEY (Author_Identification);

CREATE INDEX aunmind ON Auth
(Author_Last_Name   ASC,Author_First_Name   ASC);

CREATE TABLE Publshr
(
	Publshr_Id           CHAR(9)  NOT NULL ,
	Publshr_Nam          VARCHAR2(40)  NULL ,
	Publshr_Addr         VARCHAR2(20)  NULL ,
	Publshr_Cty          VARCHAR2(25)  NULL ,
	Publshr_St           VARCHAR(4)  DEFAULT 'USA'  NOT NULL ,
	Publshr_Zip_Cd       VARCHAR(9)  NULL 
);

CREATE UNIQUE INDEX UPKCL_pubind ON Publshr
(Publisher_Identification   ASC);

ALTER TABLE Publshr
	ADD CONSTRAINT  UPKCL_pubind PRIMARY KEY (Publisher_Identification);

CREATE TABLE Publshr_Logo
(
	Publshr_Id           CHAR(9)  NOT NULL ,
	Publshr_Logo         character(500)  NULL ,
	Publshr_Publc_Rel_Inf VARCHAR2(200)  NULL 
);

CREATE UNIQUE INDEX UPKCL_pubinfo ON Publshr_Logo
(Publisher_Identification   ASC);

ALTER TABLE Publshr_Logo
	ADD CONSTRAINT  UPKCL_pubinfo PRIMARY KEY (Publisher_Identification);

CREATE TABLE Book
(
	Book_Id              CHAR(9)  NOT NULL ,
	Book_Nam             VARCHAR2(80)  NULL ,
	Book_Typ             CHAR(12)  DEFAULT 'UNDECIDED'  NULL ,
	Publshr_Id           CHAR(9)  NULL ,
	MRSP_Prc             DECIMAL(19,4)  NULL ,
	Advnc                DECIMAL(19,4)  NULL ,
	Rylty_Trm            INTEGER  NULL ,
	Book_Note            VARCHAR2(200)  NULL ,
	Publctn_Dt           DATE  DEFAULT SYSDATE  NULL 
);

CREATE UNIQUE INDEX UPKCL_titleidind ON Book
(Book_Identification   ASC);

ALTER TABLE Book
	ADD CONSTRAINT  UPKCL_titleidind PRIMARY KEY (Book_Identification);

CREATE INDEX titleind ON Book
(Book_Name   ASC);

CREATE TABLE Book_YTD_Sls
(
	Book_Id              CHAR(9)  NOT NULL ,
	Yr_To_Dt_Sls_Amt     DECIMAL(10,2)  NULL ,
	Yr_To_Dt_Sls_Dt      DATE  DEFAULT SYSDATE  NULL 
);

CREATE UNIQUE INDEX XPKBook_YTD_Sales ON Book_YTD_Sls
(Book_Identification   ASC);

ALTER TABLE Book_YTD_Sls
	ADD CONSTRAINT  XPKBook_YTD_Sales PRIMARY KEY (Book_Identification);

CREATE TABLE BookAuth
(
	Auth_Id              CHAR(9)  NOT NULL ,
	Book_Id              CHAR(9)  NOT NULL 
);

CREATE UNIQUE INDEX UPKCL_taind ON BookAuth
(Author_Identification   ASC,Book_Identification   ASC);

ALTER TABLE BookAuth
	ADD CONSTRAINT  UPKCL_taind PRIMARY KEY (Author_Identification,Book_Identification);

CREATE TABLE Crd_Card
(
	Card_Nbr             INTEGER  NULL ,
	Card_Exp_Dt          DATE  NULL ,
	Crd_Card_Typ         CHAR(4)  NULL ,
	Card_Vndr_Nam        VARCHAR2(20)  NULL ,
	Crd_Card_Amt         NUMBER(7,2)  NULL ,
	Pmt_Nbr              INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKCredit_Card ON Crd_Card
(Payment_Number   ASC);

ALTER TABLE Crd_Card
	ADD CONSTRAINT  XPKCredit_Card PRIMARY KEY (Payment_Number);

CREATE TABLE Crd_Chk
(
	Crd_Chk_Evnt         CHAR(12)  NOT NULL ,
	Crd_Chk_Dt           DATE  DEFAULT SYSDATE  NULL ,
	Crd_Stat             CHAR(12)  NULL ,
	Pmt_Nbr              INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKCredit_Check ON Crd_Chk
(Credit_Check_Event   ASC);

ALTER TABLE Crd_Chk
	ADD CONSTRAINT  XPKCredit_Check PRIMARY KEY (Credit_Check_Event);

CREATE TABLE Cust
(
	Cust_Id              CHAR(9)  NOT NULL ,
	Cust_Frst_Nam        VARCHAR2(15)  NULL ,
	Cust_Lst_Nam         VARCHAR2(25)  NOT NULL ,
	Cust_Stret_Addr      VARCHAR2(25)  NULL ,
	Cust_Cmpy_Nam        VARCHAR2(40)  NULL ,
	Cust_Cty             VARCHAR2(25)  NULL ,
	Cust_St              VARCHAR(4)  DEFAULT 'NJ'  NOT NULL ,
	Cust_Zip_Cd          VARCHAR(9)  NULL ,
	Cust_Phn_Area_Cd     INTEGER  DEFAULT 212  NULL ,
	Cust_Phn_Nbr         INTEGER  NULL ,
	Cust_Fax_Area_Cd     INTEGER  DEFAULT 212  NULL  CHECK (Customer_Fax_Area_Code IN (201, 212, 215, 732, 908)),
	Cust_Fax_Nbr         INTEGER  NULL 
);

CREATE UNIQUE INDEX XPKCustomer ON Cust
(Customer_Identification   ASC);

ALTER TABLE Cust
	ADD CONSTRAINT  XPKCustomer PRIMARY KEY (Customer_Identification);

CREATE INDEX XIE1Customer ON Cust
(Customer_Last_Name   ASC,Customer_First_Name   ASC);

CREATE TABLE Disc
(
	Disc_Typ             VARCHAR2(4)  NOT NULL ,
	Lo_Qty               SMALLINT  NULL ,
	Hi_Qty               SMALLINT  NULL ,
	Disc_Pct             DECIMAL(4,2)  NULL 
);

CREATE UNIQUE INDEX XPKDiscount ON Disc
(Discount_Type   ASC);

ALTER TABLE Disc
	ADD CONSTRAINT  XPKDiscount PRIMARY KEY (Discount_Type);

CREATE TABLE Job
(
	Job_Id               CHAR(9)  NOT NULL ,
	Job_Desc             VARCHAR2(50)  DEFAULT 'New Position - title not formalized yet'  NULL ,
	Min_LvL              SMALLINT  NULL  CHECK (Min_LvL >= 10),
	Max_LvL              SMALLINT  NULL  CHECK (Max_LvL <= 250)
);

CREATE UNIQUE INDEX PK__jobs__117F9D94 ON Job
(Job_Identification   ASC);

ALTER TABLE Job
	ADD CONSTRAINT  PK__jobs__117F9D94 PRIMARY KEY (Job_Identification);

CREATE TABLE Emp
(
	Emp_Id               CHAR(9)  NOT NULL ,
	Emp_Frst_Nam         VARCHAR2(20)  NULL ,
	Emp_Mid_Init         CHAR(1)  NULL ,
	Emp_Lst_Nam          VARCHAR2(30)  NULL ,
	Job_Id               CHAR(9)  DEFAULT 1  NOT NULL  CHECK (Job_Identification IN (201, 212, 215, 732, 908)),
	Curr_Emp_Job_Ttle    SMALLINT  DEFAULT 10  NULL ,
	Emp_Hire_Dt          DATE  DEFAULT SYSDATE  NULL 
);

CREATE UNIQUE INDEX PK_emp_id ON Emp
(Employee_Identification   ASC);

ALTER TABLE Emp
	ADD CONSTRAINT  PK_emp_id PRIMARY KEY (Employee_Identification);

CREATE INDEX employee_ind ON Emp
(Employee_Last_Name   ASC,Employee_First_Name   ASC,Employee_Middle_Initial   ASC);

CREATE TABLE Ordr_Ship
(
	Ordr_Ship_Id         CHAR(9)  NOT NULL ,
	Blng_Addr            VARCHAR2(25)  NULL ,
	Ship_Addr            VARCHAR2(25)  NULL ,
	Ship_Stat            CHAR(7)  NULL ,
	Shed_Ship_Dt         DATE  DEFAULT SYSDATE  NULL ,
	Ordr_Nbr             INTEGER  NOT NULL ,
	Itm_Seq_Nbr          INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKOrder_Shipment ON Ordr_Ship
(Order_Shipment_Identifier   ASC,Ordr_Nbr   ASC,Itm_Seq_Nbr   ASC);

ALTER TABLE Ordr_Ship
	ADD CONSTRAINT  XPKOrder_Shipment PRIMARY KEY (Order_Shipment_Identifier,Ordr_Nbr,Itm_Seq_Nbr);

CREATE TABLE Bk_Ordr
(
	Reschd_Ship_Dt       DATE  NULL ,
	Ordr_Ship_Id         CHAR(9)  DEFAULT 212  NOT NULL  CHECK (Order_Shipment_Identifier IN (201, 212, 215, 732, 908)),
	Ordr_Nbr             INTEGER  NOT NULL ,
	Itm_Seq_Nbr          INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKBack_Order ON Bk_Ordr
(Order_Shipment_Identifier   ASC,Ordr_Nbr   ASC,Itm_Seq_Nbr   ASC);

ALTER TABLE Bk_Ordr
	ADD CONSTRAINT  XPKBack_Order PRIMARY KEY (Order_Shipment_Identifier,Ordr_Nbr,Itm_Seq_Nbr);

CREATE TABLE Stor_Nam
(
	Stor_Id              CHAR(9)  NOT NULL ,
	Stor_Nam             VARCHAR2(40)  NULL ,
	Stor_Addr            VARCHAR2(25)  NULL ,
	Stor_Cty             VARCHAR2(25)  NULL ,
	Stor_St              VARCHAR(4)  NOT NULL ,
	Stor_Zip_Cd          VARCHAR(9)  NULL ,
	Rgn_Id               CHAR(9)  NULL 
);

CREATE UNIQUE INDEX UPK_storeid ON Stor_Nam
(Stor_Id   ASC);

ALTER TABLE Stor_Nam
	ADD CONSTRAINT  UPK_storeid PRIMARY KEY (Stor_Id);

CREATE TABLE Purchase_Ordr
(
	Stor_Id              CHAR(9)  NOT NULL ,
	Ordr_Nbr             INTEGER  NOT NULL ,
	Ordr_Dt              DATE  DEFAULT SYSDATE  NULL ,
	Pmt_Trm              VARCHAR2(12)  NULL ,
	Cust_Id              CHAR(9)  NULL 
);

CREATE UNIQUE INDEX UPKCL_sales ON Purchase_Ordr
(Order_Number   ASC);

ALTER TABLE Purchase_Ordr
	ADD CONSTRAINT  UPKCL_sales PRIMARY KEY (Order_Number);

CREATE TABLE Ordr_Itm
(
	Ordr_Qty             SMALLINT  NULL ,
	Ordr_Nbr             INTEGER  NOT NULL ,
	Book_Id              CHAR(9)  NOT NULL ,
	Itm_Seq_Nbr          INTEGER  NOT NULL ,
	Disc_Typ             VARCHAR2(4)  NULL ,
	Ordr_Disc_Amt        DECIMAL(7,2)  NULL ,
	Ordr_Prc             DECIMAL(7,2)  NULL 
);

CREATE UNIQUE INDEX XPKOrder_Item ON Ordr_Itm
(Ordr_Nbr   ASC,Itm_Seq_Nbr   ASC);

ALTER TABLE Ordr_Itm
	ADD CONSTRAINT  XPKOrder_Item PRIMARY KEY (Ordr_Nbr,Itm_Seq_Nbr);

CREATE TABLE Rylty_Hist
(
	Ordr_Nbr             INTEGER  NULL ,
	Itm_Seq_Nbr          INTEGER  NULL ,
	Rylty_Hist_Id        CHAR(9)  NOT NULL ,
	Rylty_Pmt_Dt         DATE  DEFAULT SYSDATE  NULL ,
	Rylty_Pmt_Amt        DECIMAL(6,2)  NULL ,
	Rylty_Payee          CHAR(30)  NULL 
);

CREATE UNIQUE INDEX XPKRoyalty_History ON Rylty_Hist
(Royalty_History_Identification   ASC);

ALTER TABLE Rylty_Hist
	ADD CONSTRAINT  XPKRoyalty_History PRIMARY KEY (Royalty_History_Identification);

CREATE TABLE Book_Retrun
(
	Book_Rtrn_Id         CHAR(9)  NOT NULL ,
	Ordr_Nbr             INTEGER  NULL ,
	Itm_Seq_Nbr          INTEGER  NULL ,
	Book_Rtrn_Dt         DATE  NULL 
);

CREATE UNIQUE INDEX XPKBook_Retrun ON Book_Retrun
(Book_Return_Identification   ASC);

ALTER TABLE Book_Retrun
	ADD CONSTRAINT  XPKBook_Retrun PRIMARY KEY (Book_Return_Identification);

CREATE TABLE Mony_Ordr
(
	Mony_Ordr_Nbr        INTEGER  NULL ,
	Mony_Ordr_Amt        NUMBER(7,2)  NULL ,
	Pmt_Nbr              INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKMoney_Order ON Mony_Ordr
(Payment_Number   ASC);

CREATE TABLE Pmt
(
	Pmt_Nbr              INTEGER  NOT NULL ,
	Pmt_Dt               DATE  DEFAULT SYSDATE  NULL ,
	Pmt_Amt              DECIMAL(7,2)  NULL ,
	Pmt_Typ              CHAR(9)  NULL 
);

CREATE UNIQUE INDEX XPKPayment ON Pmt
(Payment_Number   ASC);

ALTER TABLE Pmt
	ADD CONSTRAINT  XPKPayment PRIMARY KEY (Payment_Number);

CREATE TABLE Personal_Chk
(
	Chk_Nbr              INTEGER  NULL ,
	Chk_Acct_Nbr         INTEGER  NULL ,
	Chk_Bnk_Nbr          INTEGER  NULL ,
	Chk_Dvr_Lic_Nbr      CHAR(15)  NULL ,
	Chk_Amt              NUMBER(7,2)  NULL ,
	Pmt_Nbr              INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKPersonal_Check ON Personal_Chk
(Payment_Number   ASC);

CREATE TABLE Rgn
(
	Rgn_Id               CHAR(9)  NOT NULL ,
	Rgn_Area             CHAR(7)  NULL ,
	Rgn_Desc             VARCHAR2(75)  NULL 
);

CREATE UNIQUE INDEX XPKRegion ON Rgn
(Region_Identification   ASC);

ALTER TABLE Rgn
	ADD CONSTRAINT  XPKRegion PRIMARY KEY (Region_Identification);

CREATE TABLE Rylty
(
	Lo_Rnge              INTEGER  NULL ,
	Hi_Rnge              INTEGER  NULL ,
	Rylty_Amt            NUMBER(5,2)  NULL ,
	Rylty_Id             CHAR(9)  NOT NULL 
);

CREATE UNIQUE INDEX XPKRoyalty ON Rylty
(Royalty_Identification   ASC);

ALTER TABLE Rylty
	ADD CONSTRAINT  XPKRoyalty PRIMARY KEY (Royalty_Identification);

CREATE TABLE Rylty_Pmt
(
	Auth_Id              CHAR(9)  NOT NULL ,
	Book_Id              CHAR(9)  NOT NULL ,
	Rylty_Id             CHAR(9)  DEFAULT 212  NOT NULL  CHECK (Royalty_Identification IN (201, 212, 215, 732, 908)),
	Pmt_Dt               DATE  DEFAULT SYSDATE  NULL ,
	Pmt_Amt              DECIMAL(7,2)  NULL 
);

CREATE UNIQUE INDEX XPKRoyalty_Payment ON Rylty_Pmt
(Author_Identification   ASC,Book_Identification   ASC,Royalty_Identification   ASC);

ALTER TABLE Rylty_Pmt
	ADD CONSTRAINT  XPKRoyalty_Payment PRIMARY KEY (Author_Identification,Book_Identification,Royalty_Identification);

CREATE TABLE Reporting_Structure
(
	Mngr                 CHAR(9)  NOT NULL ,
	Rpt_To               CHAR(9)  NOT NULL ,
	Strt_Dt              DATE  NULL ,
	End_Dt               DATE  NULL 
);

CREATE UNIQUE INDEX XPKReporting_Structure ON Reporting_Structure
(Manager   ASC,Reports_To   ASC);

ALTER TABLE Reporting_Structure
	ADD CONSTRAINT  XPKReporting_Structure PRIMARY KEY (Manager,Reports_To);

CREATE VIEW titleview
   (Book_Nam, Auth_Id, Auth_Lst_Nam, MRSP_Prc, Publshr_Id)
AS SELECT
   Book.Book_Nam, Auth.Auth_Id, Auth.Auth_Lst_Nam,
   Book.MRSP_Prc, Book.Publshr_Id
FROM Book, Auth, BookAuth
;

CREATE VIEW Order_View ( Stor_Nam,Ordr_Nbr,Ordr_Dt,Book_Nam,Ordr_Qty,Ordr_Disc_Amt,Ordr_Prc ) 
	 AS  SELECT Stor_Nam.Stor_Nam,Purchase_Ordr.Ordr_Nbr,Purchase_Ordr.Ordr_Dt,Book.Book_Nam,Ordr_Itm.Ordr_Qty,Ordr_Itm.Ordr_Disc_Amt,Ordr_Itm.Ordr_Prc
		FROM Ordr_Itm ,Book ,Purchase_Ordr ,Stor_Nam ;

CREATE VIEW Publisher_View ( Emp_Frst_Nam,Emp_Lst_Nam,Publshr_Nam,Book_Nam,Yr_To_Dt_Sls_Amt ) 
	 AS  SELECT Emp.Emp_Frst_Nam,Emp.Emp_Lst_Nam,Publshr.Publshr_Nam,Book.Book_Nam,Book_YTD_Sls.Yr_To_Dt_Sls_Amt
		FROM Publshr ,Book ,Book_YTD_Sls ,Emp ;

CREATE VIEW Payment_View ( Card_Nbr,Crd_Card_Amt,Mony_Ordr_Nbr,Mony_Ordr_Amt,Chk_Nbr,Chk_Amt,Cust_Frst_Nam,Cust_Lst_Nam,Ordr_Nbr,Ordr_Dt ) 
	 AS  SELECT Crd_Card.Card_Nbr,Crd_Card.Crd_Card_Amt,Mony_Ordr.Mony_Ordr_Nbr,Mony_Ordr.Mony_Ordr_Amt,Personal_Chk.Chk_Nbr,Personal_Chk.Chk_Amt,Cust.Cust_Frst_Nam,Cust.Cust_Lst_Nam,Purchase_Ordr.Ordr_Nbr,Purchase_Ordr.Ordr_Dt
		FROM Mony_Ordr ,Pmt ,Crd_Card ,Personal_Chk ,Cust ,Purchase_Ordr ;

ALTER TABLE Publshr_Logo
	ADD (
CONSTRAINT FK_Publshr_Publshr_Logo FOREIGN KEY (Publshr_Id) REFERENCES Publshr (Publshr_Id));

ALTER TABLE Book
	ADD (
CONSTRAINT FK_Publshr_Book FOREIGN KEY (Publshr_Id) REFERENCES Publshr (Publshr_Id));

ALTER TABLE Book_YTD_Sls
	ADD (
CONSTRAINT FK_Book_Book_YTD_Sls FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id));

ALTER TABLE BookAuth
	ADD (
CONSTRAINT FK_Auth_BookAuth FOREIGN KEY (Auth_Id) REFERENCES Auth (Auth_Id));

ALTER TABLE BookAuth
	ADD (
CONSTRAINT FK_Book_BookAuth FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id));

ALTER TABLE Crd_Card
	ADD (
CONSTRAINT FK_Pmt_Crd_Card FOREIGN KEY (Pmt_Nbr) REFERENCES Pmt (Pmt_Nbr) ON DELETE CASCADE);

ALTER TABLE Crd_Chk
	ADD (
CONSTRAINT FK_Crd_Card_Crd_Chk FOREIGN KEY (Pmt_Nbr) REFERENCES Crd_Card (Pmt_Nbr));

ALTER TABLE Emp
	ADD (
CONSTRAINT FK_Job_Emp FOREIGN KEY (Job_Id) REFERENCES Job (Job_Id));

ALTER TABLE Ordr_Ship
	ADD (
CONSTRAINT FK_Ordr_Itm_Ordr_Ship FOREIGN KEY (Ordr_Nbr, Itm_Seq_Nbr) REFERENCES Ordr_Itm (Ordr_Nbr, Itm_Seq_Nbr));

ALTER TABLE Bk_Ordr
	ADD (
CONSTRAINT FK_Ordr_Ship_Bk_Ordr FOREIGN KEY (Ordr_Ship_Id, Ordr_Nbr, Itm_Seq_Nbr) REFERENCES Ordr_Ship (Ordr_Ship_Id, Ordr_Nbr, Itm_Seq_Nbr));

ALTER TABLE Stor_Nam
	ADD (
CONSTRAINT FK_Rgn_Stor_Nam FOREIGN KEY (Rgn_Id) REFERENCES Rgn (Rgn_Id) ON DELETE SET NULL);

ALTER TABLE Purchase_Ordr
	ADD (
CONSTRAINT FK_Cust_Purchase_Ordr FOREIGN KEY (Cust_Id) REFERENCES Cust (Cust_Id) ON DELETE SET NULL);

ALTER TABLE Purchase_Ordr
	ADD (
CONSTRAINT FK_Stor_Nam_Purchase_Ordr FOREIGN KEY (Stor_Id) REFERENCES Stor_Nam (Stor_Id));

ALTER TABLE Ordr_Itm
	ADD (
CONSTRAINT FK_Disc_Ordr_Itm FOREIGN KEY (Disc_Typ) REFERENCES Disc (Disc_Typ) ON DELETE SET NULL);

ALTER TABLE Ordr_Itm
	ADD (
CONSTRAINT FK_Purchase_Ordr_Ordr_Itm FOREIGN KEY (Ordr_Nbr) REFERENCES Purchase_Ordr (Ordr_Nbr));

ALTER TABLE Ordr_Itm
	ADD (
CONSTRAINT FK_Book_Ordr_Itm FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id));

ALTER TABLE Rylty_Hist
	ADD (
CONSTRAINT FK_Ordr_Itm_Rylty_Hist FOREIGN KEY (Ordr_Nbr, Itm_Seq_Nbr) REFERENCES Ordr_Itm (Ordr_Nbr, Itm_Seq_Nbr) ON DELETE SET NULL);

ALTER TABLE Book_Retrun
	ADD (
CONSTRAINT FK_Ordr_Itm_Book_Retrun FOREIGN KEY (Ordr_Nbr, Itm_Seq_Nbr) REFERENCES Ordr_Itm (Ordr_Nbr, Itm_Seq_Nbr) ON DELETE SET NULL);

ALTER TABLE Mony_Ordr
	ADD (
CONSTRAINT FK_Pmt_Mony_Ordr FOREIGN KEY (Pmt_Nbr) REFERENCES Pmt (Pmt_Nbr) ON DELETE CASCADE);

ALTER TABLE Personal_Chk
	ADD (
CONSTRAINT FK_Pmt_Personal_Chk FOREIGN KEY (Pmt_Nbr) REFERENCES Pmt (Pmt_Nbr) ON DELETE CASCADE);

ALTER TABLE Rylty_Pmt
	ADD (
CONSTRAINT FK_Rylty_Rylty_Pmt FOREIGN KEY (Rylty_Id) REFERENCES Rylty (Rylty_Id));

ALTER TABLE Rylty_Pmt
	ADD (
CONSTRAINT FK_BookAuth_Rylty_Pmt FOREIGN KEY (Auth_Id, Book_Id) REFERENCES BookAuth (Auth_Id, Book_Id));

ALTER TABLE Reporting_Structure
	ADD (
CONSTRAINT FK_Employee_Manager FOREIGN KEY (Mngr) REFERENCES Emp (Emp_Id));

ALTER TABLE Reporting_Structure
	ADD (
CONSTRAINT FK_Employee_ReportTo FOREIGN KEY (Rpt_To) REFERENCES Emp (Emp_Id));

CREATE  PROCEDURE byroyalty 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select au_id 
   from titleauthor
   where titleauthor.royaltyper = @percentage;
END;
/



CREATE  PROCEDURE reptq1 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select 
	case when grouping(pub_id) = 1 then 'ALL' 
             else pub_id end as pub_id, avg(price) as avg_price
   from titles
   where price is NOT NULL
   group by pub_id with rollup
   order by pub_id;
END;
/



CREATE  PROCEDURE reptq2 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select 
      case when grouping(type) = 1 then 'ALL' 
      else type end as type, 
      case when grouping(pub_id) = 1 then 'ALL' 
      else pub_id end as pub_id, avg(ytd_sales) as avg_ytd_sales
   from titles
   where pub_id is NOT NULL
   group by pub_id, type with rollup;
END;
/



CREATE  PROCEDURE reptq3x 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select 
      case when grouping(pub_id) = 1 then 'ALL' 
      else pub_id end as pub_id, 
      case when grouping(type) = 1 then 'ALL' 
      else type end as type, count(title_id) as cnt
   from titles
   where price >@lolimit AND price <@hilimit AND 
         type = @type OR type LIKE '%cook%'
   group by pub_id, type with rollup;
END;
/




CREATE  TRIGGER  tD_Auth AFTER DELETE ON Auth for each row
-- erwin Builtin Trigger
-- DELETE trigger on Auth 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Auth  BookAuth on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000eda3", PARENT_OWNER="", PARENT_TABLE="Auth"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Author_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Author_Identification = :old.Author_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Auth because BookAuth exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Auth AFTER UPDATE ON Auth for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Auth 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Auth  BookAuth on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00012d33", PARENT_OWNER="", PARENT_TABLE="Auth"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Author_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Author_Identification <> :new.Author_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Author_Identification = :old.Author_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Auth because BookAuth exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Publshr AFTER DELETE ON Publshr for each row
-- erwin Builtin Trigger
-- DELETE trigger on Publshr 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Publshr  Publshr_Logo on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001fb71", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Publshr_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Publshr_Logo", FK_COLUMNS="Publisher_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Publshr_Logo
      WHERE
        /*  %JoinFKPK(Publshr_Logo,:%Old," = "," AND") */
        Publshr_Logo.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Publshr because Publshr_Logo exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Publshr  Book on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Book", FK_COLUMNS="Publisher_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /*  %JoinFKPK(Book,:%Old," = "," AND") */
        Book.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Publshr because Book exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Publshr AFTER UPDATE ON Publshr for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Publshr 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Publshr  Publshr_Logo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000272c7", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Publshr_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Publshr_Logo", FK_COLUMNS="Publisher_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Publisher_Identification <> :new.Publisher_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Publshr_Logo
      WHERE
        /*  %JoinFKPK(Publshr_Logo,:%Old," = "," AND") */
        Publshr_Logo.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Publshr because Publshr_Logo exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Publshr  Book on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Book", FK_COLUMNS="Publisher_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Publisher_Identification <> :new.Publisher_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /*  %JoinFKPK(Book,:%Old," = "," AND") */
        Book.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Publshr because Book exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Publshr_Logo BEFORE INSERT ON Publshr_Logo for each row
-- erwin Builtin Trigger
-- INSERT trigger on Publshr_Logo 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Publshr  Publshr_Logo on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00010c68", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Publshr_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Publshr_Logo", FK_COLUMNS="Publisher_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Publshr
      WHERE
        /* %JoinFKPK(:%New,Publshr," = "," AND") */
        :new.Publisher_Identification = Publshr.Publisher_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Publshr_Logo because Publshr does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Publshr_Logo AFTER UPDATE ON Publshr_Logo for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Publshr_Logo 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Publshr  Publshr_Logo on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="000105a1", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Publshr_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Publshr_Logo", FK_COLUMNS="Publisher_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Publshr
    WHERE
      /* %JoinFKPK(:%New,Publshr," = "," AND") */
      :new.Publisher_Identification = Publshr.Publisher_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Publshr_Logo because Publshr does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Book AFTER DELETE ON Book for each row
-- erwin Builtin Trigger
-- DELETE trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  BookAuth on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002f214", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Book because BookAuth exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Book  Book_YTD_Sls on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sls"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sls", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book_YTD_Sls
      WHERE
        /*  %JoinFKPK(Book_YTD_Sls,:%Old," = "," AND") */
        Book_YTD_Sls.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Book because Book_YTD_Sls exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Book  Ordr_Itm on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Book because Ordr_Itm exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Book BEFORE INSERT ON Book for each row
-- erwin Builtin Trigger
-- INSERT trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Publshr  Book on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00010894", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Book", FK_COLUMNS="Publisher_Identification" */
    UPDATE Book
      SET
        /* %SetFK(Book,NULL) */
        Book.Publisher_Identification = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Publshr
            WHERE
              /* %JoinFKPK(:%New,Publshr," = "," AND") */
              :new.Publisher_Identification = Publshr.Publisher_Identification
        ) 
        /* %JoinPKPK(Book,:%New," = "," AND") */
         and Book.Book_Identification = :new.Book_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Book AFTER UPDATE ON Book for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Book  BookAuth on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004a7fa", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Book because BookAuth exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  Book_YTD_Sls on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sls"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sls", FK_COLUMNS="Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Book_YTD_Sls
      WHERE
        /*  %JoinFKPK(Book_YTD_Sls,:%Old," = "," AND") */
        Book_YTD_Sls.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Book because Book_YTD_Sls exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  Ordr_Itm on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Book because Ordr_Itm exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Publshr  Book on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Book", FK_COLUMNS="Publisher_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Publshr
    WHERE
      /* %JoinFKPK(:%New,Publshr," = "," AND") */
      :new.Publisher_Identification = Publshr.Publisher_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Publisher_Identification IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Book because Publshr does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Book_YTD_Sls BEFORE INSERT ON Book_YTD_Sls for each row
-- erwin Builtin Trigger
-- INSERT trigger on Book_YTD_Sls 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  Book_YTD_Sls on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f31c", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sls"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sls", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Identification = Book.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Book_YTD_Sls because Book does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Book_YTD_Sls AFTER UPDATE ON Book_YTD_Sls for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Book_YTD_Sls 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Book  Book_YTD_Sls on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000f616", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sls"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sls", FK_COLUMNS="Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Identification = Book.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Book_YTD_Sls because Book does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_BookAuth AFTER DELETE ON BookAuth for each row
-- erwin Builtin Trigger
-- DELETE trigger on BookAuth 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* BookAuth  Rylty_Pmt on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00011e18", PARENT_OWNER="", PARENT_TABLE="BookAuth"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuth_Rylty_Pmt", FK_COLUMNS="Author_Identification""Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Rylty_Pmt
      WHERE
        /*  %JoinFKPK(Rylty_Pmt,:%Old," = "," AND") */
        Rylty_Pmt.Author_Identification = :old.Author_Identification AND
        Rylty_Pmt.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete BookAuth because Rylty_Pmt exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_BookAuth BEFORE INSERT ON BookAuth for each row
-- erwin Builtin Trigger
-- INSERT trigger on BookAuth 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  BookAuth on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001f45f", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Identification = Book.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert BookAuth because Book does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Auth  BookAuth on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Auth"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Author_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Auth
      WHERE
        /* %JoinFKPK(:%New,Auth," = "," AND") */
        :new.Author_Identification = Auth.Author_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert BookAuth because Auth does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_BookAuth AFTER UPDATE ON BookAuth for each row
-- erwin Builtin Trigger
-- UPDATE trigger on BookAuth 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* BookAuth  Rylty_Pmt on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000377cc", PARENT_OWNER="", PARENT_TABLE="BookAuth"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuth_Rylty_Pmt", FK_COLUMNS="Author_Identification""Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Author_Identification <> :new.Author_Identification OR 
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Rylty_Pmt
      WHERE
        /*  %JoinFKPK(Rylty_Pmt,:%Old," = "," AND") */
        Rylty_Pmt.Author_Identification = :old.Author_Identification AND
        Rylty_Pmt.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update BookAuth because Rylty_Pmt exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  BookAuth on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Identification = Book.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update BookAuth because Book does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Auth  BookAuth on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Auth"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Author_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Auth
    WHERE
      /* %JoinFKPK(:%New,Auth," = "," AND") */
      :new.Author_Identification = Auth.Author_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update BookAuth because Auth does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Crd_Card AFTER DELETE ON Crd_Card for each row
-- erwin Builtin Trigger
-- DELETE trigger on Crd_Card 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Crd_Card  Crd_Chk on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000d9d0", PARENT_OWNER="", PARENT_TABLE="Crd_Card"
    CHILD_OWNER="", CHILD_TABLE="Crd_Chk"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Crd_Card_Crd_Chk", FK_COLUMNS="Payment_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Crd_Chk
      WHERE
        /*  %JoinFKPK(Crd_Chk,:%Old," = "," AND") */
        Crd_Chk.Payment_Number = :old.Payment_Number;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Crd_Card because Crd_Chk exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Crd_Card AFTER UPDATE ON Crd_Card for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Crd_Card 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Crd_Card  Crd_Chk on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010d57", PARENT_OWNER="", PARENT_TABLE="Crd_Card"
    CHILD_OWNER="", CHILD_TABLE="Crd_Chk"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Crd_Card_Crd_Chk", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Crd_Chk
      WHERE
        /*  %JoinFKPK(Crd_Chk,:%Old," = "," AND") */
        Crd_Chk.Payment_Number = :old.Payment_Number;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Crd_Card because Crd_Chk exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Crd_Chk BEFORE INSERT ON Crd_Chk for each row
-- erwin Builtin Trigger
-- INSERT trigger on Crd_Chk 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Crd_Card  Crd_Chk on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f6e8", PARENT_OWNER="", PARENT_TABLE="Crd_Card"
    CHILD_OWNER="", CHILD_TABLE="Crd_Chk"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Crd_Card_Crd_Chk", FK_COLUMNS="Payment_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Crd_Card
      WHERE
        /* %JoinFKPK(:%New,Crd_Card," = "," AND") */
        :new.Payment_Number = Crd_Card.Payment_Number;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Crd_Chk because Crd_Card does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Crd_Chk AFTER UPDATE ON Crd_Chk for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Crd_Chk 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Crd_Card  Crd_Chk on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000f7aa", PARENT_OWNER="", PARENT_TABLE="Crd_Card"
    CHILD_OWNER="", CHILD_TABLE="Crd_Chk"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Crd_Card_Crd_Chk", FK_COLUMNS="Payment_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Crd_Card
    WHERE
      /* %JoinFKPK(:%New,Crd_Card," = "," AND") */
      :new.Payment_Number = Crd_Card.Payment_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Crd_Chk because Crd_Card does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Cust AFTER DELETE ON Cust for each row
-- erwin Builtin Trigger
-- DELETE trigger on Cust 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Cust  Purchase_Ordr on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000de50", PARENT_OWNER="", PARENT_TABLE="Cust"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Cust_Purchase_Ordr", FK_COLUMNS="Customer_Identification" */
    UPDATE Purchase_Ordr
      SET
        /* %SetFK(Purchase_Ordr,NULL) */
        Purchase_Ordr.Customer_Identification = NULL
      WHERE
        /* %JoinFKPK(Purchase_Ordr,:%Old," = "," AND") */
        Purchase_Ordr.Customer_Identification = :old.Customer_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Cust AFTER UPDATE ON Cust for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Cust 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Cust  Purchase_Ordr on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="000118d4", PARENT_OWNER="", PARENT_TABLE="Cust"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Cust_Purchase_Ordr", FK_COLUMNS="Customer_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Customer_Identification <> :new.Customer_Identification
  THEN
    UPDATE Purchase_Ordr
      SET
        /* %SetFK(Purchase_Ordr,NULL) */
        Purchase_Ordr.Customer_Identification = NULL
      WHERE
        /* %JoinFKPK(Purchase_Ordr,:%Old," = ",",") */
        Purchase_Ordr.Customer_Identification = :old.Customer_Identification;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Disc AFTER DELETE ON Disc for each row
-- erwin Builtin Trigger
-- DELETE trigger on Disc 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Disc  Ordr_Itm on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000bd28", PARENT_OWNER="", PARENT_TABLE="Disc"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Disc_Ordr_Itm", FK_COLUMNS="Discount_Type" */
    UPDATE Ordr_Itm
      SET
        /* %SetFK(Ordr_Itm,NULL) */
        Ordr_Itm.Discount_Type = NULL
      WHERE
        /* %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Discount_Type = :old.Discount_Type;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Disc AFTER UPDATE ON Disc for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Disc 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Disc  Ordr_Itm on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000ebad", PARENT_OWNER="", PARENT_TABLE="Disc"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Disc_Ordr_Itm", FK_COLUMNS="Discount_Type" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Discount_Type <> :new.Discount_Type
  THEN
    UPDATE Ordr_Itm
      SET
        /* %SetFK(Ordr_Itm,NULL) */
        Ordr_Itm.Discount_Type = NULL
      WHERE
        /* %JoinFKPK(Ordr_Itm,:%Old," = ",",") */
        Ordr_Itm.Discount_Type = :old.Discount_Type;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Job AFTER DELETE ON Job for each row
-- erwin Builtin Trigger
-- DELETE trigger on Job 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Job  Emp on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000d733", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Emp", FK_COLUMNS="Job_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Emp
      WHERE
        /*  %JoinFKPK(Emp,:%Old," = "," AND") */
        Emp.Job_Identification = :old.Job_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Job because Emp exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Job AFTER UPDATE ON Job for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Job 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Job  Emp on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00010617", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Emp", FK_COLUMNS="Job_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Job_Identification <> :new.Job_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Emp
      WHERE
        /*  %JoinFKPK(Emp,:%Old," = "," AND") */
        Emp.Job_Identification = :old.Job_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Job because Emp exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER employee_insupd
  AFTER INSERT OR UPDATE
  ON Emp
  
  
  

--Get the range of level for this job type from the jobs table.
declare Xmin_lvl smallint;
        Xmax_lvl smallint;
        Xemp_lvl smallint;
        Xjob_id  smallint;

Begin
   select Xmin_lvl = min_lvl,
      Xmax_lvl = max_lvl,
      Xemp_lvl = i.job_lvl,
      Xjob_id = i.job_id
   from employee e, jobs j, inserted i
   where e.emp_id = i.emp_id AND i.job_id = j.job_id;

   IF (Xjob_id = 1) and (Xemp_lvl <> 10) then
      raise_application_error (-20001, 
      'Job id 1 expects the default level of 10.');
   ELSE
      IF NOT (Xemp_lvl BETWEEN Xmin_lvl AND Xmax_lvl) then
         raise_application_error (-20002, 
         'The level for job_id:%d should be between %d and %d.', 
         Xjob_id, Xmin_lvl, Xmax_lvl);
      end if;
   end if;
END;
/



ALTER TRIGGER employee_insupd
	ENABLE;


CREATE  TRIGGER  tD_Emp AFTER DELETE ON Emp for each row
-- erwin Builtin Trigger
-- DELETE trigger on Emp 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Emp  Reporting_Structure on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00020b37", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Reports_To = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Emp because Reporting_Structure exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Emp  Reporting_Structure on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Manager = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Emp because Reporting_Structure exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Emp BEFORE INSERT ON Emp for each row
-- erwin Builtin Trigger
-- INSERT trigger on Emp 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Job  Emp on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000eb19", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Emp", FK_COLUMNS="Job_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Job
      WHERE
        /* %JoinFKPK(:%New,Job," = "," AND") */
        :new.Job_Identification = Job.Job_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Emp because Job does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Emp AFTER UPDATE ON Emp for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Emp 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Emp  Reporting_Structure on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00037fe9", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Employee_Identification <> :new.Employee_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Reports_To = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Emp because Reporting_Structure exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Emp  Reporting_Structure on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Employee_Identification <> :new.Employee_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Manager = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Emp because Reporting_Structure exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Job  Emp on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Emp", FK_COLUMNS="Job_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Job
    WHERE
      /* %JoinFKPK(:%New,Job," = "," AND") */
      :new.Job_Identification = Job.Job_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Emp because Job does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Ordr_Ship AFTER DELETE ON Ordr_Ship for each row
-- erwin Builtin Trigger
-- DELETE trigger on Ordr_Ship 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Ordr_Ship  Bk_Ordr on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00012658", PARENT_OWNER="", PARENT_TABLE="Ordr_Ship"
    CHILD_OWNER="", CHILD_TABLE="Bk_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Ship_Bk_Ordr", FK_COLUMNS="Order_Shipment_Identifier""Ordr_Nbr""Itm_Seq_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Bk_Ordr
      WHERE
        /*  %JoinFKPK(Bk_Ordr,:%Old," = "," AND") */
        Bk_Ordr.Order_Shipment_Identifier = :old.Order_Shipment_Identifier AND
        Bk_Ordr.Ordr_Nbr = :old.Ordr_Nbr AND
        Bk_Ordr.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Ordr_Ship because Bk_Ordr exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Ordr_Ship BEFORE INSERT ON Ordr_Ship for each row
-- erwin Builtin Trigger
-- INSERT trigger on Ordr_Ship 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Ordr_Itm  Ordr_Ship on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00010dbc", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Ship"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Ordr_Ship", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /* %JoinFKPK(:%New,Ordr_Itm," = "," AND") */
        :new.Ordr_Nbr = Ordr_Itm.Ordr_Nbr AND
        :new.Itm_Seq_Nbr = Ordr_Itm.Itm_Seq_Nbr;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Ordr_Ship because Ordr_Itm does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Ordr_Ship AFTER UPDATE ON Ordr_Ship for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Ordr_Ship 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Ordr_Ship  Bk_Ordr on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002aa25", PARENT_OWNER="", PARENT_TABLE="Ordr_Ship"
    CHILD_OWNER="", CHILD_TABLE="Bk_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Ship_Bk_Ordr", FK_COLUMNS="Order_Shipment_Identifier""Ordr_Nbr""Itm_Seq_Nbr" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Shipment_Identifier <> :new.Order_Shipment_Identifier OR 
    :old.Ordr_Nbr <> :new.Ordr_Nbr OR 
    :old.Itm_Seq_Nbr <> :new.Itm_Seq_Nbr
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Bk_Ordr
      WHERE
        /*  %JoinFKPK(Bk_Ordr,:%Old," = "," AND") */
        Bk_Ordr.Order_Shipment_Identifier = :old.Order_Shipment_Identifier AND
        Bk_Ordr.Ordr_Nbr = :old.Ordr_Nbr AND
        Bk_Ordr.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Ordr_Ship because Bk_Ordr exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Ordr_Itm  Ordr_Ship on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Ship"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Ordr_Ship", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
  SELECT count(*) INTO NUMROWS
    FROM Ordr_Itm
    WHERE
      /* %JoinFKPK(:%New,Ordr_Itm," = "," AND") */
      :new.Ordr_Nbr = Ordr_Itm.Ordr_Nbr AND
      :new.Itm_Seq_Nbr = Ordr_Itm.Itm_Seq_Nbr;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Ordr_Ship because Ordr_Itm does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Bk_Ordr BEFORE INSERT ON Bk_Ordr for each row
-- erwin Builtin Trigger
-- INSERT trigger on Bk_Ordr 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Ordr_Ship  Bk_Ordr on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00013d12", PARENT_OWNER="", PARENT_TABLE="Ordr_Ship"
    CHILD_OWNER="", CHILD_TABLE="Bk_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Ship_Bk_Ordr", FK_COLUMNS="Order_Shipment_Identifier""Ordr_Nbr""Itm_Seq_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Ship
      WHERE
        /* %JoinFKPK(:%New,Ordr_Ship," = "," AND") */
        :new.Order_Shipment_Identifier = Ordr_Ship.Order_Shipment_Identifier AND
        :new.Ordr_Nbr = Ordr_Ship.Ordr_Nbr AND
        :new.Itm_Seq_Nbr = Ordr_Ship.Itm_Seq_Nbr;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Bk_Ordr because Ordr_Ship does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Bk_Ordr AFTER UPDATE ON Bk_Ordr for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Bk_Ordr 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Ordr_Ship  Bk_Ordr on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00013cc4", PARENT_OWNER="", PARENT_TABLE="Ordr_Ship"
    CHILD_OWNER="", CHILD_TABLE="Bk_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Ship_Bk_Ordr", FK_COLUMNS="Order_Shipment_Identifier""Ordr_Nbr""Itm_Seq_Nbr" */
  SELECT count(*) INTO NUMROWS
    FROM Ordr_Ship
    WHERE
      /* %JoinFKPK(:%New,Ordr_Ship," = "," AND") */
      :new.Order_Shipment_Identifier = Ordr_Ship.Order_Shipment_Identifier AND
      :new.Ordr_Nbr = Ordr_Ship.Ordr_Nbr AND
      :new.Itm_Seq_Nbr = Ordr_Ship.Itm_Seq_Nbr;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Bk_Ordr because Ordr_Ship does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Stor_Nam AFTER DELETE ON Stor_Nam for each row
-- erwin Builtin Trigger
-- DELETE trigger on Stor_Nam 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Stor_Nam  Purchase_Ordr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000e97d", PARENT_OWNER="", PARENT_TABLE="Stor_Nam"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Nam_Purchase_Ordr", FK_COLUMNS="Stor_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Purchase_Ordr
      WHERE
        /*  %JoinFKPK(Purchase_Ordr,:%Old," = "," AND") */
        Purchase_Ordr.Stor_Id = :old.Stor_Id;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Stor_Nam because Purchase_Ordr exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Stor_Nam BEFORE INSERT ON Stor_Nam for each row
-- erwin Builtin Trigger
-- INSERT trigger on Stor_Nam 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Rgn  Stor_Nam on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00010112", PARENT_OWNER="", PARENT_TABLE="Rgn"
    CHILD_OWNER="", CHILD_TABLE="Stor_Nam"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rgn_Stor_Nam", FK_COLUMNS="Region_Identification" */
    UPDATE Stor_Nam
      SET
        /* %SetFK(Stor_Nam,NULL) */
        Stor_Nam.Region_Identification = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Rgn
            WHERE
              /* %JoinFKPK(:%New,Rgn," = "," AND") */
              :new.Region_Identification = Rgn.Region_Identification
        ) 
        /* %JoinPKPK(Stor_Nam,:%New," = "," AND") */
         and Stor_Nam.Stor_Id = :new.Stor_Id;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Stor_Nam AFTER UPDATE ON Stor_Nam for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Stor_Nam 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Stor_Nam  Purchase_Ordr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00022d65", PARENT_OWNER="", PARENT_TABLE="Stor_Nam"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Nam_Purchase_Ordr", FK_COLUMNS="Stor_Id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Stor_Id <> :new.Stor_Id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Purchase_Ordr
      WHERE
        /*  %JoinFKPK(Purchase_Ordr,:%Old," = "," AND") */
        Purchase_Ordr.Stor_Id = :old.Stor_Id;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Stor_Nam because Purchase_Ordr exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Rgn  Stor_Nam on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Rgn"
    CHILD_OWNER="", CHILD_TABLE="Stor_Nam"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rgn_Stor_Nam", FK_COLUMNS="Region_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Rgn
    WHERE
      /* %JoinFKPK(:%New,Rgn," = "," AND") */
      :new.Region_Identification = Rgn.Region_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Region_Identification IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Stor_Nam because Rgn does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Purchase_Ordr AFTER DELETE ON Purchase_Ordr for each row
-- erwin Builtin Trigger
-- DELETE trigger on Purchase_Ordr 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Purchase_Ordr  Ordr_Itm on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000e6e7", PARENT_OWNER="", PARENT_TABLE="Purchase_Ordr"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Ordr_Ordr_Itm", FK_COLUMNS="Ordr_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Ordr_Nbr = :old.Order_Number;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Purchase_Ordr because Ordr_Itm exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Purchase_Ordr BEFORE INSERT ON Purchase_Ordr for each row
-- erwin Builtin Trigger
-- INSERT trigger on Purchase_Ordr 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Cust  Purchase_Ordr on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00022e30", PARENT_OWNER="", PARENT_TABLE="Cust"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Cust_Purchase_Ordr", FK_COLUMNS="Customer_Identification" */
    UPDATE Purchase_Ordr
      SET
        /* %SetFK(Purchase_Ordr,NULL) */
        Purchase_Ordr.Customer_Identification = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Cust
            WHERE
              /* %JoinFKPK(:%New,Cust," = "," AND") */
              :new.Customer_Identification = Cust.Customer_Identification
        ) 
        /* %JoinPKPK(Purchase_Ordr,:%New," = "," AND") */
         and Purchase_Ordr.Order_Number = :new.Order_Number;

    /* erwin Builtin Trigger */
    /* Stor_Nam  Purchase_Ordr on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Stor_Nam"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Nam_Purchase_Ordr", FK_COLUMNS="Stor_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Stor_Nam
      WHERE
        /* %JoinFKPK(:%New,Stor_Nam," = "," AND") */
        :new.Stor_Id = Stor_Nam.Stor_Id;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Purchase_Ordr because Stor_Nam does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Purchase_Ordr AFTER UPDATE ON Purchase_Ordr for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Purchase_Ordr 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Purchase_Ordr  Ordr_Itm on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00035bce", PARENT_OWNER="", PARENT_TABLE="Purchase_Ordr"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Ordr_Ordr_Itm", FK_COLUMNS="Ordr_Nbr" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Number <> :new.Order_Number
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Ordr_Nbr = :old.Order_Number;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Purchase_Ordr because Ordr_Itm exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Cust  Purchase_Ordr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Cust"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Cust_Purchase_Ordr", FK_COLUMNS="Customer_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Cust
    WHERE
      /* %JoinFKPK(:%New,Cust," = "," AND") */
      :new.Customer_Identification = Cust.Customer_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Customer_Identification IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Purchase_Ordr because Cust does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Stor_Nam  Purchase_Ordr on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Stor_Nam"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Nam_Purchase_Ordr", FK_COLUMNS="Stor_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Stor_Nam
    WHERE
      /* %JoinFKPK(:%New,Stor_Nam," = "," AND") */
      :new.Stor_Id = Stor_Nam.Stor_Id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Purchase_Ordr because Stor_Nam does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Ordr_Itm AFTER DELETE ON Ordr_Itm for each row
-- erwin Builtin Trigger
-- DELETE trigger on Ordr_Itm 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Ordr_Itm  Ordr_Ship on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0002fc8c", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Ship"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Ordr_Ship", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Ship
      WHERE
        /*  %JoinFKPK(Ordr_Ship,:%Old," = "," AND") */
        Ordr_Ship.Ordr_Nbr = :old.Ordr_Nbr AND
        Ordr_Ship.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Ordr_Itm because Ordr_Ship exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Ordr_Itm  Book_Retrun on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Book_Retrun", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
    UPDATE Book_Retrun
      SET
        /* %SetFK(Book_Retrun,NULL) */
        Book_Retrun.Ordr_Nbr = NULL,
        Book_Retrun.Itm_Seq_Nbr = NULL
      WHERE
        /* %JoinFKPK(Book_Retrun,:%Old," = "," AND") */
        Book_Retrun.Ordr_Nbr = :old.Ordr_Nbr AND
        Book_Retrun.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;

    /* erwin Builtin Trigger */
    /* Ordr_Itm  Rylty_Hist on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Hist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Rylty_Hist", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
    UPDATE Rylty_Hist
      SET
        /* %SetFK(Rylty_Hist,NULL) */
        Rylty_Hist.Ordr_Nbr = NULL,
        Rylty_Hist.Itm_Seq_Nbr = NULL
      WHERE
        /* %JoinFKPK(Rylty_Hist,:%Old," = "," AND") */
        Rylty_Hist.Ordr_Nbr = :old.Ordr_Nbr AND
        Rylty_Hist.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Ordr_Itm BEFORE INSERT ON Ordr_Itm for each row
-- erwin Builtin Trigger
-- INSERT trigger on Ordr_Itm 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  Ordr_Itm on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="000332f6", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Identification = Book.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Ordr_Itm because Book does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Disc  Ordr_Itm on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Disc"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Disc_Ordr_Itm", FK_COLUMNS="Discount_Type" */
    UPDATE Ordr_Itm
      SET
        /* %SetFK(Ordr_Itm,NULL) */
        Ordr_Itm.Discount_Type = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Disc
            WHERE
              /* %JoinFKPK(:%New,Disc," = "," AND") */
              :new.Discount_Type = Disc.Discount_Type
        ) 
        /* %JoinPKPK(Ordr_Itm,:%New," = "," AND") */
         and Ordr_Itm.Ordr_Nbr = :new.Ordr_Nbr AND
        Ordr_Itm.Itm_Seq_Nbr = :new.Itm_Seq_Nbr;

    /* erwin Builtin Trigger */
    /* Purchase_Ordr  Ordr_Itm on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase_Ordr"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Ordr_Ordr_Itm", FK_COLUMNS="Ordr_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Purchase_Ordr
      WHERE
        /* %JoinFKPK(:%New,Purchase_Ordr," = "," AND") */
        :new.Ordr_Nbr = Purchase_Ordr.Order_Number;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Ordr_Itm because Purchase_Ordr does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Ordr_Itm AFTER UPDATE ON Ordr_Itm for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Ordr_Itm 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Ordr_Itm  Ordr_Ship on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0006984c", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Ship"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Ordr_Ship", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Ordr_Nbr <> :new.Ordr_Nbr OR 
    :old.Itm_Seq_Nbr <> :new.Itm_Seq_Nbr
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Ship
      WHERE
        /*  %JoinFKPK(Ordr_Ship,:%Old," = "," AND") */
        Ordr_Ship.Ordr_Nbr = :old.Ordr_Nbr AND
        Ordr_Ship.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Ordr_Itm because Ordr_Ship exists.'
      );
    END IF;
  END IF;

  /* Ordr_Itm  Book_Retrun on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Book_Retrun", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Ordr_Nbr <> :new.Ordr_Nbr OR 
    :old.Itm_Seq_Nbr <> :new.Itm_Seq_Nbr
  THEN
    UPDATE Book_Retrun
      SET
        /* %SetFK(Book_Retrun,NULL) */
        Book_Retrun.Ordr_Nbr = NULL,
        Book_Retrun.Itm_Seq_Nbr = NULL
      WHERE
        /* %JoinFKPK(Book_Retrun,:%Old," = ",",") */
        Book_Retrun.Ordr_Nbr = :old.Ordr_Nbr AND
        Book_Retrun.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;
  END IF;

  /* Ordr_Itm  Rylty_Hist on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Hist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Rylty_Hist", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Ordr_Nbr <> :new.Ordr_Nbr OR 
    :old.Itm_Seq_Nbr <> :new.Itm_Seq_Nbr
  THEN
    UPDATE Rylty_Hist
      SET
        /* %SetFK(Rylty_Hist,NULL) */
        Rylty_Hist.Ordr_Nbr = NULL,
        Rylty_Hist.Itm_Seq_Nbr = NULL
      WHERE
        /* %JoinFKPK(Rylty_Hist,:%Old," = ",",") */
        Rylty_Hist.Ordr_Nbr = :old.Ordr_Nbr AND
        Rylty_Hist.Itm_Seq_Nbr = :old.Itm_Seq_Nbr;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  Ordr_Itm on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Identification = Book.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Ordr_Itm because Book does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Disc  Ordr_Itm on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Disc"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Disc_Ordr_Itm", FK_COLUMNS="Discount_Type" */
  SELECT count(*) INTO NUMROWS
    FROM Disc
    WHERE
      /* %JoinFKPK(:%New,Disc," = "," AND") */
      :new.Discount_Type = Disc.Discount_Type;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Discount_Type IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Ordr_Itm because Disc does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Purchase_Ordr  Ordr_Itm on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase_Ordr"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Ordr_Ordr_Itm", FK_COLUMNS="Ordr_Nbr" */
  SELECT count(*) INTO NUMROWS
    FROM Purchase_Ordr
    WHERE
      /* %JoinFKPK(:%New,Purchase_Ordr," = "," AND") */
      :new.Ordr_Nbr = Purchase_Ordr.Order_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Ordr_Itm because Purchase_Ordr does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Rylty_Hist BEFORE INSERT ON Rylty_Hist for each row
-- erwin Builtin Trigger
-- INSERT trigger on Rylty_Hist 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Ordr_Itm  Rylty_Hist on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00013eea", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Hist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Rylty_Hist", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
    UPDATE Rylty_Hist
      SET
        /* %SetFK(Rylty_Hist,NULL) */
        Rylty_Hist.Ordr_Nbr = NULL,
        Rylty_Hist.Itm_Seq_Nbr = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Ordr_Itm
            WHERE
              /* %JoinFKPK(:%New,Ordr_Itm," = "," AND") */
              :new.Ordr_Nbr = Ordr_Itm.Ordr_Nbr AND
              :new.Itm_Seq_Nbr = Ordr_Itm.Itm_Seq_Nbr
        ) 
        /* %JoinPKPK(Rylty_Hist,:%New," = "," AND") */
         and Rylty_Hist.Royalty_History_Identification = :new.Royalty_History_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Rylty_Hist AFTER UPDATE ON Rylty_Hist for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Rylty_Hist 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Ordr_Itm  Rylty_Hist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001265d", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Hist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Rylty_Hist", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
  SELECT count(*) INTO NUMROWS
    FROM Ordr_Itm
    WHERE
      /* %JoinFKPK(:%New,Ordr_Itm," = "," AND") */
      :new.Ordr_Nbr = Ordr_Itm.Ordr_Nbr AND
      :new.Itm_Seq_Nbr = Ordr_Itm.Itm_Seq_Nbr;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Ordr_Nbr IS NOT NULL AND
    :new.Itm_Seq_Nbr IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Rylty_Hist because Ordr_Itm does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Book_Retrun BEFORE INSERT ON Book_Retrun for each row
-- erwin Builtin Trigger
-- INSERT trigger on Book_Retrun 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Ordr_Itm  Book_Retrun on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00013448", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Book_Retrun", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
    UPDATE Book_Retrun
      SET
        /* %SetFK(Book_Retrun,NULL) */
        Book_Retrun.Ordr_Nbr = NULL,
        Book_Retrun.Itm_Seq_Nbr = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Ordr_Itm
            WHERE
              /* %JoinFKPK(:%New,Ordr_Itm," = "," AND") */
              :new.Ordr_Nbr = Ordr_Itm.Ordr_Nbr AND
              :new.Itm_Seq_Nbr = Ordr_Itm.Itm_Seq_Nbr
        ) 
        /* %JoinPKPK(Book_Retrun,:%New," = "," AND") */
         and Book_Retrun.Book_Return_Identification = :new.Book_Return_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Book_Retrun AFTER UPDATE ON Book_Retrun for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Book_Retrun 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Ordr_Itm  Book_Retrun on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00012a97", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Ordr_Itm_Book_Retrun", FK_COLUMNS="Ordr_Nbr""Itm_Seq_Nbr" */
  SELECT count(*) INTO NUMROWS
    FROM Ordr_Itm
    WHERE
      /* %JoinFKPK(:%New,Ordr_Itm," = "," AND") */
      :new.Ordr_Nbr = Ordr_Itm.Ordr_Nbr AND
      :new.Itm_Seq_Nbr = Ordr_Itm.Itm_Seq_Nbr;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Ordr_Nbr IS NOT NULL AND
    :new.Itm_Seq_Nbr IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Book_Retrun because Ordr_Itm does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Pmt AFTER DELETE ON Pmt for each row
-- erwin Builtin Trigger
-- DELETE trigger on Pmt 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Pmt  Personal_Chk on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="0002362a", PARENT_OWNER="", PARENT_TABLE="Pmt"
    CHILD_OWNER="", CHILD_TABLE="Personal_Chk"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Pmt_Personal_Chk", FK_COLUMNS="Payment_Number" */
    DELETE FROM Personal_Chk
      WHERE
        /*  %JoinFKPK(Personal_Chk,:%Old," = "," AND") */
        Personal_Chk.Payment_Number = :old.Payment_Number;

    /* erwin Builtin Trigger */
    /* Pmt  Mony_Ordr on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Pmt"
    CHILD_OWNER="", CHILD_TABLE="Mony_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Pmt_Mony_Ordr", FK_COLUMNS="Payment_Number" */
    DELETE FROM Mony_Ordr
      WHERE
        /*  %JoinFKPK(Mony_Ordr,:%Old," = "," AND") */
        Mony_Ordr.Payment_Number = :old.Payment_Number;

    /* erwin Builtin Trigger */
    /* Pmt  Crd_Card on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Pmt"
    CHILD_OWNER="", CHILD_TABLE="Crd_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Pmt_Crd_Card", FK_COLUMNS="Payment_Number" */
    DELETE FROM Crd_Card
      WHERE
        /*  %JoinFKPK(Crd_Card,:%Old," = "," AND") */
        Crd_Card.Payment_Number = :old.Payment_Number;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Pmt AFTER UPDATE ON Pmt for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Pmt 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Pmt  Personal_Chk on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00032c23", PARENT_OWNER="", PARENT_TABLE="Pmt"
    CHILD_OWNER="", CHILD_TABLE="Personal_Chk"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Pmt_Personal_Chk", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    UPDATE Personal_Chk
      SET
        /*  %JoinFKPK(Personal_Chk,:%New," = ",",") */
        Personal_Chk.Payment_Number = :new.Payment_Number
      WHERE
        /*  %JoinFKPK(Personal_Chk,:%Old," = "," AND") */
        Personal_Chk.Payment_Number = :old.Payment_Number;
  END IF;

  /* erwin Builtin Trigger */
  /* Pmt  Mony_Ordr on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Pmt"
    CHILD_OWNER="", CHILD_TABLE="Mony_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Pmt_Mony_Ordr", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    UPDATE Mony_Ordr
      SET
        /*  %JoinFKPK(Mony_Ordr,:%New," = ",",") */
        Mony_Ordr.Payment_Number = :new.Payment_Number
      WHERE
        /*  %JoinFKPK(Mony_Ordr,:%Old," = "," AND") */
        Mony_Ordr.Payment_Number = :old.Payment_Number;
  END IF;

  /* erwin Builtin Trigger */
  /* Pmt  Crd_Card on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Pmt"
    CHILD_OWNER="", CHILD_TABLE="Crd_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Pmt_Crd_Card", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    UPDATE Crd_Card
      SET
        /*  %JoinFKPK(Crd_Card,:%New," = ",",") */
        Crd_Card.Payment_Number = :new.Payment_Number
      WHERE
        /*  %JoinFKPK(Crd_Card,:%Old," = "," AND") */
        Crd_Card.Payment_Number = :old.Payment_Number;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Rgn AFTER DELETE ON Rgn for each row
-- erwin Builtin Trigger
-- DELETE trigger on Rgn 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Rgn  Stor_Nam on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000d4f0", PARENT_OWNER="", PARENT_TABLE="Rgn"
    CHILD_OWNER="", CHILD_TABLE="Stor_Nam"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rgn_Stor_Nam", FK_COLUMNS="Region_Identification" */
    UPDATE Stor_Nam
      SET
        /* %SetFK(Stor_Nam,NULL) */
        Stor_Nam.Region_Identification = NULL
      WHERE
        /* %JoinFKPK(Stor_Nam,:%Old," = "," AND") */
        Stor_Nam.Region_Identification = :old.Region_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Rgn AFTER UPDATE ON Rgn for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Rgn 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Rgn  Stor_Nam on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00010074", PARENT_OWNER="", PARENT_TABLE="Rgn"
    CHILD_OWNER="", CHILD_TABLE="Stor_Nam"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rgn_Stor_Nam", FK_COLUMNS="Region_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Region_Identification <> :new.Region_Identification
  THEN
    UPDATE Stor_Nam
      SET
        /* %SetFK(Stor_Nam,NULL) */
        Stor_Nam.Region_Identification = NULL
      WHERE
        /* %JoinFKPK(Stor_Nam,:%Old," = ",",") */
        Stor_Nam.Region_Identification = :old.Region_Identification;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Rylty AFTER DELETE ON Rylty for each row
-- erwin Builtin Trigger
-- DELETE trigger on Rylty 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Rylty  Rylty_Pmt on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f14a", PARENT_OWNER="", PARENT_TABLE="Rylty"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rylty_Rylty_Pmt", FK_COLUMNS="Royalty_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Rylty_Pmt
      WHERE
        /*  %JoinFKPK(Rylty_Pmt,:%Old," = "," AND") */
        Rylty_Pmt.Royalty_Identification = :old.Royalty_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Rylty because Rylty_Pmt exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Rylty AFTER UPDATE ON Rylty for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Rylty 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Rylty  Rylty_Pmt on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001272e", PARENT_OWNER="", PARENT_TABLE="Rylty"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rylty_Rylty_Pmt", FK_COLUMNS="Royalty_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Royalty_Identification <> :new.Royalty_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Rylty_Pmt
      WHERE
        /*  %JoinFKPK(Rylty_Pmt,:%Old," = "," AND") */
        Rylty_Pmt.Royalty_Identification = :old.Royalty_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Rylty because Rylty_Pmt exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Rylty_Pmt BEFORE INSERT ON Rylty_Pmt for each row
-- erwin Builtin Trigger
-- INSERT trigger on Rylty_Pmt 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* BookAuth  Rylty_Pmt on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0002464b", PARENT_OWNER="", PARENT_TABLE="BookAuth"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuth_Rylty_Pmt", FK_COLUMNS="Author_Identification""Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /* %JoinFKPK(:%New,BookAuth," = "," AND") */
        :new.Author_Identification = BookAuth.Author_Identification AND
        :new.Book_Identification = BookAuth.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Rylty_Pmt because BookAuth does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Rylty  Rylty_Pmt on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Rylty"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rylty_Rylty_Pmt", FK_COLUMNS="Royalty_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Rylty
      WHERE
        /* %JoinFKPK(:%New,Rylty," = "," AND") */
        :new.Royalty_Identification = Rylty.Royalty_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Rylty_Pmt because Rylty does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Rylty_Pmt AFTER UPDATE ON Rylty_Pmt for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Rylty_Pmt 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* BookAuth  Rylty_Pmt on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002473b", PARENT_OWNER="", PARENT_TABLE="BookAuth"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuth_Rylty_Pmt", FK_COLUMNS="Author_Identification""Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM BookAuth
    WHERE
      /* %JoinFKPK(:%New,BookAuth," = "," AND") */
      :new.Author_Identification = BookAuth.Author_Identification AND
      :new.Book_Identification = BookAuth.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Rylty_Pmt because BookAuth does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Rylty  Rylty_Pmt on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Rylty"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rylty_Rylty_Pmt", FK_COLUMNS="Royalty_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Rylty
    WHERE
      /* %JoinFKPK(:%New,Rylty," = "," AND") */
      :new.Royalty_Identification = Rylty.Royalty_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Rylty_Pmt because Rylty does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Reporting_Structure BEFORE INSERT ON Reporting_Structure for each row
-- erwin Builtin Trigger
-- INSERT trigger on Reporting_Structure 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Emp  Reporting_Structure on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00020b35", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
    SELECT count(*) INTO NUMROWS
      FROM Emp
      WHERE
        /* %JoinFKPK(:%New,Emp," = "," AND") */
        :new.Reports_To = Emp.Employee_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reporting_Structure because Emp does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Emp  Reporting_Structure on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
    SELECT count(*) INTO NUMROWS
      FROM Emp
      WHERE
        /* %JoinFKPK(:%New,Emp," = "," AND") */
        :new.Manager = Emp.Employee_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reporting_Structure because Emp does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Reporting_Structure AFTER UPDATE ON Reporting_Structure for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Reporting_Structure 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Emp  Reporting_Structure on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002192c", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
  SELECT count(*) INTO NUMROWS
    FROM Emp
    WHERE
      /* %JoinFKPK(:%New,Emp," = "," AND") */
      :new.Reports_To = Emp.Employee_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reporting_Structure because Emp does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Emp  Reporting_Structure on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Emp"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
  SELECT count(*) INTO NUMROWS
    FROM Emp
    WHERE
      /* %JoinFKPK(:%New,Emp," = "," AND") */
      :new.Manager = Emp.Employee_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reporting_Structure because Emp does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/


