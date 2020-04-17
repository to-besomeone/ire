alter session set current_schema = builder2;

DECLARE
v_scode pobryne.sale.stock_code%TYPE:=&Enter_Stock_Code;
v_staff pobyrne.sale.staff_no%TYPE:=&Enter_Staff_No;
v_qty integer:=&Enter_amount;
v_staffcount integer;
v_qtyinstock integer;

BEGIN
	SELECT count(*) INTO v_staffcount FROM pobyrne.staff
	WHERE staff_no=v_sno;

	if(v_staffcount = 0) THEN
		dbms_output.put_line('There is no such staff member');
	ELSE
		SELECT count(*) INTO v_stockcount FROM pobyrne.stock
		WHERE stock_code = v_scode;
		IF v_stockcount = 0 THEN dbms_output.put_line('There is no such stock item');
		ELSE
			SELECT quantityinstock INTO v_qtyinstock FROM stock
			WHERE stock_code = v_scode;
			IF v_qtyinstock >= v_qty THEN
				INSERT INTO sale values(v_scode, v_sno, sysdate, v_qty);
				UPDATE STOCK
					SET quantityinstock = quantityinstock - v_qty
				WHERE stock_code = v_scode;
				COMMIT;
			END IF;
		END IF;
	END IF;

EXCEPTION
WHEN OTHERS THEN
	dbms_output.put_line(SQLCODE||' has occurred meaning '|| SQLERRM);
	ROLLBACK;
END


SET serveroutput ON
DECLARE
	V_CID customer.customer_id%TYPE:=&EnterCustomerId;
	V_CNAME customer.customer_name%TYPE;
	V_CADDR customer.customer_address%TYPE;
	
BEGIN
	SELECT customer_name, customer_address INTO V_CNAME, V_CADDR
	FROM customer
	WHERE customer_id = v_cid;

	dbms_output.put_line(V_CNAME||'lives IN '||V_CADDR);
EXCEPTION
WHEN OTHERS THEN
	dbms_output.put_line(SQLCODE||' has occurred meaning '|| SQLERRM);
	ROLLBACK;

END