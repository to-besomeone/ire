select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid); 

 

select * from (pobyrne.bk_bookauthor left join pobyrne.bk_book using (isbn)) left join pobyrne.bk_author using (authid); 

--1

select title from (pobyrne.bk_bookauthor left join pobyrne.bk_book using (isbn)) left join pobyrne.bk_author using (authid) where authname = 'J.K. Rowling';

 

--2

select authname from pobyrne.bk_author
where authid not in (select authid from pobyrne.bk_bookauthor);

 

--3

select authname from (pobyrne.bk_book join pobyrne.bk_bookauthor using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1998;

 

--4

select authname from (pobyrne.bk_book join pobyrne.bk_bookauthor using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1999;

 

--5

select authname, year_published from (pobyrne.bk_book left join pobyrne.bk_bookauthor using (isbn)) left join pobyrne.bk_author using (authid)
where year_published = 1998 or year_published = 1999;

 

--6

(select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1998
union
select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1999)
minus
(select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1999);

--7

(select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1998
union
select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1999)
minus
(select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1998);

 

--8

 

(select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1998
union
select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1999)
minus
(select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1998
intersect
select authname from (pobyrne.bk_bookauthor join pobyrne.bk_book using (isbn)) join pobyrne.bk_author using (authid)
where year_published = 1999);

SELECT categoryid FROM pobyrne.bk_bookcategory;

SELECT * FROM pobyrne.bk_book JOIN pobyrne.BK_BOOKCATEGORY USING (isbn);

--9

select title from (pobyrne.bk_book left join pobyrne.bk_bookinformat using (isbn)) left join pobyrne.bk_bookformat using (bformat)
where bformat = 'SFBK'
intersect
select title from (pobyrne.bk_book left join pobyrne.bk_bookinformat using (isbn)) left join pobyrne.bk_bookformat using (bformat)
where bformat = 'ELEC'
intersect
select title from (pobyrne.bk_book left join pobyrne.bk_bookinformat using (isbn)) left join pobyrne.bk_bookformat using (bformat)
where bformat = 'HDBK';

SELECT isbn FROM pobyrne.bk_book;