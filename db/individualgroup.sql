CREATE OR REPLACE function ratingInsertg(
   priority_ratings in db2dtlabb3.ratings.priority_ratings%type,
   reviewerID in db2dtlabb3.ratings.REVIEWER_ID%type
) RETURN varchar2 is
    ret varchar2(10);
   countReviewer number;
   	lastID db2dtlabb3.film.film_id%type;
	filmID db2dtlabb3.film.film_id%TYPE;
  	ratingsID db2dtlabb3.film.ratings_id%TYPE;

BEGIN
    ret:='FALSE';
   select count(*) into countReviewer from db2dtlabb3.reviewers where reviewerID = reviewer_id;

   IF countReviewer > 0 THEN
       SELECT to_char(max(to_number(db2dtlabb3.film.film_id))+1, '99999') INTO filmID FROM db2dtlabb3.film;
--       SELECT concat(filmID, 'X1') INTO ratingsID FROM film;
        ratingsID := concat(filmID, 'X1');
      INSERT INTO db2dtlabb3.RATINGS VALUES(ratingsID, priority_ratings, reviewerID);
      ret:='TRUE';
      commit;
      RETURN ret;
    else
        return ret;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      rollback;
      raise;
END;
/

create or replace function newFilmg(
       MovieName in db2dtlabb3.film.film_name%type,
       MovieRatings in db2dtlabb3.film.film_ratings%type,
       runningTime in db2dtlabb3.film.film_length%type,
       releaseDate in db2dtlabb3.film.FILM_STARTDATE%type,
       endDate in db2dtlabb3.film.FILM_ENDDATE%type
    ) RETURN varchar2 is 
        ret varchar2(10);
        v_number number;
        lastID db2dtlabb3.film.film_id%type;
        filmID db2dtlabb3.film.film_id%TYPE;
        ratingsID db2dtlabb3.film.ratings_id%TYPE;
    BEGIN
        ret:='FALSE';
        select count(*) into v_number from db2dtlabb3.film where filmID = film_id;
        if v_number = 0 then
            ret := 'TRUE';
            SELECT to_char(max(to_number(db2dtlabb3.film.film_id))+1, '99999') INTO filmID FROM db2dtlabb3.film;
            ratingsID := concat(filmID, 'X1');
            INSERT INTO db2dtlabb3.FILM VALUES (filmID, MovieName, MovieRatings, runningTime, ratingsID, releaseDate, endDate);
            commit;
            return ret;
        else
            return ret;
        end if;
EXCEPTION
    WHEN OTHERS THEN
        rollback;
        raise;
END;
/


create or replace function updateFilmg(
    MovieName in db2dtlabb3.film.film_name%type,
    goal in number
) return varchar2 is
    ret varchar2(30);
    sales number;
    newEnd db2dtlabb3.film.film_enddate%type;
    begin
        ret:='FALSE';
        select to_number(basic_sales)+to_number(premium_sales) into sales from db2dtlabb3.film left join db2dtlabb3.sale using(film_id) where Film_Name = MovieName;
        if sales > goal then
            select to_char(to_date((select film_enddate from db2dtlabb3.film where Film_Name = MovieName))+interval '7' day, 'yyyy/mm/dd') into newEnd from db2dtlabb3.film left join db2dtlabb3.sale using(film_id) where Film_Name = MovieName;
            UPDATE db2dtlabb3.FILM SET FILM_ENDDATE = newEnd where Film_Name = MovieName;
            ret := 'TRUE';
            commit;
            return ret;
        else
            return ret;
        end if;
EXCEPTION
    WHEN OTHERS THEN
        rollback;
        raise;
END;

/

select * from db2dtlabb3.ratings;

select * from db2dtlabb3.film;