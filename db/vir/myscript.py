import cx_Oracle  # import the Oracle Python library
import getpass
import pandas as pd

# p_username = "dt2283group_q"  # define the login details
# p_username = "d19123678"
p_username = "JKim"
print("username:", p_username)
# Password for dt2283_group_q is SoC$_dt22812345678
p_password = getpass.getpass("password: ")  # Accepts a password without showing it.
p_host = "132.145.215.49"
p_service = "PDB1.sub03101424270.tudublinstudent.oraclevcn.com"
p_port = "1521"
# create the connection
# p_qty = input("How Many")
# p_code = input("Enter Stock Code")
# p_staff_no = input("Enter Staff No")

try:
    con = cx_Oracle.connect(user=p_username,
                            password=p_password,
                            dsn=p_host + "/" + p_service + ":" + p_port)
    print("Database version:", con.version)
    print("Oracle Python version:", cx_Oracle.version)
    cur = con.cursor()
    # execute a query returning the results to the cursor
    t_isbn = input("PUT ISBN: ")
    t_categoryid = input("PUT categoryID: ")

    try:
        FunctionStatus = cur.callfunc('JKim.find_book', bool, [t_isbn, t_categoryid])
        # cur.execute('select * from pobyrne.bk_bookcategory where ')
        if FunctionStatus == True:
            print("Exist")
        else:
            print("Not Exist")

    except cx_Oracle.DatabaseError as e:
        errorObj, = e.args
        print("There was a database error")
        print("Error Code:", errorObj.code)
        print("Error Message:", errorObj.message)
    else:
        for row in cur:
            print("Table: ", row)
    cur.close()

    # close the connection to the database
    con.close()
except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError) as e:
    errorObj, = e.args
    print("There was a database error")
    print("Error Code:", errorObj.code)
    print("Error Message:", errorObj.message)

    print('The database connection failed')
# try:
#     con = cx_Oracle.connect(user=p_username,
#                             password=p_password,
#                             dsn=p_host + "/" + p_service + ":" + p_port)
#     print("Database version:", con.version)
#     print("Oracle Python version:", cx_Oracle.version)
#     cur = con.cursor()
#     # execute a query returning the results to the cursor
#
#     try:
#         cur.execute('select view_name from user_views')
#     except cx_Oracle.DatabaseError as e:
#         errorObj, = e.args
#         print("There was a database error")
#         print("Error Code:", errorObj.code)
#         print("Error Message:", errorObj.message)
#     else:
#         if cur.rowcount == 0:
#             for row in cur:
#                 print("View: ", row)
#         else:
#             print("No views in schema.")
#     cur.close()
#
#     # close the connection to the database
#     con.close()
# except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError):
#
#     print('The database connection failed')
#
# # In[5]:
#
#
# # create the connection
# try:
#     con = cx_Oracle.connect(user=p_username,
#                             password=p_password,
#                             dsn=p_host + "/" + p_service + ":" + p_port)
#     print("Database version:", con.version)
#     print("Oracle Python version:", cx_Oracle.version)
#     cur = con.cursor()
#     # execute a query returning the results to the cursor
#
#     try:
#         cur.execute('select table_name from user_tables')
#     except cx_Oracle.DatabaseError as e:
#         errorObj, = e.args
#         print("There was a database error")
#         print("Error Code:", errorObj.code)
#         print("Error Message:", errorObj.message)
#     else:
#         if cur.rowcount == 0:
#             for row in cur:
#                 print("Table: ", row)
#         else:
#             print("No tables in schema.")
#     cur.close()
#
#     # close the connection to the database
#     con.close()
# except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError):
#
#     print('The database connection failed')
#
# # In[4]:
#
#
# # create the connection
# try:
#     con = cx_Oracle.connect(user=p_username,
#                             password=p_password,
#                             dsn=p_host + "/" + p_service + ":" + p_port)
#     print("Database version:", con.version)
#     print("Oracle Python version:", cx_Oracle.version)
#     cur = con.cursor()
#     # execute a query returning the results to the cursor
#
#     try:
#         df = pd.read_sql_query("SELECT * from pobyrne.p_student", con)
#         # print the records returned by query and stored in panda
#         print(df.head())
#     except cx_Oracle.DatabaseError as e:
#         errorObj, = e.args
#         print("There was a database error")
#         print("Error Code:", errorObj.code)
#         print("Error Message:", errorObj.message)
#
#     cur.close()
#
#     # close the connection to the database
#     con.close()
# except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError):
#
#     print('The database connection failed')
#
# # In[9]:
#
#
# prog_code = input("Programme Code:")
# stage_code = input("Stage Code:")
# sname = input("Student Name")
# saddr = input("Student Address")
#
# try:
#     con = cx_Oracle.connect(user=p_username,
#                             password=p_password,
#                             dsn=p_host + "/" + p_service + ":" + p_port)
#     print("Database version:", con.version)
#     print("Oracle Python version:", cx_Oracle.version)
#     cur = con.cursor()
#     try:
#         new_student_id = cur.callfunc('pobyrne.addstudent', str,
#                                       [prog_code, stage_code, sname, saddr])
#         print("Student ", new_student_id, " added.")
#     except cx_Oracle.DatabaseError as e:
#         errorObj, = e.args
#         print("There was a database error")
#         print("Error Code:", errorObj.code)
#         print("Error Message:", errorObj.message)
#     cur.close()
#     con.close()
# except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError)as e:
#     errorObj, = e.args
#     print("There was a database error")
#     print("Error Code:", errorObj.code)
#     print("Error Message:", errorObj.message)
#     print('The database connection failed')
#
# # In[ ]:
#



