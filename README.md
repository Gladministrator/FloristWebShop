# Flower Shop

A basic flower shop web application built with C#, .NET, and SQL.

## How to Use

    - Setup the database by creating a new database in SQL server called "Flowers" in your  SQL Server Express 2008
    - After creating the database, use the "script.sql" file and execute the code
    - Make sure SQL Server is running in Windows Services
    - Open the project solution and run the server

### Technology Stack

- C#
- ASP.NET
- SQL

### Project Goals

- Learn to integrate C# code with SQL
- Create reusable stored procedures in SQL Server
- Make a "Create, Read, Update, and Delete" app

### Design & Requirements

The application was designed to allow for new accounts to be created, updated, and allow password resets.

For the ordering page, I wanted the orders to be shown to the user as new items got added to the order. I also
wanted to ensure users could delete items from their order.

For the review orders, I needed to pull the data stored in the database and have it displayed to the end user.

### Code Architecture & Solution

For the database, creating the solution meant working on the database design, tables, primary/foreign keys, and fields required. I wanted to make sure the data could be processed into an
organized and structured way.

I used stored procedures to join tables that had referenced data in other tables. This allowed the data to be viewed in a readable format while keeping tables consistent.

I used HTTPContext for managing the session and checked to see if the session was active and if not, the user would be taken to the log in page.

### Lessons Learned

I started to learn SQL with this project and accomplished my goal of creating a basic "CRUD" app.

This was a great starter app to apply what I have learned with C# and .NET programming. I got to learn more about C# and got experience with SQL.

I'm happy with the result and will use this knowledge to continue to move forward and learn.

### What's Next?

Maybe a C# web api with a React front end... That would be cool. Will certainly be including unit tests on my next project!
