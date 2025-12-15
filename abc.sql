
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
(Auth_Id   ASC);

ALTER TABLE Auth
	ADD CONSTRAINT  UPKCL_auidind PRIMARY KEY (Auth_Id);

CREATE INDEX aunmind ON Auth
(Auth_Lst_Nam   ASC,Auth_Frst_Nam   ASC);

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
(Book_Id   ASC);

ALTER TABLE Book
	ADD CONSTRAINT  UPKCL_titleidind PRIMARY KEY (Book_Id);

CREATE INDEX titleind ON Book
(Book_Nam   ASC);

CREATE TABLE BookAuth
(
	Auth_Id              CHAR(9)  NOT NULL ,
	Book_Id              CHAR(9)  NOT NULL 
);

CREATE UNIQUE INDEX UPKCL_taind ON BookAuth
(Auth_Id   ASC,Book_Id   ASC);

ALTER TABLE BookAuth
	ADD CONSTRAINT  UPKCL_taind PRIMARY KEY (Auth_Id,Book_Id);

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
(Ordr_Nbr   ASC);

ALTER TABLE Purchase_Ordr
	ADD CONSTRAINT  UPKCL_sales PRIMARY KEY (Ordr_Nbr);

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

ALTER TABLE Book
	ADD (
CONSTRAINT FK_Publshr_Book FOREIGN KEY (Publshr_Id) REFERENCES Publshr (Publshr_Id));

ALTER TABLE BookAuth
	ADD (
CONSTRAINT FK_Auth_BookAuth FOREIGN KEY (Auth_Id) REFERENCES Auth (Auth_Id));

ALTER TABLE BookAuth
	ADD (
CONSTRAINT FK_Book_BookAuth FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id));

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
    /* ERWIN_RELATION:CHECKSUM="0000d604", PARENT_OWNER="", PARENT_TABLE="Auth"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Auth_Id" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Auth_Id = :old.Auth_Id;
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
  /* ERWIN_RELATION:CHECKSUM="0000fae3", PARENT_OWNER="", PARENT_TABLE="Auth"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Auth_Id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Auth_Id <> :new.Auth_Id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Auth_Id = :old.Auth_Id;
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




CREATE  TRIGGER  tD_Book AFTER DELETE ON Book for each row
-- erwin Builtin Trigger
-- DELETE trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  BookAuth on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002bc8b", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Id" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Book_Id = :old.Book_Id;
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
    FK_CONSTRAINT="FK_Book_Book_YTD_Sls", FK_COLUMNS="Book_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Book_YTD_Sls
      WHERE
        /*  %JoinFKPK(Book_YTD_Sls,:%Old," = "," AND") */
        Book_YTD_Sls.Book_Id = :old.Book_Id;
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
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Book_Id = :old.Book_Id;
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
    /* ERWIN_RELATION:CHECKSUM="0000dac0", PARENT_OWNER="", PARENT_TABLE="Publshr"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publshr_Book", FK_COLUMNS="Publshr_Id" */
    UPDATE Book
      SET
        /* %SetFK(Book,NULL) */
        Book.Publshr_Id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Publshr
            WHERE
              /* %JoinFKPK(:%New,Publshr," = "," AND") */
              :new.Publshr_Id = Publshr.Publshr_Id
        ) 
        /* %JoinPKPK(Book,:%New," = "," AND") */
         and Book.Book_Id = :new.Book_Id;


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
  /* ERWIN_RELATION:CHECKSUM="000417aa", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Id <> :new.Book_Id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM BookAuth
      WHERE
        /*  %JoinFKPK(BookAuth,:%Old," = "," AND") */
        BookAuth.Book_Id = :old.Book_Id;
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
    FK_CONSTRAINT="FK_Book_Book_YTD_Sls", FK_COLUMNS="Book_Id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Id <> :new.Book_Id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Book_YTD_Sls
      WHERE
        /*  %JoinFKPK(Book_YTD_Sls,:%Old," = "," AND") */
        Book_YTD_Sls.Book_Id = :old.Book_Id;
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
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Id <> :new.Book_Id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Book_Id = :old.Book_Id;
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
    FK_CONSTRAINT="FK_Publshr_Book", FK_COLUMNS="Publshr_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Publshr
    WHERE
      /* %JoinFKPK(:%New,Publshr," = "," AND") */
      :new.Publshr_Id = Publshr.Publshr_Id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Publshr_Id IS NOT NULL AND
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




CREATE  TRIGGER  tD_BookAuth AFTER DELETE ON BookAuth for each row
-- erwin Builtin Trigger
-- DELETE trigger on BookAuth 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* BookAuth  Rylty_Pmt on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f093", PARENT_OWNER="", PARENT_TABLE="BookAuth"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuth_Rylty_Pmt", FK_COLUMNS="Auth_Id""Book_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Rylty_Pmt
      WHERE
        /*  %JoinFKPK(Rylty_Pmt,:%Old," = "," AND") */
        Rylty_Pmt.Auth_Id = :old.Auth_Id AND
        Rylty_Pmt.Book_Id = :old.Book_Id;
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
    /* ERWIN_RELATION:CHECKSUM="0001d37c", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuth"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Id = Book.Book_Id;
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
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Auth_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Auth
      WHERE
        /* %JoinFKPK(:%New,Auth," = "," AND") */
        :new.Auth_Id = Auth.Auth_Id;
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
  /* ERWIN_RELATION:CHECKSUM="0003105b", PARENT_OWNER="", PARENT_TABLE="BookAuth"
    CHILD_OWNER="", CHILD_TABLE="Rylty_Pmt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuth_Rylty_Pmt", FK_COLUMNS="Auth_Id""Book_Id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Auth_Id <> :new.Auth_Id OR 
    :old.Book_Id <> :new.Book_Id
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Rylty_Pmt
      WHERE
        /*  %JoinFKPK(Rylty_Pmt,:%Old," = "," AND") */
        Rylty_Pmt.Auth_Id = :old.Auth_Id AND
        Rylty_Pmt.Book_Id = :old.Book_Id;
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
    FK_CONSTRAINT="FK_Book_BookAuth", FK_COLUMNS="Book_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Id = Book.Book_Id;
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
    FK_CONSTRAINT="FK_Auth_BookAuth", FK_COLUMNS="Auth_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Auth
    WHERE
      /* %JoinFKPK(:%New,Auth," = "," AND") */
      :new.Auth_Id = Auth.Auth_Id;
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
    /* ERWIN_RELATION:CHECKSUM="0000e256", PARENT_OWNER="", PARENT_TABLE="Rgn"
    CHILD_OWNER="", CHILD_TABLE="Stor_Nam"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Rgn_Stor_Nam", FK_COLUMNS="Rgn_Id" */
    UPDATE Stor_Nam
      SET
        /* %SetFK(Stor_Nam,NULL) */
        Stor_Nam.Rgn_Id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Rgn
            WHERE
              /* %JoinFKPK(:%New,Rgn," = "," AND") */
              :new.Rgn_Id = Rgn.Rgn_Id
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
  /* ERWIN_RELATION:CHECKSUM="000216c7", PARENT_OWNER="", PARENT_TABLE="Stor_Nam"
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
    FK_CONSTRAINT="FK_Rgn_Stor_Nam", FK_COLUMNS="Rgn_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Rgn
    WHERE
      /* %JoinFKPK(:%New,Rgn," = "," AND") */
      :new.Rgn_Id = Rgn.Rgn_Id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Rgn_Id IS NOT NULL AND
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
    /* ERWIN_RELATION:CHECKSUM="0000ebdc", PARENT_OWNER="", PARENT_TABLE="Purchase_Ordr"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Ordr_Ordr_Itm", FK_COLUMNS="Ordr_Nbr" */
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Ordr_Nbr = :old.Ordr_Nbr;
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
    /* ERWIN_RELATION:CHECKSUM="0001fa1e", PARENT_OWNER="", PARENT_TABLE="Cust"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Ordr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Cust_Purchase_Ordr", FK_COLUMNS="Cust_Id" */
    UPDATE Purchase_Ordr
      SET
        /* %SetFK(Purchase_Ordr,NULL) */
        Purchase_Ordr.Cust_Id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Cust
            WHERE
              /* %JoinFKPK(:%New,Cust," = "," AND") */
              :new.Cust_Id = Cust.Cust_Id
        ) 
        /* %JoinPKPK(Purchase_Ordr,:%New," = "," AND") */
         and Purchase_Ordr.Ordr_Nbr = :new.Ordr_Nbr;

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
  /* ERWIN_RELATION:CHECKSUM="0003283d", PARENT_OWNER="", PARENT_TABLE="Purchase_Ordr"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Ordr_Ordr_Itm", FK_COLUMNS="Ordr_Nbr" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Ordr_Nbr <> :new.Ordr_Nbr
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Ordr_Itm
      WHERE
        /*  %JoinFKPK(Ordr_Itm,:%Old," = "," AND") */
        Ordr_Itm.Ordr_Nbr = :old.Ordr_Nbr;
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
    FK_CONSTRAINT="FK_Cust_Purchase_Ordr", FK_COLUMNS="Cust_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Cust
    WHERE
      /* %JoinFKPK(:%New,Cust," = "," AND") */
      :new.Cust_Id = Cust.Cust_Id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Cust_Id IS NOT NULL AND
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
    /* ERWIN_RELATION:CHECKSUM="000311d0", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Ordr_Itm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Id" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Id = Book.Book_Id;
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
    FK_CONSTRAINT="FK_Disc_Ordr_Itm", FK_COLUMNS="Disc_Typ" */
    UPDATE Ordr_Itm
      SET
        /* %SetFK(Ordr_Itm,NULL) */
        Ordr_Itm.Disc_Typ = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Disc
            WHERE
              /* %JoinFKPK(:%New,Disc," = "," AND") */
              :new.Disc_Typ = Disc.Disc_Typ
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
        :new.Ordr_Nbr = Purchase_Ordr.Ordr_Nbr;
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
  /* ERWIN_RELATION:CHECKSUM="00069142", PARENT_OWNER="", PARENT_TABLE="Ordr_Itm"
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
    FK_CONSTRAINT="FK_Book_Ordr_Itm", FK_COLUMNS="Book_Id" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Id = Book.Book_Id;
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
    FK_CONSTRAINT="FK_Disc_Ordr_Itm", FK_COLUMNS="Disc_Typ" */
  SELECT count(*) INTO NUMROWS
    FROM Disc
    WHERE
      /* %JoinFKPK(:%New,Disc," = "," AND") */
      :new.Disc_Typ = Disc.Disc_Typ;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Disc_Typ IS NOT NULL AND
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
      :new.Ordr_Nbr = Purchase_Ordr.Ordr_Nbr;
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


