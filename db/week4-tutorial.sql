CREATE OR REPLACE FUNCTION add_sale(
	p_code sh_stock.stock_code%TYPE,
	p_no sh_staff.staff_no%TYPE,
	p_qty integer) RETURN boolean AS
	
	countstock integer;
	countstaff integer;
	workedok boolean;
	--workedok varchar2(3);
	
BEGIN 
	workedok:=FALSE;
	SELECT count(*) INTO countstock FROM sh_stock WHERE stock_code = p_code;
	IF countstock > 0 THEN
		SELECT count(*) INTO countstaff FROM sh_staff WHERE staff_no = p_no;
	
		IF countstaff > 0 THEN
			INSERT INTO sh_sale values(p_code, p_no, sysdate, p_qty);
			COMMIT;
			workedok := TRUE;
			return(workedok);
		END IF;
	END IF;

EXCEPTION
WHEN OTHERS THEN
	raise;
END;


SET serveroutput ON
DECLARE
	isok boolean;
	scode varchar2(10):='A11111';
	sno integer:=1;
BEGIN
	IF add_sale(scode, sno, 1) THEN
		dbms_output.put_line('worked');
	END IF;
END;

CREATE OR REPLACE FUNCTION staff_exists(p_staff_no sh_staff.staff_no%type) RETURN boolean
AS
vname sh_staff.staff_name%TYPE;

BEGIN
	worked := FALSE;
	SELECT staff_name INTO vname FROM sh_staff
	WHERE staff_no = p_staff_no;
	worked := TRUE;
	RETURN(worked);
EXCEPTION
	WHEN OTHERS THEN
		RETURN(worked);
END;


BEGIN 
	IF stock_exists(p_code) AND staff_exists(p_no) THEN
		INSERT INTO sh_sale values(p_code, p_no, sysdate, p_qty);
		COMMIT;
		workedok:='Yes';
		return(workedok);
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		raise;
END;
END