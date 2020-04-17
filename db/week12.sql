create table bk_book_log(
    ISBN    varchar(26),
    PUBID   number(6),
    username    varchar(255),
    insertedTime    date
);

/

create or replace trigger bk_book_log_trig
AFTER INSERT ON BK_BOOK
for each row
    begin
        insert into bk_book_log values(:NEW.isbn, :NEW.pubid, TO_CHAR(USER), SYSDATE);
    end;

/
create or replace trigger bk_review_bir
before insert on bk_review
    for each row
        declare
        NOT_NULL_PUBID EXCEPTION;
        re_pubid bk_book.pubid%type;
        begin
            select pubid into re_pubid from bk_book where isbn = :new.isbn;
            IF re_pubid is null then
                raise NOT_NULL_PUBID;
            END IF;
            EXCEPTION
                WHEN NOT_NULL_PUBID THEN
                    DBMS_OUTPUT.PUT_LINE('Book Cannot Be Reviewed until published');
                    RAISE_APPLICATION_ERROR(-20010, 'Book Cannot be reviewed until published');
    end;    
/
insert into bk_book values('1234T', null, 'jungsoo kim', 1400, 1999);
insert into bk_review values(200, '1234T', 'that was good', 'sdf');
/
select * from bk_book_log;