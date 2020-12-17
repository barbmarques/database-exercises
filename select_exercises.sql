#1-2 Use the albums_db

use albums_db;

#3 Explore the structure of the albums table

#It contains 6 fields, including data types of INT, VARCHAR, FLOAT,  one of the INTs is unsigned (positive only)

# NAME OF ALL PINK FLOYD ALBUMS: 

SELECT * 
FROM albums
WHERE ARTIST = 'Pink Floyd';


# YEAR THAT SGT. PEPPER'S LONELY HEARTS CLUB BAND WAS RELEASED
SELECT name, release_date
FROM albums 
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";


#THE GENRE FOR THE ALBUM NEVERMIND
SELECT name, genre
FROM albums
WHERE name = 'Nevermind';

#ALBUMS THAT WERE RELEASED IN THE 1990s
SELECT name, release_date                                   
FROM albums
WHERE release_date between 1990 and 1999;

#ALBUMS THAT HAD LESS THAN 20 MILLION CERTIFIED Sales
SELECT name, sales
FROM albums
WHERE sales < 20;                

#ALBUMS WITH A GENRE OF "ROCK"
SELECT name, genre
FROM albums
WHERE genre = "Rock";

# We specifically searched for "Rock".  If we wanted to find all types of Rock, we could have used genre = "Rock" or "Hard rock" or "Progressive rock"




