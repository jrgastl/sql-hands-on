# Author Notes: Had to rework the code after checking the solution so the data types for MySQL and SQLite are correct.
# The instructor did the extra part of the challenge in a much more elaborated way that I will  not attempt for the moment. 
# 
# Challenge 12: Copying a rows from MySQL to SQLite
# 
# Connect to both MySQL and SQLite
# Create a table on both system
# Add rows of data to the table on MySQL
# Copy the data from the MySQL table to the SQLite table
# Close both connections
# Turn it around

# Import both MySQL and SQLite libraries
import mysql.connector as mysql
import sqlite3

def main():

    # Creating the connection variables
    my_host="localhost"
    my_user="dbuser"
    my_pass="Secret"

    # To avoid warnings in case of error
    db_msql = None 
    cur_msql = None 
    db_lite = None
    cur_lite = None 

    # Storing CREATE statement in variables
    lite_create = '''
    CREATE TABLE IF NOT EXISTS gpulist (
        id INTEGER PRIMARY KEY,
        model TEXT,
        memory INTEGER,
        vendor TEXT
        )        
    '''

    msql_create = '''
    CREATE TABLE IF NOT EXISTS gpulist (
        id INT PRIMARY KEY,
        model VARCHAR(16),
        memory INT,
        vendor VARCHAR(16)
        )        
    '''

    # Storing rows in variables
    values_msql = (
        (1, 'RTX 5090', 32, 'Nvidia'),
        (2, 'RX 9070 XT', 16, 'AMD'),
        (3, 'B580', 12, 'Intel'),
                 )
    values_lite = [] # Will be later used as a buffer and converted to tuple as part of the copying process

    # Connecting to MySQL server in localhost
    try:
        db_msql = mysql.connect(host=my_host, user=my_user, password=my_pass, database='gpudata')
        cur_msql = db_msql.cursor(prepared=True) # Enable the use of prepared SQL statements for security
        print("Connected to MySQL")
    except mysql.Error as err:
        print(f"Could not connect to the MySQL data base: {err}")
        exit(1)

    # Creating MySQL table
    try:
        cur_msql.execute("DROP TABLE IF EXISTS gpulist") # Drop the table in case it already exists in the data base
        cur_msql.execute(msql_create)
        print(f'MySQL table was created')
    except mysql.Error as err:
        print(f"Could not create MySQL table: {err}")

    # Setting up SQLite
    try:
        db_lite = sqlite3.connect("./db/gpudata.db") # Creates SQLite database
        cur_lite = db_lite.cursor()
        print("SQL database created")
    except sqlite3.Error as err:
        print(f"Could not create SQLite data base: {err}")
        exit(1)

    # Creating SQLite table
    try:
        cur_lite.execute(lite_create)
        print('SQLite table created')
    except sqlite3.Error as err:
        print(f"Could not create SQLite table: {err}")
        exit(1)

    # Adding rows to MySQL table
    try:
        cur_msql.executemany("INSERT INTO gpulist VALUES(?, ?, ?, ?)", values_msql)
        cur_msql.execute("SELECT * FROM gpulist")
        for row in cur_msql:
            print(row)
        print("Rows were sucessfully added to MySQL table")
    except mysql.Error as err:
        print(f'Rows were not added to MySQL table: {err}')
    
    #db_msql.commit() # Used to check the table in the MySQL workbench

    # Copying data from MySQL table to SQLite table
    try:
        cur_msql.execute("SELECT * FROM gpulist") # Aware that this statemente could have been called only one time, but keeping like this for clarity reasons.
        for row in cur_msql:
            values_lite.append(row)
        values_lite = tuple(values_lite)
        cur_lite.executemany("INSERT INTO gpulist VALUES(?, ?, ?, ?)", values_lite)
        cur_lite.execute("SELECT * FROM gpulist")
        for row in cur_lite:
            print(row)
        print('Rows were sucessfully copied to SQLite table')
    except sqlite3.Error as err:
        print(f'Rows could not be copied: {err}')

    # db_lite.commit() # Used to check the table with sqlite3 in WSL
    
    # Drop the tables and close the connections
    cur_msql.execute("DROP TABLE IF EXISTS gpulist")
    cur_lite.execute("DROP TABLE IF EXISTS gpulist")
    cur_msql.close()
    cur_lite.close()

if __name__ == "__main__":
    main()