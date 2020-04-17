-- grant select on md_doctor to public;
SELECT * FROM pobyrne.md_patient;

-- 1. WRITE SQL TO RETURN a list OF patient name that see Dr.Zhivago

SELECT p_name
FROM (pobyrne.md_doctor JOIN pobyrne.md_sees USING (d_id)) JOIN POBYRNE.MD_PATIENT USING (p_id)
WHERE d_name = 'Dr. Zhivago';

-------------------------

SELECT p_name FROM pobyrne.md_patient JOIN pobyrne.md_sees USING (p_id) WHERE d_id=1;

SELECT p_name FROM pobyrne.md_patient 
JOIN pobyrne.md_sees USING (p_id) 
JOIN pobyrne.md_doctor USING (d_id)
WHERE d_name LIKE 'Dr. Zhivago';

-- 2. Write SQL to return a list of names of doctors who see all patient names.

(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 1)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 2)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 3)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 4)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 5)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 6)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 7)
INTERSECT
(SELECT d_name FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id = 8);

SELECT * FROM POBYRNE.MD_PATIENT;

SELECT * FROM pobyrne.md_doctor JOIN POBYRNE.MD_SEES USING (d_id);

SELECT d_name FROM pobyrne.md_doctor d
WHERE NOT EXISTS (SELECT * FROM pobyrne.md_patient p
WHERE NOT EXISTS (SELECT * FROM pobyrne.md_sees s WHERE (s.d_id = d.d_id AND s.p_id = p.p_id)));

-- 3. WRITE SQL TO RETURN a list OF names OF doctors who don't see patients

SELECT d_name FROM POBYRNE.MD_DOCTOR LEFT JOIN POBYRNE.MD_SEES USING (d_id) WHERE p_id IS null;

--3a
SELECT d_name FROM pobyrne.md_doctor d
WHERE NOT EXISTS (SELECT * FROM POBYRNE.MD_SEES s WHERE s.d_id = d.d_id);

--3b
SELECT d_name FROM pobyrne.md_doctor d LEFT JOIN pobyrne.md_sees s USING (d_id)
WHERE s.p_id IS NULL;

--3c
SELECT d_name FROM pobyrne.md_doctor d WHERE d.d_id NOT IN
(SELECT d_id FROM pobyrne.md_sees);

--3d
SELECT d_name FROM pobyrne.md_doctor
MINUS
SELECT d_name FROM pobyrne.md_doctor JOIN pobyrne.md_sees USING (d_id);

-- 4. WRITE SQL TO RETURN a list OF patient names that see Dr.Zhivago AND Dr. NO

(SELECT p_name
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.md_doctor USING (d_id)
WHERE d_name = 'Dr. Zhivago')
INTERSECT
(SELECT P_NAME
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. No');

--4a
SELECT p_name FROM pobyrne.md_patient p
JOIN pobyrne.md_sees s USING (p_id)
JOIN pobyrne.md_doctor d USING (d_id)
WHERE d_name LIKE 'Dr. No'
intersect
SELECT p_name FROM pobyrne.md_patient p
JOIN pobyrne.md_sees s USING (p_id)
JOIN pobyrne.md_doctor d USING (d_id)
WHERE d_name LIKE 'Dr. No';

--4b using view
CREATE VIEW drpatient AS
SELECT p_name, d_name FROM pobyrne.md_patient p
JOIN pobyrne.md_sees s USING (p_id)
JOIN pobyrne.md_doctor d USING (d_id);

SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. No'
INTERSECT
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. Zhivago';


-- 5. WRITE SQL TO RETURN a list OF patient names that see Dr. Zhivago but NOT Dr.NO

(SELECT p_name
FROM (pobyrne.md_patient JOIN pobyrne.MD_SEES USING (p_id)) JOIN POBYRNE.md_doctor USING (d_id)
WHERE d_name = 'Dr. Zhivago')
MINUS
(SELECT P_NAME
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. No');

SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. Zhivago'
MINUS
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. No';

-- 6. WRITE SQL TO RETURN a list OF patient names that see either Dr.Zhivago OR Dr.NO

(SELECT p_name
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. Zhivago')
UNION
(SELECT P_NAME
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. No');

--6a
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. Zhivago'
UNION
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. No';

--6b ??
--SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. Zhivago' OR d_name LIKE 'Dr. No';


-- 7. WRITE SQL TO RETURN a list OF patient names that see either Dr.Zhivago OR Dr.NO, but NOT BOTH

((SELECT p_name
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. Zhivago')
UNION
(SELECT P_NAME
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. No'))
MINUS
((SELECT p_name
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. Zhivago')
INTERSECT
(SELECT P_NAME
FROM (POBYRNE.MD_PATIENT JOIN POBYRNE.MD_SEES USING (p_id)) JOIN POBYRNE.MD_DOCTOR USING (d_id)
WHERE d_name = 'Dr. No'));

--7a
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. Zhivago' OR d_name LIKE 'Dr. No';

--7b
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr.Zhivago' OR d_name LIKE 'Dr. No'
MINUS
(SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. Zhivago'
INTERSECT
SELECT p_name FROM drpatient WHERE d_name LIKE 'Dr. No');

-- 8. WRITE SQL TO RETURN a list OF doctors names AND the names OF patients they see, INCLUDING doctors who see NO patients.

SELECT d_name, p_name
FROM (POBYRNE.MD_DOCTOR LEFT JOIN POBYRNE.MD_SEES USING (d_id)) LEFT JOIN POBYRNE.MD_PATIENT USING (p_id);

SELECT * FROM pobyrne.md_doctor;
SELECT * FROM pobyrne.md_sees;

SELECT * FROM pobyrne.md_doctor, pobyrne.md_sees;

SELECT * FROM pobyrne.md_doctor JOIN pobyrne.md_sees USING (d_id);

SELECT * FROM (POBYRNE.MD_DOCTOR LEFT JOIN POBYRNE.MD_SEES USING (d_id));

SELECT * FROM pobyrne.md_sees LEFT JOIN pobyrne.md_doctor USING (d_id);

--8a
SELECT d_name, p_name FROM pobyrne.md_doctor d
LEFT JOIN POBYRNE.MD_SEES s USING (d_id)
LEFT JOIN POBYRNE.md_patient p USING (p_id)
ORDER BY d_name;

--9. WRITE SQL TO RETURN a list OF names OF doctors who have seen MORE than four patients
-- ?????
DECLARE
p_cnt integer;

BEGIN
	SELECT d_name FROM pobyrne.md_doctor JOIN md_sees USING (d_id)
	WHERE 	SELECT count(p_id) INTO p_cnt FROM POBYRNE.MD_DOCTOR JOIN POBYRNE.MD_SEES USING (d_id)
	WHERE ;

END

--9a
SELECT d_name FROM pobyrne.md_doctor d
JOIN pobyrne.md_sees s USING (d_id)
GROUP BY d_name
HAVING count(DISTINCT p_id) > 4;


--번외 : d로 시작하는 의사들에게 진료를 보지 않은 환자

INSERT INTO md_doctor VALUES (9, 'Dr. Dunne');
INSERT INTO md_sees VALUES (9, 1, sysdate);

CREATE VIEW d_doct AS
SELECT * FROM md_doctor d WHERE d_name LIKE 'Dr. d%';

--version1
SELECT p_name FROM md_patient p
WHERE EXISTS (
SELECT * FROM md_doctor d WHERE d_name LIKE 'Dr. D%'
AND NOT exists(
SELECT * FROM md_sees WHERE
s.p_id = p.p_id AND s.d_id = d.d_id));

--version2
SELECT p_name FROM md_patient p
WHERE not EXISTS (
SELECT * FROM md_doct d WHERE NOT exists(
SELECT * FROM md_sees WHERE
s.p_id = p.p_id AND s.d_id = d.d_id));




---------------------week2
--1
SELECT title 
FROM pobyrne.bk_book JOIN pobyrne.bk_bookauthor USING (isbn)
JOIN pobyrne.bk_author using(authid)
WHERE authname = 'J.K. Rowling';

--2
SELECT authname
FROM pobyrne.bk_author LEFT JOIN pobyrne.bk_bookauthor USING (authid)
LEFT JOIN pobyrne.bk_book USING (isbn)
WHERE isbn IS null;

--3
SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1998;

--4
SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1999;

--5
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1998)
INTERSECT
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1999);

--6
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1998)
MINUS
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1999);


--7
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1999)
MINUS
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1998);

--8
((SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1998)
UNION
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1999))
MINUS
((SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1998)
INTERSECT
(SELECT authname
FROM POBYRNE.bk_author JOIN POBYRNE.bk_bookauthor USING (authid)
JOIN pobyrne.bk_book USING (ISBN)
WHERE year_published=1999));

--9
CREATE VIEW format AS
SELECT * FROM POBYRNE.bk_book JOIN pobyrne.bk_bookinformat USING (isbn)
JOIN pobyrne.bk_bookformat USING (bformat);

SELECT title FROM pobyrne.bk_book b
WHERE NOT EXISTS (SELECT * FROM pobyrne.bk_bookformat f
WHERE NOT EXISTS (SELECT * FROM pobyrne.bk_bookinformat i WHERE f.bformat=i.bformat AND b.isbn=i.isbn));

----------------------------
--practice

--1
SELECT p_name
FROM pobyrne.md_doctor JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. Zhivago';

--2
SELECT d_name FROM POBYRNE.md_doctor d
WHERE NOT EXISTS (SELECT * FROM pobyrne.md_patient p
WHERE NOT EXISTS (SELECT * FROM pobyrne.md_sees s WHERE p.p_id=s.p_id AND s.d_id=d.d_id));

--3
SELECT d_name FROM pobyrne.md_doctor d
WHERE NOT EXISTS (SELECT * FROM pobyrne.md_sees s WHERE d.d_id=s.d_id);

--4
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. Zhivago'
INTERSECT
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. No';

--5
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. Zhivago'
MINUS
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. No';

--6
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. Zhivago'
UNION
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. No';

--7
(SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. Zhivago'
UNION
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. No')
MINUS
(SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. Zhivago'
INTERSECT
SELECT p_name FROM pobyrne.md_doctor
JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
WHERE d_name = 'Dr. No')

--8
SELECT d_name, p_name FROM pobyrne.md_doctor LEFT JOIN pobyrne.md_sees USING (d_id)
LEFT JOIN pobyrne.md_patient USING (p_id);

--9
SELECT d_name
FROM pobyrne.md_doctor JOIN pobyrne.md_sees USING (d_id)
JOIN pobyrne.md_patient USING (p_id)
GROUP BY d_name
HAVING count(p_id) > 4;