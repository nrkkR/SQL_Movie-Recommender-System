-- Movie Recommender System SQL Script

-- 1. Drop existing tables (if they exist)
DROP TABLE Ratings CASCADE CONSTRAINTS;
DROP TABLE Users CASCADE CONSTRAINTS;
DROP TABLE Movies CASCADE CONSTRAINTS;

-- 2. Create the Movies table
CREATE TABLE Movies (
    movie_id NUMBER PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    genre VARCHAR2(100)
);

-- 3. Create the Users table
CREATE TABLE Users (
    user_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

-- 4. Create the Ratings table
CREATE TABLE Ratings (
    user_id NUMBER NOT NULL,
    movie_id NUMBER NOT NULL,
    rating NUMBER CHECK (rating BETWEEN 1 AND 5),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- 5. Insert data into Movies table
INSERT INTO Movies (movie_id, title, genre) VALUES (1, 'The Matrix', 'Action');
INSERT INTO Movies (movie_id, title, genre) VALUES (2, 'Inception', 'Sci-Fi');
INSERT INTO Movies (movie_id, title, genre) VALUES (3, 'The Godfather', 'Crime');
INSERT INTO Movies (movie_id, title, genre) VALUES (4, 'The Dark Knight', 'Action');
INSERT INTO Movies (movie_id, title, genre) VALUES (5, 'Pulp Fiction', 'Crime');
INSERT INTO Movies (movie_id, title, genre) VALUES (6, 'Interstellar', 'Sci-Fi');
INSERT INTO Movies (movie_id, title, genre) VALUES (7, 'Fight Club', 'Drama');
INSERT INTO Movies (movie_id, title, genre) VALUES (8, 'Forrest Gump', 'Drama');
INSERT INTO Movies (movie_id, title, genre) VALUES (9, 'The Lord of the Rings: The Fellowship of the Ring', 'Fantasy');
INSERT INTO Movies (movie_id, title, genre) VALUES (10, 'The Shawshank Redemption', 'Drama');

-- 6. Insert data into Users table
INSERT INTO Users (user_id, name) VALUES (1, 'Alice');
INSERT INTO Users (user_id, name) VALUES (2, 'Bob');
INSERT INTO Users (user_id, name) VALUES (3, 'Charlie');
INSERT INTO Users (user_id, name) VALUES (4, 'David');
INSERT INTO Users (user_id, name) VALUES (5, 'Eve');
INSERT INTO Users (user_id, name) VALUES (6, 'Frank');
INSERT INTO Users (user_id, name) VALUES (7, 'Grace');
INSERT INTO Users (user_id, name) VALUES (8, 'Heidi');
INSERT INTO Users (user_id, name) VALUES (9, 'Ivan');
INSERT INTO Users (user_id, name) VALUES (10, 'Judy');

-- 7. Insert data into Ratings table
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (1, 1, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (1, 2, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (1, 3, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (2, 1, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (2, 2, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (2, 4, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (3, 3, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (3, 4, 3);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (4, 1, 3);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (4, 4, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (4, 5, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (5, 2, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (5, 3, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (5, 5, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (6, 1, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (6, 6, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (7, 7, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (7, 8, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (8, 9, 4);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (9, 10, 5);
INSERT INTO Ratings (user_id, movie_id, rating) VALUES (10, 4, 4);

-- 8. Calculate user similarity
WITH Similarity AS (
    SELECT
        r1.user_id AS user1,
        r2.user_id AS user2,
        COUNT(*) AS common_ratings
    FROM
        Ratings r1
        JOIN Ratings r2 ON r1.movie_id = r2.movie_id
    WHERE
        r1.rating = r2.rating
        AND r1.user_id != r2.user_id
    GROUP BY
        r1.user_id, r2.user_id
)
SELECT * FROM Similarity ORDER BY common_ratings DESC;

-- 9. Generate movie recommendations
WITH SimilarUsers AS (
    SELECT
        r1.user_id AS target_user,
        r2.user_id AS similar_user,
        r2.movie_id,
        r2.rating
    FROM
        Ratings r1
        JOIN Ratings r2 ON r1.movie_id = r2.movie_id
    WHERE
        r1.rating = r2.rating
        AND r1.user_id != r2.user_id
),
Recommendations AS (
    SELECT
        su.target_user,
        m.title,
        AVG(su.rating) AS avg_rating
    FROM
        SimilarUsers su
        JOIN Movies m ON su.movie_id = m.movie_id
    WHERE
        su.movie_id NOT IN (
            SELECT movie_id FROM Ratings WHERE user_id = su.target_user
        )
    GROUP BY
        su.target_user, m.title
    ORDER BY
        avg_rating DESC
)
SELECT * FROM Recommendations WHERE target_user = 1;
