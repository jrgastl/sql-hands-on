# SQL Hands-on Challenges  

## Status  

[Learning Path][url_learning_path] in Progress!

## Welcome  

This is my repository to document the process of advancing my skills in SQL. It contains the queries I implemented to solve the challenges contained in the learning path [Advance Your Skills in SQL][url_learning_path] in LinkedIn. In this README you can find the list of challenges with a brief description and the folder structure for the repository. If you want give any suggestions, comments or just have a conversation about it or any topic, please, approach me in [LinkedIn][url_profile] or by [e-mail][email].  

## List of Challenges

### 1. SQL Hands-On Practice: Solve Business Problems  

Challenges from the course [SQL Hands-On Practice: Solve Business Problems][url_sql_business_problems].  
  
|Challenge|File|Description|Brief summary of skills learned|
|-|-|-|-|
|1|descriptive_statistics_cte.sql|Use CTE and aggregate functions to properly aggregate data|aggregate fucntions combined with CTE|
|2|variable_distributions_cte.sql|Use CTE and aggregate functions to get data distribution|aggregate fucntions combined with CTE|
|3|funnel_analysis_cte.sql|Use CTE, CASE expression and aggregate functions to do a payment funnel analysis|aggregate functions combine with CTE, CASE expression|
|4|binary_columns_case.sql|Use CASE expression to flag relevant data in a binary form|CASE expression|
|5|aggregated_columns_case.sql|Use CASE expression to pivot a table|CASE expression|
|6|combine_tables_union.sql|Combine rows of multiple tables with UNION set operator|UNION operator|
|7|unpivoting_columns_union.sql|Get the data of multiple columns in one column with UNION|UNION operator, CAST function|
|8|hierarchy_data_selfjoin.sql|Join a table to itself in order to establish hierarchical relashionships|JOIN operator|
|9|comparing_rows_selfjoin.sql|Join a table to itself to compare data|JOIN operator|
|10|runningtotals_windowfunctions.sql|Calculate running totals using window functions|window functions|
|11|timestamps_windowfunctions.sql|Calculate duration between instances with window functions|window functions, LEAD function|  

### 2. Using SQL with Python  

Challenges from the course [Using SQL with Python][url_sql_python]  

|Challenge|File|Description|Brief summary of skills learned|
|-|-|-|-|
|12|copy-rows-mysql-sqlite.py|Copying rows from MySQL table to SQLite table|mysql-connector-python, SQL statements in Python|  
|12 extra|copy-rows-sqlite-mysql.py|Copying rows from SQLite table to MySQL table|mysql-connector-python, SQL statements in Python|
|13|short-url-list.py|Script to manage a short URL database|CRUD operations with python SQL wrapper|

## Folder Structure  

```plaintext
sql-hands-on
└── sql-business-problems
    ├── descriptive_statistics_cte.sql              #Challenge 1
    ├── variable_distributions_cte.sql              #Challenge 2
    ├── funnel_analysis_cte.sql                     #Challenge 3
    ├── binary_columns_case.sql                     #Challenge 4
    ├── aggregated_columns_case.sql                 #Challenge 5
    ├── combine_tables_union.sql                    #Challenge 6
    ├── unpivoting_columns_union.sql                #Challenge 7
    ├── hierarchy_data_selfjoin.sql                 #Challenge 8
    ├── comparing_rows_selfjoin.sql                 #Challenge 9
    ├── runningtotals_windowfunctions.sql           #Challenge 10
    └── timestamps_windowfunctions.sql              #Challenge 11
└── sql-with-python
    ├── copy-rows-mysql-sqlite.py                   #Challenge 12
    ├── copy-rows-sqlite-mysql.py                   #Challenge 12 extra
    ├── short-url-list.py                           #Challenge 13
    ├── library
        └── BWDB.py                                 #Instructor library
    └── data                                        #Folder for storing SQLite databases
```  

Author: Ricardo Gastl

[url_learning_path]:https://www.linkedin.com/learning/paths/advance-your-skills-in-sql
[email]:mailto:jrgastl@gmail.com
[url_profile]:https://www.linkedin.com/in/ricardogastl/
[url_sql_business_problems]:https://www.linkedin.com/learning/sql-hands-on-practice-solve-business-problems
[url_sql_python]:https://www.linkedin.com/learning/using-sql-with-python/use-sql-with-python
