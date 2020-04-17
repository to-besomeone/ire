DROP TABLE bk_bookauthor CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_author CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_BookCategory CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_Category CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_review CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_BookInFormat CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_Book CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_publisher CASCADE CONSTRAINTS PURGE;
DROP TABLE bk_bookformat CASCADE CONSTRAINTS PURGE;
CREATE TABLE bk_bookformat
(
	BFormat		  CHAR(4)  NOT NULL ,
	FormatDesc	  VARCHAR2(50)  NULL 
);

insert into bk_bookformat values ('HDBK','Hardback');

insert into bk_bookformat values ('SFBK','Softback');

insert into bk_bookformat values ('ELEC','Electronic');
ALTER TABLE bk_bookformat
	ADD CONSTRAINT  XPKbookformat PRIMARY KEY (BFormat);



CREATE TABLE bk_publisher
(
	PubId		  NUMBER(6)  NOT NULL ,
	PubName		  VARCHAR2(50)  NULL ,
	ppassword	  VARCHAR2(15)  NULL ,
	date_added	  date  NULL 
);
drop sequence pubseq;
create sequence pubseq start with 100000;


ALTER TABLE bk_publisher
	ADD CONSTRAINT  XPKpublisher PRIMARY KEY (PubId);


insert into bk_publisher values (pubseq.nextval, 'Bloomsbury','password',SYSDATE-7500);
insert into bk_publisher values (pubseq.nextval, 'Harper Collins','password',SYSDATE-7500);
insert into bk_publisher values (pubseq.nextval, 'Penguin','password',SYSDATE-7500);
CREATE TABLE bk_Book
(
	isbn		  CHAR(26)  NOT NULL ,
	PubId		  NUMBER(6)  ,
	title		  VARCHAR2(90)  NOT NULL ,
	NoPages		  NUMBER(38)  NULL ,
	year_published	  number(4)  NULL ,
CONSTRAINT  R_12 FOREIGN KEY (PubId) REFERENCES bk_publisher(PubId)
);
insert into bk_Book values ('1234567X',100000,'No. 1 Book',400,2010);
insert into bk_Book values ('1234568X',100000,'No. 2 Book',400, 2000);


ALTER TABLE bk_Book
	ADD CONSTRAINT  XPKbook PRIMARY KEY (isbn);



CREATE TABLE bk_BookInFormat
(
	BFormat		  CHAR(4)  NOT NULL ,
	isbn		  CHAR(26)  NOT NULL ,
	Price		  NUMBER(7,2)  NULL ,
	date_released	  DATE  NULL ,
CONSTRAINT  R_8 FOREIGN KEY (BFormat) REFERENCES bk_bookformat(BFormat),
CONSTRAINT  R_9 FOREIGN KEY (isbn) REFERENCES bk_Book(isbn)
);
ALTER TABLE bk_BookInFormat
	ADD CONSTRAINT  XPKbk_BookInFormat PRIMARY KEY (BFormat,isbn);


insert into bk_BookInFormat values ('HDBK','1234567X',15,SYSDATE-3600);
insert into bk_BookInFormat values ('HDBK','1234568X',15,SYSDATE-3600);
insert into bk_BookInFormat values ('SFBK','1234567X',10,SYSDATE-3600);
insert into bk_BookInFormat values ('ELEC','1234567X',5,SYSDATE-360);

CREATE TABLE bk_review
(
	ReviewNo	  NUMBER(3)  NOT NULL ,
	isbn		  CHAR(26)  NOT NULL ,
	ReviewContent	  VARCHAR2(255)  NULL ,
	r_e_mail	  VARCHAR2(20)  NULL ,
CONSTRAINT  R_7 FOREIGN KEY (isbn) REFERENCES bk_book(isbn)
);



ALTER TABLE bk_review
	ADD CONSTRAINT  XPKReview PRIMARY KEY (ReviewNo,isbn);



CREATE TABLE bk_Category
(
	categoryId	  CHAR(5)  NOT NULL ,
	categoryDesc	  VARCHAR2(50)  NULL 
);


INSERT INTO bk_Category VALUES ('RMNCE','Romance');
INSERT INTO bk_Category VALUES ('CHFIC','Children''s Fiction');
INSERT INTO bk_Category VALUES ('CHADV','Children''s Adventure');
INSERT INTO bk_Category VALUES ('CHDRM','Children''s Drama');
INSERT INTO bk_Category VALUES ('CHMYS','Children''s Mystery');
INSERT INTO bk_Category VALUES ('CHFNT','Children''s Fantasy');
ALTER TABLE bk_Category
	ADD CONSTRAINT  XPKcategory PRIMARY KEY (categoryId);



CREATE TABLE bk_BookCategory
(
	isbn		  CHAR(26)  NOT NULL ,
	categoryid	  CHAR(5)  NOT NULL ,
CONSTRAINT  R_5 FOREIGN KEY (isbn) REFERENCES bk_Book(isbn),
CONSTRAINT  R_6 FOREIGN KEY (categoryid) REFERENCES bk_Category(categoryId)
);
insert into bk_BookCategory values ('1234567X','CHFIC');
insert into bk_BookCategory values ('1234567X','CHADV');
insert into bk_BookCategory values ('1234567X','CHDRM');


ALTER TABLE bk_BookCategory
	ADD CONSTRAINT  XPKbk_BookCategory PRIMARY KEY (isbn,categoryid);



CREATE TABLE bk_author
(
	authid		  NUMBER(6)  NOT NULL ,
	authName	  VARCHAR2(30)  NOT NULL ,
	authBiog	  VARCHAR2(255)  NULL ,
	apassword	  varchar2(15)  NULL 
);
drop sequence authseq;
create sequence authseq start with 10000;
insert into bk_author values (authseq.nextval, 'J.K. Rowling','Great writer','JKR');
insert into bk_author values (authseq.nextval, 'Rick Riordan','','RR');
ALTER TABLE bk_author
	ADD CONSTRAINT  XPKAuthor PRIMARY KEY (authid);



CREATE TABLE bk_bookauthor
(
	isbn		  CHAR(26)  NOT NULL ,
	authid		  NUMBER(6)  NOT NULL ,
CONSTRAINT  R_3 FOREIGN KEY (isbn) REFERENCES bk_Book(isbn),
CONSTRAINT  R_4 FOREIGN KEY (authid) REFERENCES bk_author(authid)
);



ALTER TABLE bk_bookauthor
	ADD CONSTRAINT  XPKbk_bookauthor PRIMARY KEY (isbn,authid);

insert into bk_bookauthor values ('1234567X',10001);
commit;
grant select on bk_book to public;
grant SELECT on  bk_bookauthor to public;
grant SELECT on  bk_author to public;
grant SELECT on  bk_BookCategory to public;
grant SELECT on  bk_Category to public;
grant SELECT on  bk_review to public;
grant SELECT on  bk_BookInFormat to public;
grant SELECT on  bk_Book to public;
grant SELECT on  bk_publisher to public;
grant SELECT on  bk_bookformat to public;


DECLARE
V_ISBN pobyrne.BK_BOOKCATEGORY.ISBN%TYPE:='&Enter_ISBN_number';
V_CID pobyrne.BK_BOOKCATEGORY.categoryid%TYPE:='&Enter_category_id_number';
v_isbncount integer;
v_cidcount integer;

BEGIN
	SELECT count(*) INTO v_isbncount FROM POBYRNE.BK_BOOK
	WHERE isbn=v_isbn;

	IF(v_isbncount != 0) THEN
		dbms_output.put_line('There is already such isbn.');
	ELSE
		SELECT count(*) INTO v_cidcount FROM POBYRNE.BK_BOOK JOIN pobyrne.bk_bookcategory USING isbn
		WHERE categoryid = v_cid;
		IF v_cidcount != 0 THEN
			dbms_output.put_line('There is already such category id');
		ELSE
			INSERT INTO POBYRNE.BK_BOOKCATEGORY values(v_isbn, v_icd);
		COMMIT;
		END IF;
	END IF;
EXCEPTION
WHEN OTHERS THEN
	dbms_output.put_line(SQLCODE|| ' has occurred meaning ' || SQLERRM);
ROLLBACK;
	
END;