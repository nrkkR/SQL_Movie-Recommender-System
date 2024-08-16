# Movie Recommender System using Oracle SQL

## Overview

This project is a **Movie Recommender System** built using Oracle SQL. It leverages SQL queries to analyze user ratings of movies and generate personalized movie recommendations. The system identifies users with similar tastes and recommends movies that these similar users have liked but the target user has not yet rated.

## Features

- **User and Movie Management**: Simple tables for managing users and movies.
- **Ratings Storage**: Users can rate movies on a scale of 1 to 5, with the ratings stored in a relational table.
- **Similarity Calculation**: Identifies users with similar movie ratings using SQL queries.
- **Movie Recommendations**: Recommends movies to users based on the ratings from similar users.

## Technologies Used

- **Oracle SQL**: The core database technology used to create tables, manage data, and run recommendation queries.
- **SQL Concepts**:
  - **Joins**: Used to combine data from multiple tables based on related columns.
  - **Common Table Expressions (CTEs)**: Simplifies complex queries by breaking them into manageable parts.
  - **Subqueries**: Embedded queries within a larger query to refine results.
  - **Aggregate Functions**: Used to calculate the average ratings for recommendations.

## Usage Instructions

### 1. Setting Up the Database

1. **Connect to Oracle SQL**:
   - Use SQL*Plus or any other SQL command-line tool.
   - Connect as `SYS AS SYSDBA` using your Oracle credentials.

2. **Run the SQL Script**:
   - Execute the SQL script file `movie_recommender.sql` to create the necessary tables and populate them with initial data.

### 2. Running the Recommender System

1. **Calculate Similarity**:
   - Use the provided SQL query in the `movie_recommender.sql` file to calculate user similarity based on their movie ratings.

2. **Get Movie Recommendations**:
   - Run the recommendation query provided in the `movie_recommender.sql` file to get personalized movie suggestions for a specific user.

### 3. Expanding the System

- **Add More Data**: Expand the dataset by adding more users, movies, and ratings.
- **Refine Queries**: Adjust the queries to refine the recommendations, such as focusing on genres or recent ratings.
- **Integrate with Applications**: The SQL-based system can be integrated with frontend applications for a complete user experience.

## Concepts Used

- **Relational Database Management**: Core concepts of relational databases such as tables, primary keys, foreign keys, and joins.
- **Data Analysis**: Leveraging SQL for data analysis to identify patterns and generate insights.
- **Recommendation Systems**: Understanding the basics of recommendation systems and implementing a simple version using SQL.

## Credits

- **Author**: [Rajdeep Mondal](https://www.linkedin.com/in/rajdeep-mondal-123456789/)
- **GitHub Repository**: [Your GitHub Profile](https://github.com/nrkkR)

This project is an example of how SQL can be used to build a simple, yet effective, movie recommendation system. It serves as a foundational project for understanding how data analysis and recommendation algorithms work in a database context.
