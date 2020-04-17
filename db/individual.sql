SELECT * FROM sale;

SELECT * FROM film;

SELECT * FROM SHOWING;

SELECT * FROM RATINGS;

SELECT * FROM REVIEWERS;

SELECT max(to_number(film_id)) FROM db2dtlabb3.film;

--CREATE OR REPLACE FUNCTION updateFilm(
--	goalOutdraw IN NUMBER)
--	RETURN varchar 
--	IS updating varchar;
--
--	DECLARE
--		countBasic integer;
--		countPremium integer;
--
--BEGIN
--	SELECT to_number(basic_sales) INTO countBasic FROM db2dtlabb3.sale;
--	SELECT to_number(premium_sales) INTO countPremium FROM db2dtlabb3.sale;
--
--	updating := 'FALSE';
--	IF countBasic+countPremium > goalOutdraw THEN
--		updating := 'TRUE';
--	ELSE
--		updating := 'FALSE';
--	END IF;
--
--	RETURN (updating);
--
--	COMMIT;
--EXCEPTION
--	WHEN OTHERS THEN
--		dbms_output.putt_line(SQLCODE|| ' has occurred meaning ' || SQLERRM);
--		ROLLBACK;
--END;
CREATE OR REPLACE function newFilm(
--   filmID film.film_id%type,
   MovieName film.film_name%type,
   MovieRatings film.film_ratings%type,
   runningTime film.film_length%type,
--   ratingsID film.ratings_id%type,
   releaseDate film.FILM_STARTDATE%type
) RETURN boolean as 
	v_number integer;
	lastID varchar;
	filmID film.film_id%TYPE;
  	ratingsID film.film_ratings_id%TYPE;
	
    --updat varchar(20);
BEGIN
	SELECT max(to_number(film_id))+1 INTO filmID FROM film;
	SELECT concat(film_id, 'X1') INTO ratingsID FROM film;
	INSERT INTO FILM(Film_ID, Film_Name, Film_Ratings, Film_Length, Ratings_ID, Film_StartDate) VALUES (filmID, MovieName, MovieRatings, runningTime, ratingsID, releaseDate);
	RETURN (TRUE);
   COMMIT;
EXCEPTION
WHEN OTHERS THEN
--   dbms_ouput.put_line(SQLCODE|| 'has occured meaning '|| SQLERRM);
   RETURN (FALSE);
   ROLLBACK;
END;


CREATE OR REPLACE function ratingInsert(
   ratingsID ratings.ratings_id%type,
   priority_ratings ratings.priority_ratings%type,
   reviewerID ratings.REVIEWER_ID%type
) RETURN boolean as
   countReviewer integer;

BEGIN
   SELECT count(reviewer_id) INTO countReviewer FROM REVIEWERS WHERE reviewerID = reviewer_id;

   IF countReviewer > 0 THEN
      INSERT INTO RATINGS VALUES(ratingsID, priority_ratings, reviewerID);
      RETURN TRUE;
   END IF;
   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
--      dbms_output.put_line(SQLCODE||' has occured meaning '||SQLERRM);
      RETURN FALSE;
      ROLLBACK;
END;
--

SELECT * FROM ratings;

SELECT max(to_number(film_id)) FROM film;

SELECT * FROM ratings;
--