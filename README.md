---
title: Homework 7 - Creating A Resume Database
date: 11/12/2023
author: Feyza Sakin
format:
    gfm:
        mermaid-format: png
---

# Homework 7 - Creating A Resume Database

The following document includes a database, SQL queries, and Crow's foot diagram. The database is for a company to keep track of employees' informations, skills, and roles. SQL queries help the company to make queries such as finding the employee with the specific skill or the role. The Crow's foot shows the relationships and entities with their attributes from the database.

Some of the instructions, that we followed for the assignment:
    
     Before running the code, run "poetry install --no-root" and "poetry shell."

    .env file:
        1 - Put your username, password, and the DB name in the .env file for the hw7. 

    hw7.qmd:
        1 - To activate the VM on the hw7.qmd file is through the first block of the code.(We can see the VM name in the search bar or in the interactive tab in the VScode like this "cmsc508-fa2023-hw7-template-6R9vJwYr-ру3.11")
        
        2 - Through the second block of the code, we can connect to the DB using the credentials in the .env file. It'll print errors if there're any missing info in the .env or any wrong info.

        3 - To run the SQL code and printing the result or get an error if there's a problem:
            "```{python}
            #| echo: false
            #| eval: true
            sql = f""" <SQL code> """
            try:
                df = pd.read_sql(sql,cnx)
                df
            except Exception as e:
                message = str(e)
                print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
                df = pd.DataFrame()
            df
            ``` 
            "
            
    hw7-ddl.sql
        1 - DROP TABLE IF EXISTS table_name -> to drop a table; we can put put this command in any part of the code
    
        2 - DEFAULT 'default_value' -> to set a default value for an attribute
    
        3 - FOREIGN KEY (people_id) REFERENCES people (id) -> To set "people_id" as foreign key, which is "id" from a table called "people," for a table.
    
        4 - UNIQUE (skills_id, people_id) -> to have one skill for people and one people for one skill.

        5 - We can't set FKs, PKs, and uniques to NOT NULL.
    
To render hw7.qmd to html: quarto render hw7.qmd to --html hw7.html
