set serveroutput on
declare
    ip_cursor pobyrne.bk_category.categorydesc%type := '&input categorydesc';
    cursor categorydescList(ip_category pobyrne.bk_category.categoryid%type) is
        select isbn, title, year_published from pobyrne.bk_bookcategory right join pobyrne.bk_category using (categoryid) right join pobyrne.bk_book using (isbn)
        where categoryid = ip_category;
    categoryshow categorydescList%rowtype;
    
begin
    dbms_output.put_line('This is books of your category');
    open categorydescList(ip_cursor);
    loop
        fetch categorydescList into categoryshow;
        dbms_output.put_line('ISBN '||categoryshow.isbn ||' title '||categoryshow.title || ' year_published ' || categoryshow.year_published);
        exit when categorydescList%notfound;
    end loop;
    dbms_output.put_line('There were ' || categorydescList%rowcount || ' books');
    close categorydescList;

exception
    when others then
        rollback;
        dbms_output.put_line(SQLERRM);
end;
/
select isbn, title, year_published,categoryid from pobyrne.bk_bookcategory right join pobyrne.bk_category using (categoryid) right join pobyrne.bk_book using (isbn);