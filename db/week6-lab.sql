ALTER SESSION SET current_schema = jkim;

CREATE OR replace FUNCTION findBook(
	t_isbn IN pobyrne.bk_book.ISBN%TYPE, 
	t_categoryID IN pobyrne.bk_bookcategory.CategoryId%TYPE
	) RETURN varchar as	exist varchar;

DECLARE
	countisbn integer;
	countcategoryid integer;
--	exist boolean;
	
BEGIN
	exist:='FALSE';

	SELECT count(*) INTO countisbn FROM pobyrne.bk_book WHERE ISBN=t_isbn;
	SELECT count(*) INTO countcategory FROM POBYRNE.bk_bookcategory WHERE CategoryId = t_categoryID;

	IF countisbn>0 THEN
		exist:='TRUE';
		return(exist);
	END IF;
	
	IF countcategory > 0 THEN
		exist:='TRUE';
		RETURN(exist);
	END IF;
	
	IF countisbn>0 AND countcategory>0 THEN 
		exist := 'TRUE';
		RETURN (exist);
	END IF;
	
	ELSE THEN
		RETURN (exist);
	
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
END;

