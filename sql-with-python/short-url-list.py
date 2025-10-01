from library.BWDB import BWDB, BWErr # importing library created by the instructor
import os
import sys

GLOBALS = {} # storing variables in this dictionary

# = Database connection =
def connect():
    try:
        db = BWDB(dbms='sqlite',database='./data/jurl.db') # creating a connection usign the wrapper created by the instructor
        print("Database connected.")
    except BWErr as err:
        print(f'Could not connect to the database: {err}')
        sys.exit(1)

    GLOBALS['db'] = db
    return db

# = Menu =
def to_menu(message):
    show_list()
    print(f"\nMESSAGE: {message} \n")
    print("| a : add URL | e : edit URL | d : delete URL | c : clear table | q : quit |")
    selection = input("Select > ")
    if selection in 'Aa':
        add_url()
    elif selection in 'Ee':
        edit_url()
    elif selection in 'Dd':
        del_url()
    elif selection in 'Cc':
        clear_table()
    elif selection in 'Qq':
        sys.exit(0)
    else:
        clear_screen()
        to_menu(f"\"{selection}\" is not an option.")
    
def show_list(): # show all entries
    db = GLOBALS['db']
    for row in db.get_rows():
        print(row)

# = Menu options =
def add_url():# add url to the database selection
    clear_screen()
    target_url = input("Type target URL, leave empty to cancel> ")
    if target_url == "":
        to_menu("Operation canceled.")
    short_url = input("Type short URL > ")
    if short_url == "":
        to_menu("Invalid short URL.")
    insert_row = (short_url,target_url)
    db = GLOBALS['db']
    db.begin_transaction()
    db.add_row_nocommit(insert_row)
    print(f"The short URL \"{short_url}\" will be added to the list.")
    confirm_commit(db, f"\"{short_url}\" was added.", f"\"{short_url}\" could not be added.")

def edit_url():# edit an url in the database selection 
    short_URL = input("Type short URL to be edited, leave empty to cancel > ")
    if short_URL == "":
        clear_screen()
        to_menu('Operation canceled.')
    db = GLOBALS['db']
    edit_rowid = db.find_row('shortURL', short_URL)
    if edit_rowid is None:
        print("URL not found.")
        edit_url()
    else:
        target_URL = input("Type new target URL > ")
        db.begin_transaction()
        db.update_row_nocommit(edit_rowid,{'targetURL':target_URL})
        print(f"The short URL \"{short_URL}\" will be updated with \"{target_URL}\".")
        confirm_commit(db, f"\"{short_URL}\" was changed.", f"\"{short_URL}\" could not be changed.")

def del_url():# delete an url from the database selection
    to_delete = input("Type short URL to be deleted, leave empty to cancel > ")
    if to_delete == "":
        clear_screen()
        to_menu('Operation canceled.')
    db = GLOBALS['db']
    del_rowid = db.find_row('shortURL', to_delete)
    if del_rowid is None:
        print("URL not found.")
        del_url()
    else:
        db.begin_transaction()
        db.del_row_nocommit(del_rowid)
        print(f"The short URL \"{to_delete}\" will be deleted from the list.")
        confirm_commit(db, f"\"{to_delete}\" was deleted.", f"\"{to_delete}\" could not be deleted.")

def clear_table():# delete the tables and exit selection
    confirm = input("Clear all data and quit? [Y or N] > ")
    if confirm in 'Yy':
        db = GLOBALS['db']
        db.sql_do("DROP TABLE IF EXISTS jurl")
        print("Data was cleared.")
        sys.exit(0)
    elif confirm in 'Nn':
        to_menu('Operation canceled')
    else:
        print(f"{confirm} is not a valid option.")
        clear_table()

# = Utilities =
def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def confirm_commit(db, yes_message, error_message):
    confirmation = input("Confirm? [Y or N] > ")
    if confirmation in 'Yy':
        try:
            db.commit()
            clear_screen()
            to_menu(yes_message)
        except BWErr as err:
            print(f"{error_message}: {err}")
            sys.exit(1)
    elif confirmation in 'Nn':
        db.rollback()
        clear_screen()
        to_menu('Operation canceled.')
    else:
        print('Invalid option.')
        confirm_commit(db, yes_message, error_message)

# = Main function =
def main():
    connect()
    db = GLOBALS['db']

    # create table and set some default values
    table_exists = db.have_table('jurl')
    create_table = '''
                   CREATE TABLE IF NOT EXISTS jurl (
                        id integer PRIMARY KEY,
                        shortURL VARCHAR(32) UNIQUE NOT NULL,
                        targetURL VARCHAR(128) NOT NULL
                        );
                '''
    default_data = [('snake', 'https://github.com/jrgastl/levelup-python-challenges'),
                    ('penguin', 'https://github.com/jrgastl/linux-bash-challenges'),
                     ('owl', 'https://github.com/jrgastl/sql-hands-on'),
                     ('ricardo', 'https://www.linkedin.com/in/ricardogastl/'),
                     ('elgoog', 'https://www.google.com/')]
    try:
        db.sql_do(create_table)
        print("Table connected.")
    except BWErr as err:
        print(f"Table could not be created: {err}")
        sys.exit(1)
    
    db.table = 'jurl'
    if table_exists == False:
        try:
            db.sql_do_many('INSERT INTO jurl (shortURL, targetURL) VALUES (?, ?)', parms=default_data)
        except BWErr as err:
            print(f"Default values could not be loaded")
            sys.exit(1)
    to_menu(f"Total entries > {db.count_rows()}")

if __name__ == '__main__': # executing the script
    main()

