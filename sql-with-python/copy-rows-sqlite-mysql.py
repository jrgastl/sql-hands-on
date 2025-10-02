# Challenge 12 extra: Turning around and copying from SQLite to MySQL
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

    # Creating the connection variables for MySQL
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
            id SERIAL PRIMARY KEY,
            model VARCHAR(16),
            memory INT,
            vendor VARCHAR(16)
            )        
        '''

    # Storing rows in variables
    values_lite = (
        ('RTX 5090', 32, 'Nvidia'),
        ('RX 9070 XT', 16, 'AMD'),
        ('B580', 12, 'Intel'),
                 )

    # Setting up SQLite
    try:
        db_lite = sqlite3.connect("./data/gpudata.db") # Creates SQLite database
        cur_lite = db_lite.cursor()
        print("SQLite database created")
    except sqlite3.Error as err:
        print(f"Could not create SQLite database: {err}")
        exit(1)

    # Creating SQLite table
    try:
        cur_lite.execute("DROP TABLE IF EXISTS gpulist") # Drop the table in case it already exists in the database
        cur_lite.execute(lite_create)
        print('SQLite table created')
    except sqlite3.Error as err:
        print(f"Could not create SQLite table: {err}")
        exit(1)

    # Connecting to MySQL server in localhost
    try:
        db_msql = mysql.connect(host=my_host, user=my_user, password=my_pass, database='gpudata')
        cur_msql = db_msql.cursor(prepared=True) # Enable the use of prepared SQL statements for security
        print("Connected to MySQL")
    except mysql.Error as err:
        print(f"Could not connect to the data base: {err}")
        exit(1)

    # Creating MySQL table
    try:
        cur_msql.execute("DROP TABLE IF EXISTS gpulist") # Drop the table in case it already exists in the database
        cur_msql.execute(msql_create)
        print(f'MySQL table was created')
    except mysql.Error as err:
        print(f"Could not create MySQL table: {err}")


    # Adding rows to SQLite
    try:
        cur_lite.executemany("INSERT INTO gpulist (model, memory, vendor) VALUES (?, ?, ?)", values_lite)
        db_lite.commit()
        cur_lite.execute("SELECT * FROM gpulist")
        for row in cur_lite:
            print(row)
        print("Rows were sucessfully added to SQLite table")
    except sqlite3.Error as err:
        print(f'Rows were not added to SQLite table: {err}')

    # Copying data from SQLite table to MySQL table
    try:
        cur_lite.execute("SELECT * FROM gpulist")
        for row in cur_lite:
            cur_msql.execute("INSERT INTO gpulist (model, memory, vendor) VALUES(?, ?, ?)", (row[1:]))
        db_msql.commit()
        cur_msql.execute("SELECT * FROM gpulist")
        for row in cur_msql:
            print(row)
        print('Rows were sucessfully copied to MySQL table')
    except sqlite3.Error as err:
        print(f'Rows could not be copied to MySQL table: {err}')

    # db_msql.commit() # Used to check the table in the MySQL workbench
    
    # Drop the tables and close the connections
    cur_msql.execute("DROP TABLE IF EXISTS gpulist")
    cur_lite.execute("DROP TABLE IF EXISTS gpulist")
    cur_msql.close()
    cur_lite.close()

if __name__ == "__main__":
    main()